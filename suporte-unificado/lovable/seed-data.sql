-- =============================================
-- SEED DATA — Suporte Unificado Seazone
-- Rodar no Supabase SQL Editor
-- =============================================

-- =============================================
-- 1. ÁREAS (4 áreas)
-- =============================================
INSERT INTO areas (id, nome, cor, ativo) VALUES
  ('a0000001-0000-0000-0000-000000000001', 'Implantação', '#F0883E', true),
  ('a0000002-0000-0000-0000-000000000002', 'Franquias', '#0D4BD0', true),
  ('a0000003-0000-0000-0000-000000000003', 'Hóspede', '#047755', true),
  ('a0000004-0000-0000-0000-000000000004', 'Proprietários', '#7C3AED', true)
ON CONFLICT (id) DO NOTHING;

-- =============================================
-- 2. USUÁRIOS (pessoas reais)
-- Nota: user_id é placeholder até vincular com auth.users
-- =============================================
INSERT INTO usuarios (id, user_id, nome, email, slack_id, area_id, ativo) VALUES
  ('u0000001-0000-0000-0000-000000000001', 'auth-placeholder-001', 'Iara Moraes', 'iara.moraes@seazone.com.br', 'U05R0Q1T83Y', NULL, true),
  ('u0000002-0000-0000-0000-000000000002', 'auth-placeholder-002', 'Larissa Constantino', 'larissa.constantino@seazone.com.br', NULL, 'a0000001-0000-0000-0000-000000000001', true),
  ('u0000003-0000-0000-0000-000000000003', 'auth-placeholder-003', 'Vivianny Aguilera', 'vivianny.aguilera@seazone.com.br', NULL, 'a0000002-0000-0000-0000-000000000002', true),
  ('u0000004-0000-0000-0000-000000000004', 'auth-placeholder-004', 'Carolina Espindola', 'carolina.espindola@seazone.com.br', NULL, 'a0000003-0000-0000-0000-000000000003', true),
  ('u0000005-0000-0000-0000-000000000005', 'auth-placeholder-005', 'Luiza Cechelero', 'luiza.cechelero@seazone.com.br', NULL, 'a0000004-0000-0000-0000-000000000004', true),
  ('u0000006-0000-0000-0000-000000000006', 'auth-placeholder-006', 'Victoria Magri', 'victoria.magri@seazone.com.br', NULL, 'a0000003-0000-0000-0000-000000000003', true),
  ('u0000007-0000-0000-0000-000000000007', 'auth-placeholder-007', 'Lari Pereira', 'lari.pereira@seazone.com.br', NULL, 'a0000002-0000-0000-0000-000000000002', true),
  ('u0000008-0000-0000-0000-000000000008', 'auth-placeholder-008', 'Paulinha Sacramento', 'paulinha.sacramento@seazone.com.br', NULL, 'a0000001-0000-0000-0000-000000000001', true),
  ('u0000009-0000-0000-0000-000000000009', 'auth-placeholder-009', 'Talyssa Pimentel', 'talyssa.pimentel@seazone.com.br', NULL, 'a0000003-0000-0000-0000-000000000003', true),
  ('u0000010-0000-0000-0000-000000000010', 'auth-placeholder-010', 'Kethrin', 'kethrin@seazone.com.br', NULL, 'a0000004-0000-0000-0000-000000000004', true),
  ('u0000011-0000-0000-0000-000000000011', 'auth-placeholder-011', 'Luana Ornelas', 'luana.ornelas@seazone.com.br', NULL, 'a0000004-0000-0000-0000-000000000004', true),
  ('u0000012-0000-0000-0000-000000000012', 'auth-placeholder-012', 'Naara Oliveira', 'naara.oliveira@seazone.com.br', NULL, 'a0000002-0000-0000-0000-000000000002', true),
  ('u0000013-0000-0000-0000-000000000013', 'auth-placeholder-013', 'Fabi Azevedo', 'fabi.azevedo@seazone.com.br', NULL, 'a0000002-0000-0000-0000-000000000002', true),
  ('u0000014-0000-0000-0000-000000000014', 'auth-placeholder-014', 'Jessica Passos', 'jessica.passos@seazone.com.br', NULL, 'a0000004-0000-0000-0000-000000000004', true),
  ('u0000015-0000-0000-0000-000000000015', 'auth-placeholder-015', 'Giovanna Araujo', 'giovanna.araujo@seazone.com.br', NULL, 'a0000001-0000-0000-0000-000000000001', true)
