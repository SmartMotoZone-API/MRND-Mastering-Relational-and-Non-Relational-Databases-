-- 3) INSERTS (pais primeiro, depois filhos)

-- 3.1) Zonas
INSERT INTO zonas VALUES ('A1', 'Zona de entrada', 'Frontal');
INSERT INTO zonas VALUES ('A2', 'Zona de espera',  'Frontal');
INSERT INTO zonas VALUES ('B1', 'Zona de manobra', 'Lateral');
INSERT INTO zonas VALUES ('B2', 'Zona de carga',   'Lateral');
INSERT INTO zonas VALUES ('C1', 'Zona de manuten��o','Traseira');

-- 3.2) Funcion�rios (IDs manuais)
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (1, 'Jo�o Silva',    'joao@email.com',    'T�cnico');
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (2, 'Ana Lima',      'ana@email.com',     'Operadora');
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (3, 'Carlos Souza',  'carlos@email.com',  'Supervisor');
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (4, 'Beatriz Ramos', 'bia@email.com',     'T�cnica');
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (5, 'Lucas Rocha',   'lucas@email.com',   'Analista');

-- 3.3) Usu�rios (IDs manuais)
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (1, 'Admin',      'admin@mottu.com', 'admin123', 'admin');
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (2, 'Operador 1', 'op1@mottu.com',   'senha1',   'operador');
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (3, 'Operador 2', 'op2@mottu.com',   'senha2',   'operador');
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (4, 'Supervisor', 'sup@mottu.com',   'senha3',   'supervisor');
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (5, 'Estagi�rio', 'est@mottu.com',   'senha4',   'operador');

-- 3.4) Motos
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Honda CG 160', 'ativa',         'B2', 1);
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Yamaha Fazer', 'em manuten��o', 'C1', 3);
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Suzuki Yes',   'ativa',         'A1', 2);
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Honda Biz',    'ativa',         'A2', 4);
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Yamaha Factor','inativa',       'B1', 5);

-- 3.5) Movimenta��es
INSERT INTO movimentacoes (moto_id, zona_origem, zona_destino, data_hora, usuario_id)
  VALUES (1, 'A1', 'B2', SYSDATE - 4, 2);
INSERT INTO movimentacoes (moto_id, zona_origem, zona_destino, data_hora, usuario_id)
  VALUES (2, 'B2', 'C1', SYSDATE - 3, 3);
INSERT INTO movimentacoes (moto_id, zona_origem, zona_destino, data_hora, usuario_id)
  VALUES (3, 'A2', 'A1', SYSDATE - 2, 4);
INSERT INTO movimentacoes (moto_id, zona_origem, zona_destino, data_hora, usuario_id)
  VALUES (4, 'A1', 'A2', SYSDATE - 1, 2);
INSERT INTO movimentacoes (moto_id, zona_origem, zona_destino, data_hora, usuario_id)
  VALUES (5, 'B1', 'B2', SYSDATE,     1);
