CREATE DATABASE oficina_mecanica;
USE oficina_mecanica;

-- =========================
-- CLIENTES
-- =========================
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    nome_meio CHAR(3),
    sobrenome VARCHAR(45) NOT NULL,
    tipo_pessoa ENUM ('CPF','CNPJ') NOT NULL,
    identificacao CHAR(14) NOT NULL,
    endereco VARCHAR(250) NOT NULL,
    contato VARCHAR(11),

    CONSTRAINT uq_cliente_identificacao UNIQUE (identificacao),

    CONSTRAINT chk_cliente_documento
    CHECK (
        (tipo_pessoa = 'CPF'  AND CHAR_LENGTH(identificacao) = 11)
        OR
        (tipo_pessoa = 'CNPJ' AND CHAR_LENGTH(identificacao) = 14)
    )
);

-- =========================
-- EQUIPE MECÂNICA
-- =========================
CREATE TABLE equipe_mecanica (
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,
    codigo_mec INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    especialidade VARCHAR(45) NOT NULL,
    endereco VARCHAR(250),
    contato VARCHAR(11)
);

-- =========================
-- CARROS
-- =========================
CREATE TABLE carros (
    id_carro INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(8) NOT NULL UNIQUE,
    modelo VARCHAR(45),
    observacao VARCHAR(100)
);

-- =========================
-- CLIENTE ↔ CARRO (N:N)
-- =========================
CREATE TABLE cliente_carro (
    id_cliente INT,
    id_carro INT,

    PRIMARY KEY (id_cliente, id_carro),

    CONSTRAINT fk_cc_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT fk_cc_carro
        FOREIGN KEY (id_carro)
        REFERENCES carros(id_carro)
);

-- =========================
-- ORDEM DE SERVIÇO
-- =========================
CREATE TABLE ordem_servico (
    id_ordem_servico INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_carro INT NOT NULL,

    data_emissao DATE NOT NULL,
    data_entrega DATE,

    status ENUM (
        'ABERTA',
        'AGUARDANDO_APROVACAO',
        'EM_EXECUCAO',
        'FINALIZADA',
        'CANCELADA'
    ) DEFAULT 'ABERTA',

    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_os_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT fk_os_carro
        FOREIGN KEY (id_carro)
        REFERENCES carros(id_carro)
);

-- =========================
-- EQUIPE ↔ ORDEM DE SERVIÇO (N:N)
-- =========================
CREATE TABLE equipe_ordem_servico (
    id_equipe INT,
    id_ordem_servico INT,

    PRIMARY KEY (id_equipe, id_ordem_servico),

    CONSTRAINT fk_eos_equipe
        FOREIGN KEY (id_equipe)
        REFERENCES equipe_mecanica(id_equipe),

    CONSTRAINT fk_eos_os
        FOREIGN KEY (id_ordem_servico)
        REFERENCES ordem_servico(id_ordem_servico)
);

-- =========================
-- PEÇAS
-- =========================
CREATE TABLE peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    descricao VARCHAR(250),
    valor_unitario DECIMAL(10,2) NOT NULL
);

-- =========================
-- ESTOQUE
-- =========================
CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_peca INT NOT NULL,
    quantidade INT NOT NULL,

    CONSTRAINT fk_estoque_peca
        FOREIGN KEY (id_peca)
        REFERENCES peca(id_peca)
);

-- =========================
-- ORDEM DE SERVIÇO ↔ PEÇAS (N:N)
-- =========================
CREATE TABLE ordem_servico_peca (
    id_ordem_servico INT,
    id_peca INT,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_ordem_servico, id_peca),

    CONSTRAINT fk_osp_os
        FOREIGN KEY (id_ordem_servico)
        REFERENCES ordem_servico(id_ordem_servico),

    CONSTRAINT fk_osp_peca
        FOREIGN KEY (id_peca)
        REFERENCES peca(id_peca)
);
