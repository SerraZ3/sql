DROP DATABASE IF EXISTS ecommerce_db;

-- Cria banco de dados
CREATE DATABASE ecommerce_db;

-- Seleciona banco de  dados para uso
USE ecommerce_db;

-- Cria tabela de usuário
CREATE TABLE users (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    birthdate DATE
);


-- Altera tabela
ALTER TABLE users ADD is_admin TINYINT DEFAULT 0;

-- Insere um ou mais usuário
INSERT INTO users (name, email, birthdate)
VALUES 
	("Henrique Serra", "henrique@email.com", "1999-11-10"),
    ("Luana Silva", "luana@email.com", "1958-11-15"),
    ("Fernanda Silva", "fernanda@email.com", "1988-10-11"),
    ("Beatriz Pereira", "beatriz@email.com", "1958-04-15"),
    ("Ana Maria Rodrigues", "ana@email.com", "1989-02-05"),
    ("Roberto Souza", "roberto@email.com", "1998-01-05"),
    ("Pedro Álvares Cabral", "pedro@email.com", "1968-10-18"),
    ("Ricardo Santos", "ricardo@email.com", "1977-05-25"),
    ("Ana Beatriz Souza", "anabeatriz@email.com", "1988-05-16"),
    ("Matheus Lucas", "matheus@email.com", "1958-11-15"),
    ("Pedro Santana", "pedrosantana@email.com", "1996-11-15");

-- Insere um ou mais usuário
INSERT INTO users (name, email, birthdate, is_admin)
VALUES 
	("Luiz Souza", "luiz@email.com", "1988-11-10", 1),
    ("Fernada Pereira", "fernandapereira@email.com", "1977-04-11", 1);

-- Lista todos os usuários
SELECT * FROM users;

-- Deleta o usuário a partir do id
-- DELETE FROM users WHERE id = 1;

-- Atualiza dados de uma linha
-- UPDATE users 
-- SET 
	-- name = "Henrique Atualizado", 
    -- email = "batatinha@email.com",
   --  birthdate = "1800-11-01"
-- WHERE id = 3;

-- Lista colunas de uma tabela
SELECT name, email FROM users;

-- Renomear colunas e tabelas
SELECT name AS nome, email AS "e-mail" FROM users AS u;

-- Busca todos os usuários que são adm
SELECT * FROM users 
WHERE is_admin = 1;

-- Busca por adm que nasceu depois de 1980
SELECT * FROM users 
WHERE is_admin = 1 AND birthdate > "1980-01-01";

-- Busca por adm ou usuário que nasceu depois de 1980
SELECT * FROM users 
WHERE is_admin = 1 OR birthdate > "1980-01-01";

-- Busca usuário com id 1, 4 ou 8
SELECT * FROM users
WHERE id = 1 OR id = 4 OR id= 8;

-- Busca usuário com id 1, 4 ou 8
SELECT * FROM users
WHERE id IN (1, 4, 8);

-- Busca por deternado padrão de string
SELECT * FROM users
WHERE name LIKE "%Silva%";

-- Busca por deternado padrão de string
SELECT * FROM users
WHERE name LIKE "Ana%";

-- Busca por deternado padrão de string
SELECT * FROM users
WHERE name LIKE "%S%a";

-- Busca por deternado padrão de string
-- Ordena por nome e depois id
SELECT * FROM users
WHERE name LIKE "%S%a"
ORDER BY name, id DESC;

-- Limita quantidade de linhas
SELECT * FROM users
ORDER BY name
LIMIT 5 OFFSET 5;

SELECT * FROM users
WHERE id >= 3 AND id <= 10;

SELECT * FROM users
WHERE id BETWEEN 3 AND 10;

SELECT CONCAT("Olá, sou ", name) AS saudacao FROM users;

SELECT REPLACE(name, "a", "A") AS "replace" FROM users;

-- Tabela para produtos
CREATE TABLE products (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(200),
  price DECIMAL(10,2) NOT NULL,
  quantity INT UNSIGNED DEFAULT 0
);