ON CONFLICT (id) DO NOTHING;

-- Vincular gerentes nas áreas
UPDATE areas SET gerente_id = 'u0000002-0000-0000-0000-000000000002' WHERE id = 'a0000001-0000-0000-0000-000000000001';
UPDATE areas SET gerente_id = 'u0000003-0000-0000-0000-000000000003' WHERE id = 'a0000002-0000-0000-0000-000000000002';
UPDATE areas SET gerente_id = 'u0000004-0000-0000-0000-000000000004' WHERE id = 'a0000003-0000-0000-0000-000000000003';
UPDATE areas SET gerente_id = 'u0000005-0000-0000-0000-000000000005' WHERE id = 'a0000004-0000-0000-0000-000000000004';

-- =============================================
-- 3. USER_ROLES
-- =============================================
INSERT INTO user_roles (user_id, role) VALUES
  ('auth-placeholder-001', 'admin'),
  ('auth-placeholder-002', 'gerente'),
  ('auth-placeholder-003', 'gerente'),
  ('auth-placeholder-004', 'gerente'),
  ('auth-placeholder-005', 'gerente'),
  ('auth-placeholder-006', 'responsavel'),
  ('auth-placeholder-007', 'responsavel'),
  ('auth-placeholder-008', 'responsavel'),
  ('auth-placeholder-009', 'responsavel'),
  ('auth-placeholder-010', 'responsavel'),
  ('auth-placeholder-011', 'responsavel'),
  ('auth-placeholder-012', 'responsavel'),
  ('auth-placeholder-013', 'responsavel'),
  ('auth-placeholder-014', 'responsavel'),
  ('auth-placeholder-015', 'responsavel')
ON CONFLICT DO NOTHING;

-- =============================================
-- 4. SLA CONFIG
-- =============================================
INSERT INTO sla_config (urgencia, horas) VALUES
  ('crise', 4),
  ('alta', 12),
  ('media', 24),
  ('baixa', 24)
ON CONFLICT DO NOTHING;

-- =============================================
-- 5. PROCESSOS — IMPLANTAÇÃO (4 processos)
-- =============================================
INSERT INTO processos (id, area_id, nome, ordem, ativo, responsavel_id, campos_json) VALUES

