-- 3.1) Clientes
INSERT INTO tb_cliente (nome, email) VALUES ('Ana Souza', 'ana@exemplo.com');
INSERT INTO tb_cliente (nome, email) VALUES ('Bruno Lima', 'bruno@exemplo.com');
INSERT INTO tb_cliente (nome, email) VALUES ('Carla Nunes', 'carla@exemplo.com');
INSERT INTO tb_cliente (nome, email) VALUES ('Diego Torres', 'diego@exemplo.com');
INSERT INTO tb_cliente (nome, email) VALUES ('Eva Prado', 'eva@exemplo.com');

-- 3.2) Motos
INSERT INTO tb_moto (cliente_id, placa, modelo, cor) VALUES (1,'AAA1A11','CG 160','Vermelha');
INSERT INTO tb_moto (cliente_id, placa, modelo, cor) VALUES (2,'BBB2B22','Fazer 250','Preta');
INSERT INTO tb_moto (cliente_id, placa, modelo, cor) VALUES (3,'CCC3C33','NMAX 160','Azul');
INSERT INTO tb_moto (cliente_id, placa, modelo, cor) VALUES (4,'DDD4D44','XRE 300','Branca');
INSERT INTO tb_moto (cliente_id, placa, modelo, cor) VALUES (5,'EEE5E55','MT-03','Cinza');

-- 3.3) Ordens de Serviço
INSERT INTO tb_ordem_servico (moto_id, data_abertura, descricao, valor)
VALUES (1, SYSDATE - 10, 'Troca de óleo', 89.90);
INSERT INTO tb_ordem_servico (moto_id, data_abertura, descricao, valor)
VALUES (2, SYSDATE - 9, 'Pastilha de freio', 149.50);
INSERT INTO tb_ordem_servico (moto_id, data_abertura, descricao, valor)
VALUES (3, SYSDATE - 7, 'Revisão 10k', 399.00);
INSERT INTO tb_ordem_servico (moto_id, data_abertura, descricao, valor)
VALUES (4, SYSDATE - 5, 'Câmbio de pneus', 820.00);
INSERT INTO tb_ordem_servico (moto_id, data_abertura, descricao, valor)
VALUES (5, SYSDATE - 2, 'Alinhamento', 120.00);

-- 3.4) Fatos - Saldos (dados para cálculo de somas)
INSERT INTO fact_saldos VALUES (1,1,4363.55);
INSERT INTO fact_saldos VALUES (1,2,4794.76);
INSERT INTO fact_saldos VALUES (1,3,4718.25);
INSERT INTO fact_saldos VALUES (1,4,5387.45);
INSERT INTO fact_saldos VALUES (1,5,5027.34);
INSERT INTO fact_saldos VALUES (2,1,5652.84);
INSERT INTO fact_saldos VALUES (2,2,4583.02);
INSERT INTO fact_saldos VALUES (2,3,5555.77);
INSERT INTO fact_saldos VALUES (2,4,5936.67);
INSERT INTO fact_saldos VALUES (2,5,4508.74);

COMMIT;