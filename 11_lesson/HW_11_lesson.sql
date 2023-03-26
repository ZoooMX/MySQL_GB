-- Подготовка БД для выполнения ДЗ к 11 уроку

DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE
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

INSERT INTO catalogs (id, name) VALUES
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


-- Практическое задание по теме “Оптимизация запросов”
/*

1) Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа и содержимое поля name.

*/
DROP TABLE IF EXISTS logs;
CREATE TABLE logs(
	date_create DATETIME DEFAULT NOW(), 
	info_id_table VARCHAR(255) NOT NULL,
	info_name_table VARCHAR(255) NOT NULL,
	info_name VARCHAR (255)
	) ENGINE=Archive;
SHOW TABLE STATUS LIKE 'logs'; -- промотр типа таблицы

DELIMITER //
CREATE TRIGGER update_log_u AFTER INSERT ON users
FOR EACH ROW 
BEGIN  
	INSERT INTO logs  
	SET 
	info_name_table = 'users',
	info_id_table = NEW.id, 
	info_name = NEW.email;
END//

CREATE TRIGGER update_log_cat AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN  
	INSERT INTO logs  
	SET 
	info_name_table = 'catalogs',
	info_id_table = NEW.id, 
	info_name = NEW.name;
END//

CREATE TRIGGER update_log_pr AFTER INSERT ON products
FOR EACH ROW 
BEGIN  
	INSERT INTO logs  
	SET 
	info_name_table = 'products',
	info_id_table = NEW.id, 
	info_name = NEW.name;
END//
DELIMITER ;


INSERT users (firstname, lastname, email)
VALUES 
('Petr','Yaskovenko', 'p.ya@ya.ru');

 
INSERT INTO catalogs (id, name)
VALUES
  ('6', 'SSD');

 INSERT INTO products
   (name, description, price, catalog_id)
VALUES
   ('Seagate M2 512Gb', 'SSD 512GB', 12060.00, 6); 
 
-- /*
-- 
-- 2) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
-- 
-- **/
 
 
DROP TABLE IF EXISTS users_test;
CREATE TABLE users_test (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE
);

DROP PROCEDURE IF EXISTS create_users_test;
DELIMITER // -- меняю делимитр на двойно слэш
CREATE PROCEDURE create_users_test(IN n INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	WHILE n > i DO -- условие цикла while
		INSERT users_test (id, firstname, lastname, email) 
		VALUES (n, CONCAT(n, '_firstname'), CONCAT(n, '_lastname'), CONCAT(n, '@email.com')); -- наполнение таблицы
		SET n = n - 1; -- после итерации уменьшает значение на 1
	END WHILE; -- конец цикла
END //

DELIMITER ; -- возвращаю делимитр на точку с запятой

CALL create_users_test(100); -- вызов процедуры, можно задать любое значение в принимаемом аргументе

SELECT * FROM users_test
ORDER BY id DESC LIMIT 1; -- проверка последнего значения 

