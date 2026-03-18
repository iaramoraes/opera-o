# Prompt para criar o app no Lovable

Cole o texto abaixo ao criar um novo projeto no Lovable:

---

## PROMPT:

Crie uma aplicação web completa chamada **"Suporte Unificado — Seazone Operação"** para gestão de suporte interno de uma empresa de gestão de imóveis por temporada.

### IDENTIDADE VISUAL

Siga a identidade visual da Seazone (www.seazone.com.br):

**Cores principais:**
- Primária: `#011337` (azul-marinho escuro)
- Destaque: `#0D4BD0` (azul vibrante)
- Accent: `#F1605D` (coral/vermelho — botões de ação)
- Background: `#FAFAFA` (cinza claro)
- Sucesso: `#047755` (verde)
- Erro: `#FF2732` (vermelho)
- Alerta: `#FF9900` (laranja)

**Cores por área (tags e badges):**
- Implantação: `#F0883E` (laranja)
- Franquias: `#0D4BD0` (azul)
- Hóspede: `#047755` (verde)
- Proprietários: `#7C3AED` (roxo)

**Estilo:**
- Design moderno, limpo e profissional
- Cards com sombras suaves, border-radius 8px
- Fonte: Inter ou Segoe UI (pesos 400, 500, 600, 700)
- Botões primários em coral `#F1605D`, secundários em branco com borda
- Layout responsivo, sidebar fixa à esquerda
- Header com logo "Seazone" + nome da aplicação
- Ícones: Lucide React

### ESTRUTURA DA APLICAÇÃO

A aplicação tem **7 páginas principais** acessíveis pela sidebar:

---

#### PÁGINA 1: Dashboard (Home)

Visão geral com métricas em tempo real:
- Cards de métricas no topo: Total abertos, Concluídos hoje, Tempo médio resolução, Deflexão IA (%), SLA estourado
- Gráfico de volume por área (barras empilhadas por dia/semana/mês)
- Gráfico de SLA cumprido vs estourado (pizza)
- Lista "Top 10 imóveis com mais suportes"
- Lista "Processos mais recorrentes"
- Filtros: período (hoje, 7 dias, 30 dias, personalizado), área

---

#### PÁGINA 2: Kanban

Board estilo Kanban com 5 colunas: **Novo → Em Andamento → Aguardando → Concluído → Arquivado**

**Funcionalidades:**
- Abas no topo para filtrar por área: Todas | Implantação | Franquias | Hóspede | Proprietários
- Cada card mostra: código do imóvel (destaque), título do suporte, tags (área + urgência + IA), avatar + nome do responsável, indicador de SLA (verde/amarelo/vermelho)
- Drag and drop para mover cards entre colunas
- Clicar no card abre painel lateral (slide-in da direita) com detalhes completos:
  - Dados do card (imóvel, área, processo, urgência, solicitante, responsável, datas)
  - Insight da IA (se houver)
  - Outros suportes do mesmo imóvel (visão cruzada)
  - Timeline/histórico de ações
  - Campo de comentários
  - Botões: mover status, transferir área, marcar "IA errou"
- Filtros na toolbar: urgência, responsável, processo, SLA estourado, com IA
- Busca por código do imóvel ou responsável
- Botão "+ Novo Suporte"

**Cards com urgência "Crise!" devem ter borda vermelha pulsante.**

---

#### PÁGINA 3: Meus Suportes

Lista filtrada dos suportes que o usuário logado abriu (como solicitante):
- Tabela com colunas: #ID, Imóvel, Processo, Área, Status, Urgência, Aberto em, Responsável
- Cada linha clicável → abre detalhe
- Badge de status com cor (Novo=azul, Andamento=laranja, Aguardando=amarelo, Concluído=verde, Arquivado=cinza)
- Filtros: status, área, período

---

#### PÁGINA 4: Resumo por Imóvel

Busca por código do imóvel → mostra ficha completa:
- Header com código do imóvel, franquia, proprietário, status
- Cards de métricas: total suportes, abertos agora, tempo médio resolução
- Lista de TODOS os suportes do imóvel (todas as áreas), ordenados por data
- Cada suporte com: área (badge colorido), processo, status, responsável, data
- Insight da IA: alertas (múltiplos suportes simultâneos, score churn, frequência acima da média)
- Gráfico: timeline de suportes nos últimos 6 meses