-- Implantação
('p0001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000001', 'Suporte Implantação', 1, true, 'u0000008-0000-0000-0000-000000000008',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Setor Solicitante","tipo":"dropdown","obrigatorio":true,"opcoes":["Criação de Anúncios","Precificação","Vistorias","Fotos","Geral"]},{"nome":"Fase da Implantação","tipo":"texto","obrigatorio":true},{"nome":"Descrição do Problema","tipo":"texto","obrigatorio":true}]'),

('p0002-0000-0000-0000-000000000002', 'a0000001-0000-0000-0000-000000000001', 'Novas Fotos Pró', 2, true, 'u0000009-0000-0000-0000-000000000009',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Nome do Proprietário","tipo":"texto","obrigatorio":true},{"nome":"Nome da Franquia","tipo":"texto","obrigatorio":true},{"nome":"Endereço do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Tipo de Solicitação","tipo":"dropdown","obrigatorio":true,"opcoes":["Fotos novas","Atualização","Reposição"]},{"nome":"Motivo da Solicitação","tipo":"texto","obrigatorio":true}]'),

('p0003-0000-0000-0000-000000000003', 'a0000001-0000-0000-0000-000000000001', 'Troca de Código', 3, true, 'u0000002-0000-0000-0000-000000000002',
 '[{"nome":"Código Antigo","tipo":"texto","obrigatorio":true},{"nome":"Novo Código","tipo":"texto","obrigatorio":true},{"nome":"Quem Solicitou","tipo":"texto","obrigatorio":true},{"nome":"Observação","tipo":"texto","obrigatorio":false}]'),

('p0004-0000-0000-0000-000000000004', 'a0000001-0000-0000-0000-000000000001', 'Venda de Imóvel', 4, true, 'u0000002-0000-0000-0000-000000000002',
 '[{"nome":"Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Proprietário Antigo","tipo":"texto","obrigatorio":true},{"nome":"Proprietário Novo","tipo":"texto","obrigatorio":true},{"nome":"Link Pipedrive (prop antigo)","tipo":"texto","obrigatorio":false},{"nome":"Link Pipedrive (prop novo)","tipo":"texto","obrigatorio":false},{"nome":"Data da Mudança","tipo":"date","obrigatorio":true},{"nome":"Precisa Vistoria e Novo Enxoval?","tipo":"checkbox","obrigatorio":true,"opcoes":["Sim","Não"]},{"nome":"Motivo da Troca","tipo":"texto","obrigatorio":true}]'),

-- =============================================
-- 6. PROCESSOS — FRANQUIAS (7 processos)
-- =============================================

('p0005-0000-0000-0000-000000000005', 'a0000002-0000-0000-0000-000000000002', 'Suporte Franquia', 1, true, 'u0000007-0000-0000-0000-000000000007',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Setor","tipo":"texto","obrigatorio":true},{"nome":"Assunto","tipo":"dropdown","obrigatorio":true,"opcoes":["Comunicação","Manutenção","Enxoval","Vistoria","Insatisfação Proprietário"]},{"nome":"Problema","tipo":"texto","obrigatorio":true},{"nome":"Consultor","tipo":"texto","obrigatorio":false}]'),

('p0006-0000-0000-0000-000000000006', 'a0000002-0000-0000-0000-000000000002', 'Fornecedores', 2, true, 'u0000003-0000-0000-0000-000000000003',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":false},{"nome":"Quem Solicita","tipo":"dropdown","obrigatorio":true,"opcoes":["Seazoner","Franqueado"]},{"nome":"Tipo","tipo":"dropdown","obrigatorio":true,"opcoes":["Homologar","Recompra","Pesquisa","Problema","Abertura Nova Região","Outro"]},{"nome":"Setor","tipo":"texto","obrigatorio":true}]'),

('p0007-0000-0000-0000-000000000007', 'a0000002-0000-0000-0000-000000000002', 'Gestão de Contas', 3, true, 'u0000007-0000-0000-0000-000000000007',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Assunto","tipo":"dropdown","obrigatorio":true,"opcoes":["Cadastro contas","Envio boleto","Verificação pagamento","Envio fatura"]},{"nome":"Descrição","tipo":"texto","obrigatorio":true}]'),

('p0008-0000-0000-0000-000000000008', 'a0000002-0000-0000-0000-000000000002', 'Registro de Ocorrência', 4, true, 'u0000013-0000-0000-0000-000000000013',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Franquia Responsável","tipo":"texto","obrigatorio":true},{"nome":"Categoria","tipo":"dropdown","obrigatorio":true,"opcoes":["Atendimento ao Hospede","Implantação","Caça Ocorrências","Comentários","Suporte Franquias","Gestor Regional","Danos","Despesas","Manutenções","Treinamento","Cancelamento de Vistorias"]},{"nome":"Descrição","tipo":"texto","obrigatorio":true},{"nome":"Evidência","tipo":"anexo","obrigatorio":false}]'),

('p0009-0000-0000-0000-000000000009', 'a0000002-0000-0000-0000-000000000002', 'Comunicado para Franquias', 5, true, 'u0000003-0000-0000-0000-000000000003',
 '[{"nome":"Título","tipo":"texto","obrigatorio":true},{"nome":"Tipo","tipo":"dropdown","obrigatorio":true,"opcoes":["Mudança de processo","Reajuste","Reconhecimento mensal","Nota de correção","Pesquisa"]},{"nome":"Conteúdo","tipo":"texto","obrigatorio":true}]'),

('p0010-0000-0000-0000-000000000010', 'a0000002-0000-0000-0000-000000000002', 'Qualidade e Treinamento', 6, true, 'u0000003-0000-0000-0000-000000000003',
 '[{"nome":"Email Seazone","tipo":"texto","obrigatorio":true},{"nome":"Setor","tipo":"dropdown","obrigatorio":true,"opcoes":["Franquias","Implantação","Hóspede","Proprietários","Outro"]},{"nome":"Área da Solicitação","tipo":"dropdown","obrigatorio":true,"opcoes":["Treinamento","Qualidade","Auditoria","Outro"]}]'),

('p0011-0000-0000-0000-000000000011', 'a0000002-0000-0000-0000-000000000002', 'Validação Comercial', 7, true, 'u0000008-0000-0000-0000-000000000008',
 '[{"nome":"O que precisa ser feito","tipo":"dropdown","obrigatorio":true,"opcoes":["Validar Localização","Validar Imóvel","Validar Roupa de Cama","Visita do Anfitrião"]},{"nome":"Link Pipedrive","tipo":"texto","obrigatorio":true},{"nome":"Cidade","tipo":"texto","obrigatorio":true},{"nome":"Endereço","tipo":"texto","obrigatorio":true},{"nome":"Descrição","tipo":"texto","obrigatorio":true},{"nome":"Criticidade","tipo":"dropdown","obrigatorio":true,"opcoes":["Urgente","Médio"]}]'),

-- =============================================
-- 7. PROCESSOS — HÓSPEDE (10 processos)
-- =============================================

('p0012-0000-0000-0000-000000000012', 'a0000003-0000-0000-0000-000000000003', 'Contestação de Avaliação', 1, true, 'u0000006-0000-0000-0000-000000000006',
 '[{"nome":"Setor Solicitante","tipo":"dropdown","obrigatorio":true,"opcoes":["Atendimento","Franquias","CS Proprietários","Implantação","Outro"]},{"nome":"Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Nome do Hóspede","tipo":"texto","obrigatorio":true},{"nome":"Data do Checkout","tipo":"date","obrigatorio":true},{"nome":"OTA/Plataforma","tipo":"dropdown","obrigatorio":true,"opcoes":["Airbnb","Booking","Stays","Outro"]},{"nome":"Código da Reserva","tipo":"texto","obrigatorio":true},{"nome":"Texto do Comentário (íntegra)","tipo":"texto","obrigatorio":true},{"nome":"Descrição do Suporte","tipo":"texto","obrigatorio":true}]'),

('p0013-0000-0000-0000-000000000013', 'a0000003-0000-0000-0000-000000000003', 'Resposta a Avaliação', 2, true, 'u0000006-0000-0000-0000-000000000006',
 '[{"nome":"Setor Solicitante","tipo":"dropdown","obrigatorio":true,"opcoes":["Atendimento","Franquias","CS Proprietários","Implantação","Outro"]},{"nome":"Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Nome do Hóspede","tipo":"texto","obrigatorio":true},{"nome":"Data do Checkout","tipo":"date","obrigatorio":true},{"nome":"OTA/Plataforma","tipo":"dropdown","obrigatorio":true,"opcoes":["Airbnb","Booking","Stays","Outro"]},{"nome":"Código da Reserva","tipo":"texto","obrigatorio":true},{"nome":"Texto do Comentário (íntegra)","tipo":"texto","obrigatorio":true},{"nome":"Descrição do Suporte","tipo":"texto","obrigatorio":true}]'),

('p0014-0000-0000-0000-000000000014', 'a0000003-0000-0000-0000-000000000003', 'Alteração de Anúncio', 3, true, 'u0000009-0000-0000-0000-000000000009',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Vínculo do Solicitante","tipo":"dropdown","obrigatorio":true,"opcoes":["Seazoner","Franqueado","Proprietário","Outro"]},{"nome":"Alteração Temporária ou Permanente","tipo":"dropdown","obrigatorio":true,"opcoes":["Temporária","Permanente"]},{"nome":"Descrição da Alteração","tipo":"texto","obrigatorio":true},{"nome":"Link de Anexos","tipo":"texto","obrigatorio":false},{"nome":"Teve Reclamação do Hóspede?","tipo":"dropdown","obrigatorio":true,"opcoes":["Sim","Não"]}]'),

('p0015-0000-0000-0000-000000000015', 'a0000003-0000-0000-0000-000000000003', 'Recriação de Anúncio', 4, true, 'u0000009-0000-0000-0000-000000000009',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Email do Solicitante","tipo":"texto","obrigatorio":true},{"nome":"Plataforma","tipo":"dropdown","obrigatorio":true,"opcoes":["Airbnb","Booking","Stays"]},{"nome":"Pedidos para o Anúncio","tipo":"texto","obrigatorio":true},{"nome":"Motivo da Recriação","tipo":"dropdown","obrigatorio":true,"opcoes":["Nota ruim","Baixo desempenho","Anúncio suspenso (por cópia)","Anúncio suspenso (outros motivos)","Outro"]},{"nome":"Setor que Solicitou","tipo":"texto","obrigatorio":false}]'),

('p0016-0000-0000-0000-000000000016', 'a0000003-0000-0000-0000-000000000003', 'Realocação e Cancelamento', 5, true, 'u0000004-0000-0000-0000-000000000004',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Código da Reserva","tipo":"texto","obrigatorio":true},{"nome":"Motivo da Solicitação","tipo":"dropdown","obrigatorio":true,"opcoes":["Manutenção","Insatisfação","Overbooking","Problema estrutural","Outro"]},{"nome":"Detalhe do Problema","tipo":"texto","obrigatorio":true},{"nome":"Precisa de Bloqueio Após Realocação?","tipo":"dropdown","obrigatorio":true,"opcoes":["Sim","Não"]},{"nome":"Email do Solicitante","tipo":"texto","obrigatorio":true}]'),

('p0017-0000-0000-0000-000000000017', 'a0000003-0000-0000-0000-000000000003', 'Reserva Interna', 6, true, 'u0000004-0000-0000-0000-000000000004',
 '[{"nome":"Imóvel ou Região","tipo":"texto","obrigatorio":true},{"nome":"Orçamento","tipo":"texto","obrigatorio":true},{"nome":"Número de Hóspedes","tipo":"number","obrigatorio":true},{"nome":"Data Check-in","tipo":"date","obrigatorio":true},{"nome":"Data Check-out","tipo":"date","obrigatorio":true},{"nome":"Nome do Titular","tipo":"texto","obrigatorio":true},{"nome":"CPF do Titular","tipo":"texto","obrigatorio":true},{"nome":"Telefone do Titular","tipo":"texto","obrigatorio":true},{"nome":"Email do Titular","tipo":"texto","obrigatorio":true}]'),

('p0018-0000-0000-0000-000000000018', 'a0000003-0000-0000-0000-000000000003', 'Reembolso / Devolução de Crédito', 7, true, 'u0000004-0000-0000-0000-000000000004',
 '[{"nome":"Email do Solicitante","tipo":"texto","obrigatorio":true},{"nome":"Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Reserva","tipo":"texto","obrigatorio":true},{"nome":"Data Check-in","tipo":"date","obrigatorio":true},{"nome":"Data Check-out","tipo":"date","obrigatorio":true},{"nome":"Tipo de Reembolso","tipo":"dropdown","obrigatorio":true,"opcoes":["Cancelamento integral","Reembolso parcial"]},{"nome":"Observação","tipo":"texto","obrigatorio":false},{"nome":"Valor R$","tipo":"number","obrigatorio":true},{"nome":"Nome do Hóspede","tipo":"texto","obrigatorio":true}]'),

('p0019-0000-0000-0000-000000000019', 'a0000003-0000-0000-0000-000000000003', 'Reclame Aqui', 8, true, 'u0000004-0000-0000-0000-000000000004',
 '[{"nome":"Tipo de Reclamante","tipo":"dropdown","obrigatorio":true,"opcoes":["Hóspede","Proprietário"]},{"nome":"Código do Imóvel ou Reserva","tipo":"texto","obrigatorio":true},{"nome":"Envolvidos","tipo":"dropdown","obrigatorio":true,"opcoes":["Carol Espindola","Vivih Aguilera","Luiza Cechelero"]},{"nome":"Contato (WhatsApp/Email/ID)","tipo":"texto","obrigatorio":true},{"nome":"Data da Reclamação","tipo":"date","obrigatorio":true},{"nome":"Descrição","tipo":"texto","obrigatorio":true}]'),

('p0020-0000-0000-0000-000000000020', 'a0000003-0000-0000-0000-000000000003', 'Indicação de Parceria', 9, true, 'u0000004-0000-0000-0000-000000000004',
 '[{"nome":"Nome da Agência de Viagem","tipo":"texto","obrigatorio":false},{"nome":"Nome do Contato","tipo":"texto","obrigatorio":false},{"nome":"WhatsApp do Contato","tipo":"texto","obrigatorio":false},{"nome":"Informações Adicionais","tipo":"texto","obrigatorio":false}]'),

-- Reserva Seazone (temporário — ativo=false)
('p0021-0000-0000-0000-000000000021', 'a0000003-0000-0000-0000-000000000003', 'Reserva Seazone', 10, false, 'u0000004-0000-0000-0000-000000000004',
 '[{"nome":"Apto","tipo":"texto","obrigatorio":true},{"nome":"Hóspede","tipo":"texto","obrigatorio":true},{"nome":"Check In","tipo":"date","obrigatorio":true},{"nome":"Check Out","tipo":"date","obrigatorio":true},{"nome":"Valor Bruto","tipo":"number","obrigatorio":true},{"nome":"ID Stays","tipo":"texto","obrigatorio":true},{"nome":"Motivo/Obs","tipo":"texto","obrigatorio":false}]'),

-- =============================================
-- 8. PROCESSOS — PROPRIETÁRIOS (7 processos)
-- =============================================

('p0022-0000-0000-0000-000000000022', 'a0000004-0000-0000-0000-000000000004', 'Handover CS', 1, true, 'u0000005-0000-0000-0000-000000000005',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Categoria","tipo":"dropdown","obrigatorio":true,"opcoes":["Handover CS","Contato CS","Preço Mínimo","Adequação/Manutenção"]},{"nome":"Urgência","tipo":"dropdown","obrigatorio":true,"opcoes":["Baixa","Média","Alta","Crise"]},{"nome":"Descrição","tipo":"texto","obrigatorio":true},{"nome":"Responsável CS","tipo":"texto","obrigatorio":false}]'),

('p0023-0000-0000-0000-000000000023', 'a0000004-0000-0000-0000-000000000004', 'Contato CS', 2, true, 'u0000005-0000-0000-0000-000000000005',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Categoria","tipo":"dropdown","obrigatorio":true,"opcoes":["Handover CS","Contato CS","Preço Mínimo","Adequação/Manutenção"]},{"nome":"Urgência","tipo":"dropdown","obrigatorio":true,"opcoes":["Baixa","Média","Alta","Crise"]},{"nome":"Descrição","tipo":"texto","obrigatorio":true}]'),

('p0024-0000-0000-0000-000000000024', 'a0000004-0000-0000-0000-000000000004', 'Preço Mínimo', 3, true, 'u0000005-0000-0000-0000-000000000005',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Urgência","tipo":"dropdown","obrigatorio":true,"opcoes":["Baixa","Média","Alta","Crise"]},{"nome":"Descrição","tipo":"texto","obrigatorio":true}]'),

('p0025-0000-0000-0000-000000000025', 'a0000004-0000-0000-0000-000000000004', 'Adequação e Manutenção', 4, true, 'u0000005-0000-0000-0000-000000000005',
 '[{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Urgência","tipo":"dropdown","obrigatorio":true,"opcoes":["Baixa","Média","Alta","Crise"]},{"nome":"Descrição","tipo":"texto","obrigatorio":true}]'),

('p0026-0000-0000-0000-000000000026', 'a0000004-0000-0000-0000-000000000004', 'Análise CS Ops', 5, true, 'u0000010-0000-0000-0000-000000000010',
 '[{"nome":"Nome do Solicitante","tipo":"texto","obrigatorio":true},{"nome":"Email do Solicitante","tipo":"texto","obrigatorio":true},{"nome":"Categoria da Análise","tipo":"dropdown","obrigatorio":true,"opcoes":["Contestação valor reserva","Revisão preço"]},{"nome":"Urgência","tipo":"dropdown","obrigatorio":true,"opcoes":["Baixa","Média","Alta","Crise"]},{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Informações Adicionais","tipo":"texto","obrigatorio":false}]'),

('p0027-0000-0000-0000-000000000027', 'a0000004-0000-0000-0000-000000000004', 'Distrato', 6, true, 'u0000011-0000-0000-0000-000000000011',
 '[{"nome":"Email","tipo":"texto","obrigatorio":true},{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Assunto","tipo":"dropdown","obrigatorio":true,"opcoes":["Assinatura Distratos","Verificação Pendências","Outros"]},{"nome":"Suporte Necessário","tipo":"texto","obrigatorio":true}]'),

('p0028-0000-0000-0000-000000000028', 'a0000004-0000-0000-0000-000000000004', 'Verificação Pendências Churn', 7, true, 'u0000014-0000-0000-0000-000000000014',
 '[{"nome":"Email","tipo":"texto","obrigatorio":true},{"nome":"Código do Imóvel","tipo":"texto","obrigatorio":true},{"nome":"Assunto","tipo":"dropdown","obrigatorio":true,"opcoes":["Assinatura Distratos","Verificação Pendências","Outros"]},{"nome":"Suporte Necessário","tipo":"texto","obrigatorio":true}]')

ON CONFLICT (id) DO NOTHING;

-- =============================================
-- RESUMO
-- =============================================
-- 4 áreas
-- 15 usuários (pessoas reais)
-- 28 processos (4 Implantação + 7 Franquias + 10 Hóspede + 7 Proprietários)
-- 4 SLAs configurados
-- Todos os campos_json com tipos e opções reais
