-- Подготовка БД для выполнения ДЗ к 7 уроку

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
 
INSERT INTO users (firstname, lastname, email)
VALUES	
('Ivan','Smirnov','ivan.s@mail.ru'),
('Anya','Shirina','shirina.a@mail.ru'),
('Andrey','Platonov','bax666@inbox.ru'),
('Denis','Stupin','den.s@ya.ru'),
('Irina','Shiraeva','shirya@mai.ru');


DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  	id SERIAL PRIMARY KEY,
  	name VARCHAR(255) COMMENT 'Название раздела',
  	UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  ('1', 'Процессоры'),
  ('2', 'Материнские платы'),
  ('3', 'Видеокарты'),
  ('4', 'Жесткие диски'),
  ('5', 'Оперативная память');
 
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
  	name VARCHAR(255) COMMENT 'Название',
  	description TEXT COMMENT 'Описание',
  	price DECIMAL (11,2) COMMENT 'Цена',
  	catalog_id BIGINT UNSIGNED,
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	KEY index_of_catalog_id (catalog_id),
  	FOREIGN KEY (catalog_id) REFERENCES catalogs(id) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

 
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  	id SERIAL PRIMARY KEY,
 	user_id BIGINT UNSIGNED,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	KEY index_of_user_id(user_id),
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT = 'Заказы';

INSERT INTO orders
	(id ,user_id)
VALUES
('1','1'),
('2','1'),
('3','2'),
('4','5'),
('5','1'),
('6','5'),
('7','1');


DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
 	id SERIAL PRIMARY KEY,
 	order_id BIGINT UNSIGNED,
 	product_id BIGINT UNSIGNED,
 	total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
 	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (order_id) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT = 'Состав заказа';

INSERT INTO orders_products 
	(id, order_id, product_id, total)
VALUES
('1','1','1','23'),
('2','2','2','14'),
('3','3','1','5'),
('4','4','1','2'),
('5','5','4','8'),
('6','6','3','6'),
('7','7','2','3');

-- 1.Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT 
	firstname AS 'имя', 
	lastname AS 'фамилия',
	orders.id AS 'номкер заявки', -- обращаюсь к записи номера заявки в  orders
	orders_products.total AS 'кол-во',
	products.name AS 'товар', -- обращаюсь к записи наименования товара в catalogs
	products.price AS 'цена' -- обращаюсь к записи цены в catalogs
FROM users
JOIN orders -- соединяю таблицы
ON users.id = orders.user_id  -- логика соединения
JOIN orders_products 
ON orders.id = orders_products.order_id
JOIN products
ON orders_products.product_id = products.id; -- выводит имя фамилию номер заявки, количество, наименование товара и цену только тех, кто купил


-- 2.Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
	products.name AS 'Наименование товара',
	catalogs.name AS 'Каталог'
FROM products
JOIN catalogs 
ON products.catalog_id = catalogs.id;
	
-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица 
-- городов cities (label, name). Поля from, to и label содержат английские названия 
-- городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

--  НЕ РЕШЕНА
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	label VARCHAR (100),
	name VARCHAR (100),
	PRIMARY KEY(label)
	);

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	from_city VARCHAR (100),
	to_city VARCHAR (100),
	FOREIGN KEY (from_city) REFERENCES cities(label) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (to_city) REFERENCES cities(label) ON UPDATE CASCADE ON DELETE CASCADE
	);

INSERT cities 
	(label, name)
VALUES
('moscow','Москва'),
('irkutsk','Иркутск'),
('novgorod','Новогород'),
('kazan','Казань'),
('omsk','Омск');

INSERT flights
	(id, from_city, to_city)
VALUES
('1','moscow','omsk'),
('2','novgorod','kazan'),
('3','irkutsk','moscow'),
('4','omsk','irkutsk'),
('5','moscow','kazan');

SELECT * FROM flights;

SELECT -- не решил задачу
	flights.from_city AS '1',
	flights.to_city AS '2'
FROM flights 
RIGHT JOIN cities 
ON flights.from_city = cities.name AND flights.to_city = cities.name;
