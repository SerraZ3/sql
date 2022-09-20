CREATE DATABASE school_db;

use school_db;

CREATE TABLE students(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(255) NOT NULL,
    birthdate DATE,
    classroom VARCHAR(255) NOT NULL,
    school_average DECIMAL(4, 2) NOT NULL,
    is_active TINYINT DEFAULT 0,
    created_at DATETIME ,
    updated_at DATETIME 
    
);

-- drop database school_db;