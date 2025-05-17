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
    status VARCHAR2(20) CHECK (status IN ('ativa','inativa','em manuten��o')) NOT NULL,
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