-- Tabela para pedidos
CREATE TABLE orders(
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  create_at DATETIME NOT NULL,
  status ENUM("processando", "a caminho", "entregue") DEFAULT "processando",
  user_id INT UNSIGNED,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- users 1 - n orders
-- products n - n orders

-- Tabela intermediária de pedidos e produtos
CREATE TABLE orders_products(
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insere um ou mais produtos
INSERT INTO products (name, description, price, quantity)
VALUES 
	("Camisa Azul", "Camisa que é Azul", 29.93, 10),
	("Camisa Vermelha", "Camisa que é Vermelha", 49.99, 50),
	("Camisa Preta", "Camisa que é Preta", 99.99, 150),
	("Camisa Verde", "Camisa que é Verde", 57.99, 20),
	("Camisa Rosa", "Camisa que é Rosa", 204.99, 60);

-- Lista produtos
SELECT * FROM products;

-- Insere um ou mais produtos
INSERT INTO orders (create_at, status, user_id)
VALUES 
	("2022-07-28 21:29:00", "entregue", 3),
    ("2022-07-28 21:29:00", "entregue", 5),
    ("2022-07-28 21:29:00", "processando", 6),
    ("2022-07-28 21:29:00", "a caminho", 3),
    ("2022-07-28 21:29:00", "processando", 2);
    
-- Lista pedidos
SELECT * FROM  orders;

-- Insere um ou mais produtos
INSERT INTO orders_products (order_id, product_id)
VALUES 
	(1, 1),
    (1, 2),
    (2, 1),
    (2, 5),
    (3, 2),
    (3, 4),
    (4, 1),
    (4, 2),
    (5, 2),
    (5, 5);
    
-- Lista pedidos-produtos
SELECT * FROM orders_products;

-- Lista pedidos concatenado com pedidos-produtos e produtos
SELECT * FROM orders 
INNER JOIN orders_products ON orders.id = orders_products.order_id
INNER JOIN products ON products.id = orders_products.product_id;

-- Lista pedidos concatenado com pedidos-produtos e produtos
-- aplicado com alias
SELECT * FROM orders AS o
INNER JOIN orders_products AS op ON o.id = op.order_id
INNER JOIN products AS p ON p.id = op.product_id;

-- Lista usuarios concatenado com pedidos
SELECT * FROM users
INNER JOIN orders ON users.id = orders.user_id;

-- Lista usuarios concatenado com pedidos
-- aplicado com alias
SELECT * FROM users AS u
INNER JOIN orders AS o ON u.id = o.user_id;

SELECT * FROM users AS u
LEFT JOIN orders AS o ON u.id = o.user_id;

SELECT * FROM orders AS o
INNER JOIN orders_products AS op ON o.id = op.order_id
RIGHT JOIN products AS p ON p.id = op.product_id;

SELECT * FROM orders_products AS op
RIGHT JOIN products AS p ON p.id = op.product_id;

SELECT u.id AS id, u.name AS name FROM users AS u
INNER JOIN orders AS o ON u.id = o.user_id;

SELECT DISTINCT u.id AS id, u.name AS name FROM users AS u
INNER JOIN orders AS o ON u.id = o.user_id;

SELECT u.id AS id, u.name AS name FROM users AS u
INNER JOIN orders AS o ON u.id = o.user_id 
GROUP BY u.id;

SELECT quantity FROM products;

SELECT SUM(quantity) AS "Soma total" FROM products;

SELECT AVG(quantity) AS "Média" FROM products;

SELECT SUM(quantity) AS "Soma total", AVG(quantity) AS "Média" FROM products;

-- Retorna quantidade de linhas na tabela
SELECT COUNT(id) AS "Total de linhas" FROM products;
SELECT COUNT(quantity) AS "Total de linhas" FROM products;

SELECT MIN(quantity) AS "Soma total" FROM products;
SELECT MAX(quantity) AS "Soma total" FROM products;

-- Insere um ou mais produtos
INSERT INTO orders (create_at, status, user_id)
VALUES 
	("2022-07-28 21:29:00", "entregue", 3),
    ("2022-07-28 21:29:00", "entregue", 3),
    ("2022-07-28 21:29:00", "processando", 3),
    ("2022-07-28 21:29:00", "a caminho", 2),
    ("2022-07-28 21:29:00", "processando", 2);


SELECT 
	u.id AS id, 
    u.name AS name,
    COUNT(u.id) AS "Quantidade de pedidos"
FROM users AS u
INNER JOIN orders AS o ON u.id = o.user_id 
GROUP BY u.id
HAVING COUNT(u.id) > 1;
