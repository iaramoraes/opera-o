# N8N Workflows — Suporte Unificado Seazone

## Visão Geral
Total: 8 workflows necessários no N8N (automation.seazone.com.br)

---

## WF-01: Receber Suporte do Slack
**Trigger:** Webhook (Slack envia quando formulário é preenchido)
**Fluxo:**
1. Recebe dados do formulário (solicitante, código imóvel, área, processo, urgência, descrição)
2. Valida código do imóvel (se informado)
3. Chama WF-02 (IA)
4. Se IA detectar duplicidade → responde no Slack com link do card existente, NÃO cria card
5. Se IA sugerir área diferente → responde no Slack com sugestão
6. Se ok → chama WF-03 (criar card)

**Input:** JSON do Slack (formulário)
**Output:** Card criado ou mensagem de duplicidade

---

## WF-02: IA — Análise Pré-Abertura
**Trigger:** Chamado pelo WF-01
**Fluxo:**
1. Recebe código imóvel + descrição + área + processo
2. Busca histórico do imóvel (Nekt/Lovable): suportes abertos, concluídos recentes
3. Verifica duplicidade: mesmo imóvel + mesmo processo com card aberto?
4. Analisa descrição: a área selecionada faz sentido? Sugere correção se não
5. Busca na base de conhecimento (RAG): tem procedimento padrão pra essa demanda?
6. Se tem resposta padrão → tenta deflexão (responde direto sem abrir card)
7. Retorna: { duplicado: bool, area_sugerida: string, confianca: float, historico_imovel: [], deflexao: bool, resposta_deflexao: string, resumo_ia: string }

**Fontes de dados:** Nekt (BigQuery), Lovable (API), Base de conhecimento (RAG)
**Output:** Análise completa para WF-01 decidir

---

## WF-03: Criar Card na Lovable
**Trigger:** Chamado pelo WF-01 (quando aprovado)
**Fluxo:**
1. Recebe dados do suporte + análise da IA
2. POST na API da Lovable → cria card no board da área correta
3. Card contém: código imóvel, processo, urgência, descrição, solicitante, resumo IA, histórico imóvel
4. Recebe ID do card + link
5. Chama WF-04 (notificações)
6. Registra timestamp de abertura (pra SLA)

**Input:** Dados do suporte + análise IA
**Output:** Card ID + link Lovable

---

## WF-04: Notificações Slack
**Trigger:** Chamado pelo WF-03 (abertura) e WF-05 (atualização)
**Fluxo para ABERTURA:**
1. Cria thread no #suporte-operacao com resumo do suporte
2. Envia DM pro solicitante: "Suporte #SUP-XXXX criado! Links: [thread] [card Lovable]"
3. Envia DM pro responsável do fluxo: "Novo suporte na sua área"
4. Se urgência = Crise → notifica gerente da área também

**Fluxo para ATUALIZAÇÃO:**
1. Atualiza thread no #suporte-operacao com novo status
2. Envia DM pro solicitante: "Suporte #SUP-XXXX atualizado: [novo status]"

**Fluxo para CONCLUSÃO:**
1. Atualiza thread com devolutiva
2. Envia DM pro solicitante: "Suporte #SUP-XXXX concluído! Resumo: [devolutiva]"

**Input:** Tipo (abertura/atualização/conclusão) + dados do card
**Output:** Mensagens enviadas no Slack

---

## WF-05: Escutar Mudanças na Lovable
**Trigger:** Webhook da Lovable (quando card muda de status, recebe comentário, é transferido)
**Fluxo:**
1. Recebe evento da Lovable (card_id, novo_status, comentário, transferência)
2. Se mudança de status → chama WF-04 (notificação atualização)
3. Se comentário na Lovable → posta na thread do Slack
4. Se transferência entre áreas → notifica novo responsável + atualiza thread
5. Se conclusão → chama WF-04 (notificação conclusão)

**Input:** Webhook Lovable
**Output:** Ações no Slack via WF-04

---

## WF-06: Monitoramento SLA
**Trigger:** Cron (a cada 30 minutos)
**Fluxo:**
1. Busca na Lovable: cards abertos com timestamp
2. Calcula tempo desde abertura vs SLA da urgência (Crise 4h, Alta 12h, Média 24h, Baixa 24h)
3. Se SLA em 80% → lembrete pro responsável do fluxo (DM)
4. Se SLA estourado → alerta pro gerente da área (DM + mensagem na thread)
5. Atualiza badge de SLA no card da Lovable

**Input:** Query Lovable (cards abertos)
**Output:** Alertas no Slack + atualização Lovable

---

## WF-07: Resumo Diário
**Trigger:** Cron (18h, segunda a sexta)
**Fluxo:**
1. Busca na Lovable: todos os cards do dia (novos, concluídos, em andamento, SLA estourado)
2. Agrupa por área
3. Calcula métricas: tempo médio resolução, taxa deflexão IA, SLA cumprido %
4. Monta mensagem formatada
5. Posta no #suporte-operacao

**Formato da mensagem:**
```
📊 Resumo do Dia — DD/MM/AAAA

Implantação: X novos | Y concluídos | Z SLA estourado
Franquias: X novos | Y concluídos | Z SLA estourado
Hóspede: X novos | Y concluídos | Z SLA estourado
Proprietários: X novos | Y concluídos | Z SLA estourado

Total: XX suportes | Tempo médio: Xh | Deflexão IA: X% | SLA cumprido: X%
```

**Input:** Query Lovable
**Output:** Mensagem no #suporte-operacao

---

## WF-08: Sync Comentários Slack → Lovable
**Trigger:** Evento Slack (nova mensagem em thread de suporte)
**Fluxo:**
1. Detecta novo comentário em thread de suporte (identificada pelo bot message)
2. Identifica card_id associado à thread
3. POST na API Lovable → adiciona comentário no card
4. Se for cobrança (solicitante comentando) → notifica responsável do fluxo

**Input:** Evento Slack (message in thread)
**Output:** Comentário adicionado no card Lovable

---

## Conexões Necessárias no N8N

### Credentials a configurar:
1. **Slack Bot Token** — para enviar mensagens, criar threads, DMs
2. **Slack Event Subscription** — para escutar mensagens em threads
3. **Lovable API** — para criar/atualizar cards, buscar dados
4. **Nekt/BigQuery** — para consultas de histórico
5. **OpenAI/Claude API** — para análise IA (deflexão, sugestão área, resumo)

### Variáveis de ambiente:
- SLACK_CHANNEL_SUPORTE = C0AM2DBTRT5
- LOVABLE_API_URL = (definir após criar app)
- NEKT_API_URL = nekt-mcp.seazone.com.br
- SLA_CRISE = 4
- SLA_ALTA = 12
- SLA_MEDIA = 24
- SLA_BAIXA = 24

---

## Ordem de Criação dos Workflows

1. WF-03 (Criar Card) — mais simples, testa conexão Lovable
2. WF-04 (Notificações) — testa conexão Slack
3. WF-01 (Receber Suporte) — junta WF-03 + WF-04
4. WF-05 (Escutar Lovable) — webhook reverso
5. WF-08 (Sync Comentários) — complementa bidirecional
6. WF-06 (SLA) — cron independente
7. WF-07 (Resumo Diário) — cron independente
8. WF-02 (IA) — mais complexo, por último
