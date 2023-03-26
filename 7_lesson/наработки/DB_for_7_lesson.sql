DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	INDEX users_lastname_idx(lastname)
);

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	catalogs_id SERIAL PRIMARY KEY,
	name VARCHAR (150),
	price INT,
	INDEX communities_name_idx(name)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	order_num BIGINT UNIQUE NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	product_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	PRIMARY KEY (user_id, product_id),
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES catalogs(catalogs_id) ON UPDATE CASCADE ON DELETE CASCADE
);
	


INSERT INTO users (firstname, lastname, email)
VALUES	
('Ivan','Smirnov','ivan.s@mail.ru'),
('Anya','Shirina','shirina.a@mail.ru'),
('Andrey','Platonov','bax666@inbox.ru'),
('Denis','Stupin','den.s@ya.ru'),
('Irina','Shiraeva','shirya@mai.ru');

INSERT INTO catalogs (name, price)
VALUES 
('apple','80'),
('carrot','60'),
('potato','140'),
('watermelon','500');

INSERT INTO orders (order_num, user_id, product_id)
VALUES 
('1', '1', '3'),
('2', '1', '2'),
('3', '2', '1'),
('4', '1', '4'),
('5', '2', '4');