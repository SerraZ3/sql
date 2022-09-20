CREATE DATABASE IF NOT EXISTS noticias_ja_db;

use noticias_ja_db;

CREATE TABLE images(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    path VARCHAR(50) NOT NULL,
	size INT UNSIGNED,
    extension VARCHAR(10),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE categories(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(200),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE news(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    subtitle VARCHAR(200),
    article TEXT NOT NULL,
    author VARCHAR(100) NOT NULL,
    created_at DATETIME,
    updated_at DATETIME,
    image_id INT UNSIGNED,
    category_id INT UNSIGNED,
    FOREIGN KEY (image_id) REFERENCES images(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