---

#### PÁGINA 5: Configuração de Fluxos (Painel de Controle)

**Acesso: Gerentes e Iara**

Gerenciar áreas, processos e formulários:
- 4 abas (uma por área): Implantação | Franquias | Hóspede | Proprietários
- Dentro de cada aba:
  - Lista de processos com toggle ativo/inativo
  - Botão "+ Novo Processo"
  - Clicar no processo → editar: nome, campos do formulário (adicionar/remover/reordenar campos), responsável padrão
  - Cada campo tem: nome, tipo (texto, dropdown, número, data, checkbox, anexo), obrigatório sim/não, opções (se dropdown)
- Seção de SLAs: editar tempos por urgência (Crise, Alta, Média, Baixa) — campos numéricos em horas
- Seção de responsáveis: definir responsável de cada processo (dropdown de usuários)
- **Tudo que for editado aqui deve refletir no formulário de abertura de suporte**
- Log de alterações (quem mudou o quê, quando)

---

#### PÁGINA 6: Relatórios

**3 sub-abas:** Diário | Semanal | Mensal

Cada relatório mostra:
- Resumo por área: novos, concluídos, em andamento, SLA estourado
- Tempo médio de resolução por área e por processo
- Taxa de deflexão IA
- Ranking de imóveis com mais suportes
- Ranking de processos mais recorrentes
- Transferências entre áreas (indica erro de classificação)
- Gráfico de tendência (volume subindo/descendo)
- Botão "Exportar PDF"

---

#### PÁGINA 7: Configurações

- Perfil do usuário
- Gerenciar usuários e permissões:
  - 3 perfis: Visualizador (qualquer colaborador), Responsável de Fluxo, Gerente
  - Associar pessoas a perfis e áreas
- Integrações: status de conexão com Slack, N8N, Pipefy, Nekt
- Botão "Importar histórico do Pipefy" (upload ou conexão API)
- Configurações gerais: horário resumo diário, timezone

---

### SIDEBAR

Sidebar fixa à esquerda, colapsável:
- Logo Seazone no topo
- Links: Dashboard, Kanban, Meus Suportes, Resumo por Imóvel, Fluxos (só gerente), Relatórios, Configurações
- Badge de notificação no Kanban (número de SLA estourados)
- Avatar do usuário logado no rodapé
- Tema claro por padrão

---

### MODELO DE DADOS

**Tabelas principais:**

```
areas: id, nome, cor, gerente_id, ativo
processos: id, area_id, nome, campos_json, responsavel_id, ativo, ordem
cards: id, codigo_imovel, area_id, processo_id, solicitante_id, responsavel_id, urgencia, status, descricao, resumo_ia, sla_deadline, created_at, updated_at, concluded_at
comentarios: id, card_id, autor_id, texto, created_at, via (slack/lovable)
historico: id, card_id, acao, autor_id, detalhes, created_at
usuarios: id, nome, email, slack_id, perfil (visualizador/responsavel/gerente), area_id, avatar_url
sla_config: id, urgencia, horas, updated_by, updated_at
```

---

### TECNOLOGIA

- React + TypeScript
- Tailwind CSS
- Supabase (banco de dados + auth + realtime)
- Lucide React (ícones)
- Recharts (gráficos)
- @dnd-kit (drag and drop no Kanban)
- date-fns (datas)

---

### REQUISITOS TÉCNICOS

1. Autenticação via Supabase (email + senha)
2. Realtime: cards atualizam automaticamente quando mudam no banco
3. API REST exposta para integração com N8N (criar card, atualizar status, buscar cards, adicionar comentário)
4. Webhook endpoint para receber eventos do Slack
5. Responsivo (funcionar em mobile para consulta)
6. Permissões: Visualizador vê tudo mas não edita. Responsável move cards da sua área. Gerente edita fluxos da sua área.
7. Histórico pesquisável: cards dos últimos 6 meses em busca rápida, mais antigos em arquivo
