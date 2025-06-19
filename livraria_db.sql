-- =============================================================================
-- Este script cria as tabelas e insere  dados para exemplo.
-- Resolução Atividade checkout projeto integrador 2
-- =============================================================================

-- CRIAÇÃO DAS TABELAS

-- Tabela de Clientes
CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Produtos
CREATE TABLE Produtos (
    produto_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    autor VARCHAR(150),
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0
);

-- Tabela de Pedidos
CREATE TABLE Pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'Pendente',
    CONSTRAINT fk_cliente
        FOREIGN KEY(cliente_id) 
        REFERENCES Clientes(cliente_id)
);

-- Tabela de Itens do Pedido (tabela de junção)
CREATE TABLE ItensPedido (
    item_id SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_pedido
        FOREIGN KEY(pedido_id) 
        REFERENCES Pedidos(pedido_id),
    CONSTRAINT fk_produto
        FOREIGN KEY(produto_id) 
        REFERENCES Produtos(produto_id),
    UNIQUE(pedido_id, produto_id)
);


-- INSERÇÃO DE DADOS DE EXEMPLO

-- Inserindo 3 clientes
INSERT INTO Clientes (nome, email) VALUES
('Ana Silva', 'ana.silva@email.com'),
('Bruno Costa', 'bruno.costa@email.com'),
('Carla Dias', 'carla.dias@email.com');

-- Inserindo 3 produtos
INSERT INTO Produtos (nome, autor, preco, estoque) VALUES
('Engenharia de Software Moderna', 'Marco Tulio Valente', 89.90, 15),
('Sistemas de Bancos de Dados', 'Elmasri & Navathe', 150.00, 10),
('O Programador Pragmático', 'Andrew Hunt', 95.50, 20);

-- Inserindo 3 pedidos
-- Pedido 1 para o cliente 1 (Ana)
INSERT INTO Pedidos (cliente_id, status) VALUES (1, 'Enviado');
-- Pedido 2 para o cliente 2 (Bruno)
INSERT INTO Pedidos (cliente_id, status) VALUES (2, 'Concluído');
-- Pedido 3 para o cliente 1 (Ana)
INSERT INTO Pedidos (cliente_id, status) VALUES (1, 'Processando');

-- Inserindo itens nos pedidos
-- Itens do Pedido 1 (pedido_id = 1)
INSERT INTO ItensPedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 89.90), -- 1x Engenharia de Software
(1, 3, 1, 95.50); -- 1x O Programador Pragmático

-- Itens do Pedido 2 (pedido_id = 2)
INSERT INTO ItensPedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(2, 2, 1, 150.00); -- 1x Sistemas de Bancos de Dados

-- Itens do Pedido 3 (pedido_id = 3)
INSERT INTO ItensPedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(3, 1, 2, 89.90); -- 2x Engenharia de Software
