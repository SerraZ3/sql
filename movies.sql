-- Criando banco de dados
CREATE DATABASE movies_db;

-- Selecionando banco de dados
USE movies_db;

-- Criando tabela
CREATE TABLE movies(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    rating DECIMAL(3,1) UNSIGNED NOT NULL,
    awards INT UNSIGNED DEFAULT 0,
    release_date DATE NOT NULL,
    length INT UNSIGNED
);

-- Apaga tabela
DROP TABLE IF EXISTS movies;

-- Adiciona uma nova coluna na tabela
ALTER TABLE movies ADD description VARCHAR(200);

-- Altera coluna da tabela
ALTER TABLE movies MODIFY description VARCHAR(250);

-- Deleta coluna de uma tabela
ALTER TABLE movies DROP description;
