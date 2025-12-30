USE oficina_mecanica;

INSERT INTO clientes
(nome, nome_meio, sobrenome, tipo_pessoa, identificacao, endereco, contato)
VALUES
('Carlos', NULL, 'Silva', 'CPF', '12345678901', 'Rua das Flores, 100', '11999990001'),
('Ana', 'M', 'Oliveira', 'CPF', '98765432100', 'Av. Brasil, 250', '11999990002'),
('Oficina XPTO', NULL, 'LTDA', 'CNPJ', '11222333000199', 'Rua Industrial, 500', '1133334444');

INSERT INTO equipe_mecanica
(codigo_mec, nome, sobrenome, especialidade, endereco, contato)
VALUES
(101, 'João', 'Mecânico', 'Motor', 'Rua A, 10', '11988880001'),
(102, 'Pedro', 'Souza', 'Suspensão', 'Rua B, 20', '11988880002'),
(103, 'Marcos', 'Lima', 'Elétrica', 'Rua C, 30', '11988880003');

INSERT INTO carros
(placa, modelo, observacao)
VALUES
('ABC1D23', 'Gol 1.6', 'Veículo revisado'),
('XYZ9K87', 'Civic 2.0', 'Troca de embreagem'),
('QWE4R56', 'Onix 1.0', 'Revisão preventiva');

INSERT INTO cliente_carro
(id_cliente, id_carro)
VALUES
(1, 1),
(2, 2),
(1, 3);

INSERT INTO ordem_servico
(id_cliente, id_carro, data_emissao, data_entrega, status, valor_total)
VALUES
(1, 1, '2025-01-05', '2025-01-07', 'EM_EXECUCAO', 0),
(2, 2, '2025-01-06', '2025-01-10', 'AGUARDANDO_APROVACAO', 0),
(1, 3, '2025-01-08', '2025-01-09', 'FINALIZADA', 0);

INSERT INTO equipe_ordem_servico
(id_equipe, id_ordem_servico)
VALUES
(1, 1),
(2, 1),
(3, 2),
(1, 3);

INSERT INTO peca
(nome, descricao, valor_unitario)
VALUES
('Filtro de Óleo', 'Filtro para motor', 35.90),
('Pastilha de Freio', 'Jogo dianteiro', 180.00),
('Óleo 5W30', 'Lubrificante sintético', 55.00),
('Bateria 60Ah', 'Bateria automotiva', 420.00);

INSERT INTO estoque
(id_peca, quantidade)
VALUES
(1, 50),
(2, 20),
(3, 100),
(4, 10);

INSERT INTO ordem_servico_peca
(id_ordem_servico, id_peca, quantidade, valor_unitario)
VALUES
(1, 1, 1, 35.90),
(1, 3, 4, 55.00),
(2, 4, 1, 420.00),
(3, 2, 1, 180.00),
(3, 3, 3, 55.00);


-- Atualizando valor total da O.S
UPDATE ordem_servico os
SET valor_total = (
    SELECT SUM(quantidade * valor_unitario)
    FROM ordem_servico_peca osp
    WHERE osp.id_ordem_servico = os.id_ordem_servico
);

-- Historico do cliente
SELECT c.nome, os.id_ordem_servico, os.status, os.valor_total
FROM clientes c
JOIN ordem_servico os ON os.id_cliente = c.id_cliente
WHERE c.id_cliente = 1;

--  Peças usadas na O.S 
SELECT p.nome, osp.quantidade, osp.valor_unitario
FROM ordem_servico_peca osp
JOIN peca p ON p.id_peca = osp.id_peca
WHERE osp.id_ordem_servico = 1;



-- Consumo total de peças na O.S 
SELECT p.nome, SUM(osp.quantidade) AS total_utilizado
FROM ordem_servico_peca osp
JOIN peca p ON p.id_peca = osp.id_peca
GROUP BY p.nome;

