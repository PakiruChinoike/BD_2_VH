CREATE DATABASE exerc2;
USE exerc2;

-- Criação da tabela Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Criação da tabela Produtos
CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

-- Criação da tabela Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE
);

-- Criação da tabela Pedido_Produtos
CREATE TABLE Pedido_Produtos (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto) ON DELETE CASCADE
);

INSERT INTO Clientes(nome, email) VALUES 
	('Hugo', 'hugo@email.com'), 
	('Milena', 'milena@email.com'), 
    ('Jonas', 'jonas@email.com'),
    ('Lilo', 'lilo@email.com'),
    ('Búfalo', 'bufalo@email.com');
    
INSERT INTO Produtos(nome_produto, preco) VALUES
	('Vassoura', 20.00),
    ('Peruca', 500.00),
    ('Óculos', 50.00),
    ('Guitarra', 750.00),
    ('Banana', 3.00);
    
INSERT INTO Pedidos(id_cliente, data_pedido) VALUES
	(1, '2024-06-12'),
    (1, '2023-05-07'),
    (3, '2023-06-08'),
    (4, '2024-08-02'),
    (5, '2024-02-27');
    
INSERT INTO Pedido_Produtos(id_pedido, id_produto, quantidade) VALUES 
	(1, 5, 10), 
    (2, 3, 1), 
    (3, 2, 2), 
    (4, 5, 5),
    (5, 4, 1);
    
SELECT pe.id_pedido, c.nome, pr.nome_produto, pp.quantidade
	FROM Pedidos AS pe 
    JOIN Clientes AS c ON pe.id_cliente = c.id_cliente
    JOIN Pedido_Produtos AS pp ON pe.id_pedido = pp.id_pedido
    JOIN Produtos AS pr ON pp.id_produto = pr.id_produto;

SELECT c.nome, pe.data_pedido 
	FROM Clientes AS c
    LEFT JOIN Pedidos AS pe ON c.id_cliente = pe.id_cliente;
    
SELECT pr.nome_produto, pp.id_pedido
	FROM Pedido_Produtos AS pp
    RIGHT JOIN Produtos AS pr ON pp.id_produto = pr.id_produto;
    
INSERT INTO Clientes(nome, email) VALUES ('Escobar', 'escobar@ifsul.edu.br');
INSERT INTO Pedidos(id_cliente, data_pedido) VALUES (6, '2024-07-08');
INSERT INTO Pedido_Produtos(id_pedido, id_produto, quantidade) VALUES (6, 3, 1);

SELECT c.nome, pe.data_pedido, pr.nome_produto, pp.quantidade
	FROM Pedidos AS pe 
    JOIN Clientes AS c ON pe.id_cliente = c.id_cliente
    JOIN Pedido_Produtos AS pp ON pe.id_pedido = pp.id_pedido
    JOIN Produtos AS pr ON pp.id_produto = pr.id_produto
	WHERE c.email LIKE '%ifsul.edu.br';
    
SELECT c.nome, SUM(pr.preco)*pp.quantidade AS total_gasto
	FROM Pedido_Produtos AS pp
    JOIN Produtos AS pr ON pp.id_produto = pr.id_produto
    JOIN Pedidos AS pe ON pp.id_pedido = pe.id_pedido
    JOIN Clientes AS c ON pe.id_cliente = c.id_cliente
    GROUP BY c.nome, pp.quantidade;