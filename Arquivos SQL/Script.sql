-- 1) DROP das tabelas (filhos antes dos pais)
BEGIN EXECUTE IMMEDIATE 'DROP TABLE movimentacoes CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE motos CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE usuarios1 CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE funcionarios CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE zonas CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- 2) CREATE das tabelas
CREATE TABLE zonas (
    id VARCHAR2(5) PRIMARY KEY,
    descricao VARCHAR2(100) NOT NULL,
    area VARCHAR2(50) NOT NULL
);

CREATE TABLE funcionarios (
    id NUMBER PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    cargo VARCHAR2(50) NOT NULL
);

CREATE TABLE usuarios1 (
    id NUMBER PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    senha VARCHAR2(100) NOT NULL,
    tipo VARCHAR2(20) CHECK (tipo IN ('admin','operador','supervisor')) NOT NULL
);

CREATE TABLE motos (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    modelo VARCHAR2(100) NOT NULL,
    status VARCHAR2(20) CHECK (status IN ('ativa','inativa','em manutenção')) NOT NULL,
    zona_atual_id VARCHAR2(5) NOT NULL,
    responsavel_id NUMBER NOT NULL,
    CONSTRAINT fk_moto_zona FOREIGN KEY (zona_atual_id) REFERENCES zonas(id),
    CONSTRAINT fk_moto_func FOREIGN KEY (responsavel_id) REFERENCES funcionarios(id)
);

CREATE TABLE movimentacoes (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    moto_id NUMBER NOT NULL,
    zona_origem VARCHAR2(5) NOT NULL,
    zona_destino VARCHAR2(5) NOT NULL,
    data_hora DATE DEFAULT SYSDATE,
    usuario_id NUMBER NOT NULL,
    CONSTRAINT fk_mov_moto    FOREIGN KEY (moto_id)    REFERENCES motos(id),
    CONSTRAINT fk_mov_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios1(id)
);

-- 3) Inserções corrigidas (pais primeiro, depois filhos)

-- 3.1) Zonas
INSERT INTO zonas VALUES ('A1', 'Zona de entrada', 'Frontal');
INSERT INTO zonas VALUES ('A2', 'Zona de espera',  'Frontal');
INSERT INTO zonas VALUES ('B1', 'Zona de manobra', 'Lateral');
INSERT INTO zonas VALUES ('B2', 'Zona de carga',   'Lateral');
INSERT INTO zonas VALUES ('C1', 'Zona de manutenção','Traseira');

-- 3.2) Funcionários (IDs manuais)
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (1, 'João Silva',    'joao@email.com',    'Técnico');
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (2, 'Ana Lima',      'ana@email.com',     'Operadora');
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (3, 'Carlos Souza',  'carlos@email.com',  'Supervisor');
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (4, 'Beatriz Ramos', 'bia@email.com',     'Técnica');
INSERT INTO funcionarios (id, nome, email, cargo) VALUES (5, 'Lucas Rocha',   'lucas@email.com',   'Analista');

-- 3.3) Usuários (IDs manuais)
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (1, 'Admin',      'admin@mottu.com', 'admin123', 'admin');
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (2, 'Operador 1', 'op1@mottu.com',   'senha1',   'operador');
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (3, 'Operador 2', 'op2@mottu.com',   'senha2',   'operador');
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (4, 'Supervisor', 'sup@mottu.com',   'senha3',   'supervisor');
INSERT INTO usuarios1 (id, nome, email, senha, tipo) VALUES (5, 'Estagiário', 'est@mottu.com',   'senha4',   'operador');

-- 3.4) Motos
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Honda CG 160', 'ativa',         'B2', 1);
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Yamaha Fazer', 'em manutenção', 'C1', 3);
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Suzuki Yes',   'ativa',         'A1', 2);
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Honda Biz',    'ativa',         'A2', 4);
INSERT INTO motos (modelo, status, zona_atual_id, responsavel_id) VALUES ('Yamaha Factor','inativa',       'B1', 5);

-- 3.5) Movimentações
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

-- PL/SQL para gerar os relatórios com JOIN, GROUP BY e ORDER BY
SET SERVEROUTPUT ON;

-- Bloco anônimo com consultas usando JOIN, GROUP BY e ORDER BY
DECLARE
    CURSOR c_motos_por_zona IS
        SELECT z.id AS zona, COUNT(m.id) AS total_motos
        FROM zonas z
        LEFT JOIN motos m ON m.zona_atual_id = z.id
        GROUP BY z.id
        ORDER BY total_motos DESC;

    CURSOR c_motos_por_responsavel IS
        SELECT f.nome, COUNT(m.id) AS total_motos
        FROM funcionarios f
        LEFT JOIN motos m ON m.responsavel_id = f.id
        GROUP BY f.nome
        ORDER BY total_motos DESC;

    CURSOR c_movimentacoes_por_usuario IS
        SELECT u.nome, COUNT(mv.id) AS total_movimentacoes
        FROM usuarios1 u
        LEFT JOIN movimentacoes mv ON mv.usuario_id = u.id
        GROUP BY u.nome
        ORDER BY total_movimentacoes DESC;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Motos por Zona ---');
    FOR r IN c_motos_por_zona LOOP
        DBMS_OUTPUT.PUT_LINE('Zona: ' || r.zona || ' - Total Motos: ' || r.total_motos);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--- Motos por Responsável ---');
    FOR r IN c_motos_por_responsavel LOOP
        DBMS_OUTPUT.PUT_LINE('Funcionário: ' || r.nome || ' - Total Motos: ' || r.total_motos);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--- Movimentações por Usuário ---');
    FOR r IN c_movimentacoes_por_usuario LOOP
        DBMS_OUTPUT.PUT_LINE('Usuário: ' || r.nome || ' - Total Movimentações: ' || r.total_movimentacoes);
    END LOOP;
END;
/
-- Ativa a sa�da no console
SET SERVEROUTPUT ON;

-- Bloco an�nimo: mostra valor atual, anterior e pr�ximo da coluna 'modelo' da tabela 'motos'
DECLARE
    CURSOR c_motos_contexto IS
        SELECT 
            NVL(LAG(modelo) OVER (ORDER BY id), 'Vazio') AS modelo_anterior,
            modelo,
            NVL(LEAD(modelo) OVER (ORDER BY id), 'Vazio') AS modelo_proximo
        FROM motos;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Modelo Anterior     | Modelo Atual   | Modelo Pr�ximo   ');
    DBMS_OUTPUT.PUT_LINE('---------------------|----------------|-------------------');

    FOR r IN c_motos_contexto LOOP
        DBMS_OUTPUT.PUT_LINE(
            RPAD(r.modelo_anterior, 21) || ' | ' ||
            RPAD(r.modelo, 16)          || ' | ' ||
            RPAD(r.modelo_proximo, 18)
        );
    END LOOP;
END;
/
