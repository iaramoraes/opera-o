# Análise dos Canais Reais — Padrões de Suporte

## #suporte-franquias
**Padrão:** Fluxo Suporte-Franquias + Fluxo Suporte-Franquias Manutenção
**Exemplo real:** "Vistoria de imóvel ativo realizada, segue os relatórios" (Lucelaine.santos, CNA010)
**Exemplo real:** "A prop entrou em contato solicitando a entrega do enxoval" (Lari Pereira, VBV1810)
**Exemplo real:** "A franquia do imóvel não está retornando às mensagens no sults para confirmação do agendamento da vistoria" (Amanda Cabral, UPP0104)
**IA pode:** Classificar automaticamente (vistoria vs manutenção vs enxoval), verificar histórico, responder sobre status

## #suporte-atendimento
**Padrão:** Realocador Bot + Suporte Hóspedes manual + Financeiro
**Exemplo real:** Realocação RUP0805 por Manutenção (ar condicionado não funcionando)
**Exemplo real:** Realocação UPP0316 por Churn (3 reservas do mesmo imóvel)
**Exemplo real:** Financeiro pedindo verificação de descontos Airbnb (vários códigos)
**IA pode:** Buscar imóvel alternativo pra realocação, validar códigos de reserva, verificar BO's de descontos

## #suporte-avaliações
**Padrão:** Kethrin (CS Proprietário) pede para Victoria Magri responder avaliações
**Exemplo real:** RTS0903 - "limpeza estava péssima, restos de comida na mesa" (Fernando)
**Exemplo real:** HGR0804 - "checkin atrasou quase 2 horas, travesseiros sujos" (Cláudio)
**Exemplo real:** CQS0004 - avaliação mista sobre condomínio (Gisela)
**Exemplo real:** AAR0203 - "foto do anúncio dá a entender que tem vista-mar" (Eduarda)
**IA pode:** Gerar resposta profissional automaticamente, analisar se é contestável, classificar tipo de reclamação

## #suporte-cs-proprietários
**Padrão:** Handover CS + Análise CS Ops (Kethrin) + Proprietário insatisfeito
**Exemplo real:** OAG0507 - "prop quer desbloquear calendário, venda não deu certo" (Lari → Julyana)
**Exemplo real:** VLL0008 - "proprietário insatisfeito com hóspedes israelitas causando problema" (Camila Braga, Alta urgência)
**Exemplo real:** RAO1520 - "proprietário pensando em cancelar contrato" (Júlia → Julyana, Alta)
**Exemplo real:** PGA0205 - "condomínio reclamando, proprietária quer cancelar temporada" (Luana → Gabriele, Crise!)
**IA pode:** Calcular score de churn, buscar histórico completo, sugerir ação de retenção, agendar ligação

## #suporte-implantação
**Padrão:** Solicitar Suporte Implantação com Imóvel + Fase + Problema
**Exemplo real:** VSM0001 - "verificar com franqueado se PIN está correto" (Talyssa, Criação Anúncios)
**Exemplo real:** OLA0006 - "verificar permissão de pets desta unidade" (Talyssa, Criação Anúncios)
**Exemplo real:** ODZ0102 - "cliente não recebeu contato do anfitrião, chega sábado" (Samuel, Onboarding)
**IA pode:** Verificar status do imóvel, buscar info do PIN/pets, acionar franquia automaticamente

## #suporte-anuncios
**Padrão:** Alteração de anúncio + Recriação de anúncio → cai no Pipefy
**Exemplo real:** CAC025 - "mudar foto de capa e adicionar tour virtual" (Nathalia karen)
**Exemplo real:** JAS - "obras acontecendo ao lado dos aptos, franquia sem prazo" (Carola)
**Exemplo real:** Recriação por "Nota ruim" (Talyssa, testes internos)
**IA pode:** Verificar se anúncio já tem alteração em andamento no Pipefy, validar elegibilidade recriação

## #realocações-devolução-crédito
**Padrão:** Pedido de Devolução com todos os campos estruturados
**Exemplo real:** NWT0703 - cancelamento integral R$703,60 (dentro do prazo CDC)
**Exemplo real:** CNB006 - reembolso parcial R$57,90 (15% desconto por banheira não funcionando)
**Exemplo real:** ILC2309/ILC2310 - cancelamentos integrais R$1.174,20 cada (dentro do CDC)
**IA pode:** Verificar política de cancelamento, calcular valor proporcional, validar se está dentro do prazo CDC

## #suporte-processo-churn
**Padrão:** Suporte Churn com Imóvel + Assunto (Assinatura Distratos / Verificação Pendências / Outros)
**Exemplo real:** AEM0004 - Outros (Maria Eduarda)
**Exemplo real:** CPI0208 - Assinatura de Distratos (Luana Ornelas)
**Exemplo real:** CVS1201 - Verificação de Pendências (Jhonata)
**IA pode:** Listar pendências automaticamente, verificar reservas futuras, calcular probabilidade de reversão

---

## Padrões identificados para IA:

### Respostas automáticas (deflexão):
1. Status de imóvel / fase implantação → buscar no sistema
2. Verificação de pagamento / boleto → buscar status
3. Informações sobre pet / PIN / regras → buscar na base de conhecimento
4. Cancelamentos dentro do prazo CDC → aprovar automaticamente

### Geração de conteúdo:
1. Respostas a avaliações de hóspedes (profissional, empático)
2. Contestação de avaliações (argumentação jurídica por OTA)
3. Comunicados para franquias (tom profissional)

### Classificação e roteamento:
1. Tipo de suporte franquia (vistoria vs manutenção vs enxoval)
2. Urgência baseada em contexto (proprietário quer cancelar = Alta/Crise)
3. Área correta baseada na descrição

### Alertas proativos:
1. Imóvel com 3+ suportes simultâneos
2. Proprietário com padrão de insatisfação (risco churn)
3. Franquia com reclamações recorrentes
4. SLA prestes a estourar
