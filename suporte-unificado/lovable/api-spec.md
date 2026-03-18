# API da Lovable — Endpoints necessários para integração N8N

## Base URL
`https://[app-name].lovable.app/api` (definir após criação)

---

## Autenticação
Bearer token no header: `Authorization: Bearer {API_KEY}`

---

## Endpoints

### 1. POST /cards — Criar card
Chamado pelo WF-01 (N8N) quando novo suporte é aberto no Slack.

**Request:**
```json
{
  "codigo_imovel": "TXP0605",
  "area_id": 2,
  "processo_id": 5,
  "solicitante_slack_id": "U05R0Q1T83Y",
  "solicitante_nome": "Naara Oliveira",
  "urgencia": "alta",
  "descricao": "Enxoval deteriorado - cama casal e toalhas",
  "resumo_ia": "Imóvel com 3 suportes abertos. Score churn: 72%.",
  "slack_thread_ts": "1773797353.558049",
  "slack_channel_id": "C0AM2DBTRT5"
}
```

**Response:**
```json
{
  "id": 1247,
  "numero": "SUP-1247",
  "status": "novo",
  "sla_deadline": "2026-03-18T21:14:00Z",
  "responsavel_nome": "Lari Pereira",
  "responsavel_slack_id": "UXXXXXXXX",
  "url": "https://app.lovable.app/card/1247",
  "created_at": "2026-03-18T09:14:00Z"
}
```

---

### 2. PATCH /cards/{id}/status — Atualizar status
Pode ser chamado pela Lovable (UI) ou pelo N8N.

**Request:**
```json
{
  "status": "em_andamento",
  "comentario": "Acionando fornecedor para troca"
}
```

**Response:**
```json
{
  "id": 1247,
  "status": "em_andamento",
  "updated_at": "2026-03-18T10:34:00Z"
}
```

**Status possíveis:** `novo`, `em_andamento`, `aguardando`, `concluido`, `arquivado`

---

### 3. PATCH /cards/{id}/transferir — Transferir entre áreas

**Request:**
```json
{
  "nova_area_id": 3,
  "motivo": "Demanda é de Hóspede, não Franquias"
}
```

**Response:**
```json
{
  "id": 1247,
  "area_id": 3,
  "novo_responsavel_nome": "Carolina Espindola",
  "novo_responsavel_slack_id": "UXXXXXXXX",
  "sla_deadline": "2026-03-18T21:14:00Z"
}
```
Nota: SLA NÃO reinicia (mantém deadline original).

---

### 4. POST /cards/{id}/comentarios — Adicionar comentário

**Request:**
```json
{
  "autor_slack_id": "U05R0Q1T83Y",
  "autor_nome": "Naara Oliveira",
  "texto": "Alguma atualização sobre a troca do enxoval?",
  "via": "slack"
}
```

**Response:**
```json
{
  "id": 892,
  "card_id": 1247,
  "created_at": "2026-03-18T14:00:00Z"
}
```

---

### 5. GET /cards?status=aberto&codigo_imovel={codigo} — Buscar cards

**Query params:**
- `status`: novo, em_andamento, aguardando, concluido, arquivado, aberto (= novo + em_andamento + aguardando)
- `codigo_imovel`: filtrar por imóvel
- `area_id`: filtrar por área
- `responsavel_slack_id`: filtrar por responsável
- `solicitante_slack_id`: filtrar por solicitante
- `sla_estourado`: true/false
- `created_after`: ISO date
- `created_before`: ISO date
- `limit`: número (default 50)
- `offset`: número

**Response:**
```json
{
  "total": 23,
  "cards": [
    {
      "id": 1247,
      "numero": "SUP-1247",
      "codigo_imovel": "TXP0605",
      "area": { "id": 2, "nome": "Franquias", "cor": "#0D4BD0" },
      "processo": { "id": 5, "nome": "Suporte Franquia" },
      "urgencia": "alta",
      "status": "novo",
      "solicitante": { "nome": "Naara Oliveira", "slack_id": "UXXXXXXXX" },
      "responsavel": { "nome": "Lari Pereira", "slack_id": "UXXXXXXXX" },
      "descricao": "Enxoval deteriorado...",
      "sla_deadline": "2026-03-18T21:14:00Z",
      "sla_estourado": false,
      "created_at": "2026-03-18T09:14:00Z",
      "url": "https://app.lovable.app/card/1247"
    }
  ]
}
```

---

### 6. GET /cards/{id} — Detalhe do card

**Response:** mesmo formato acima + campos extras:
```json
{
  ...card,
  "resumo_ia": "...",
  "historico": [
    { "acao": "criado", "autor": "N8N", "detalhes": "Card criado via Slack", "created_at": "..." },
    { "acao": "status_alterado", "autor": "Lari Pereira", "detalhes": "novo → em_andamento", "created_at": "..." }
  ],
  "comentarios": [
    { "id": 892, "autor": "Naara Oliveira", "texto": "...", "via": "slack", "created_at": "..." }
  ],
  "outros_suportes_imovel": [
    { "id": 1232, "area": "Hóspede", "processo": "Avaliação negativa", "status": "em_andamento" }
  ]
}
```

---

### 7. GET /processos?area_id={id}&ativo=true — Listar processos

Para montar formulário dinâmico no Slack.

**Response:**
```json
{
  "processos": [
    {
      "id": 5,
      "nome": "Suporte Franquia",
      "campos": [
        { "nome": "Setor", "tipo": "dropdown", "opcoes": ["Comunicação", "Manutenção", "Enxoval"], "obrigatorio": true },
        { "nome": "Consultor", "tipo": "texto", "obrigatorio": false }
      ],
      "ativo": true
    }
  ]
}
```

---

### 8. GET /metricas — Métricas para resumo diário

**Query params:** `data` (YYYY-MM-DD)

**Response:**
```json
{
  "data": "2026-03-18",
  "por_area": [
    {
      "area": "Implantação",
      "novos": 2,
      "concluidos": 1,
      "em_andamento": 1,
      "sla_estourado": 0
    },
    { "area": "Franquias", "novos": 3, "concluidos": 2, "em_andamento": 4, "sla_estourado": 1 },
    { "area": "Hóspede", "novos": 4, "concluidos": 3, "em_andamento": 2, "sla_estourado": 0 },
    { "area": "Proprietários", "novos": 1, "concluidos": 1, "em_andamento": 1, "sla_estourado": 0 }
  ],
  "totais": {
    "novos": 10,
    "concluidos": 7,
    "em_andamento": 8,
    "sla_estourado": 1,
    "tempo_medio_resolucao_horas": 6.5,
    "deflexao_ia_percent": 18
  }
}
```

---

### 9. Webhooks (Lovable → N8N)

A Lovable deve enviar webhook pro N8N quando:

**URL do webhook N8N:** `https://automation.seazone.com.br/webhook/lovable-events`

**Eventos:**
```json
{
  "evento": "card.status_alterado",
  "card_id": 1247,
  "numero": "SUP-1247",
  "status_anterior": "novo",
  "status_novo": "em_andamento",
  "autor": "Lari Pereira",
  "slack_thread_ts": "1773797353.558049",
  "slack_channel_id": "C0AM2DBTRT5",
  "solicitante_slack_id": "UXXXXXXXX",
  "responsavel_slack_id": "UXXXXXXXX",
  "timestamp": "2026-03-18T10:34:00Z"
}
```

**Tipos de evento:**
- `card.status_alterado`
- `card.comentario_adicionado`
- `card.transferido`
- `card.responsavel_alterado`
- `card.ia_feedback` (marcou "IA errou")
