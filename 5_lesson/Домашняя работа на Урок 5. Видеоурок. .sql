/*

Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»

1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
Заполните их текущими датой и временем.
*/

DROP DATABASE IF EXISTS test; 
CREATE DATABASE test; -- создал БД тестовый для ДР
USE test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	create_at VARCHAR(100), -- создание колонок VARCHAR чтобы были пустыми
	update_at VARCHAR(100), 
	INDEX users_create_at_update_at_idx(create_at, update_at)
);

INSERT users -- команда создания в таблице users
SET -- позволяет задать значение указанного поля
	create_at = NOW(), -- задаю значеня вызовом команды NOW() - возвращает текущее время и дату
	update_at = NOW();
	

/*	

2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были 
заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
*/

DROP DATABASE IF EXISTS test; 
CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	create_at VARCHAR(100), -- создание колонок VARCHAR чтобы были пустыми
	update_at VARCHAR(100), 
	INDEX users_create_at_update_at_idx(create_at, update_at)
);


INSERT users -- команда создания в таблице users
SET -- позволяет задать значение указанного поля
	create_at = '20.10.2017 8:10', -- задаю значеня вызовом команды NOW() - возвращает текущее время и дату
	update_at = '20.10.2017 8:10';

UPDATE users  -- обновляю значения в таблице users
SET -- для указания конкретных столбцов полей, так как возможны другие столбцы с текстом
	create_at = REPLACE(create_at, '.', '-'), -- замена знака на необходимый
	update_at = REPLACE(update_at, '.', '-');


/*
 
3. В таблице складских запасов storehouses_products в поле value могут встречаться 
самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения 
значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.
*/

DROP DATABASE IF EXISTS test; 
CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
	value INT,  
	INDEX storehouses_products_value_idx(value)
);

INSERT INTO storehouses_products (value)
VALUES (0),(2500),(0),(30),(500),(1);

SELECT value FROM storehouses_products ORDER BY value > 0 DESC;



/*

4. (по желанию) Из таблицы users необходимо извлечь пользователей, 
родившихся в августе и мае. Месяцы заданы в виде списка английских 
названий (may, august)
*/

DROP DATABASE IF EXISTS test; 
CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS peoples;
CREATE TABLE peoples (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	m_birthday VARCHAR(100),  
	INDEX peoples_name_m_birthday_idx(name, m_birthday)
);

INSERT INTO peoples (name, m_birthday)
VALUES ('Petr','may'),('Mariya','may'),('Oleg','august'),('Anya','may'),('David','july'),('Sergey','june');

SELECT name, m_birthday FROM peoples WHERE m_birthday = 'may' OR m_birthday = 'august';



/*

5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, 
заданном в списке IN.

*/

DROP DATABASE IF EXISTS test; 
CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	some_info VARCHAR(100), 
	INDEX catalogs_some_info_idx(some_info)
);

INSERT INTO catalogs (some_info)
VALUES ('text1'),('text2'),('text3'),('text4'),('text5'),('text6');

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY id = 5 DESC;




/*

Практическое задание теме «Агрегация данных»

1. Подсчитайте средний возраст пользователей в таблице users.

*/

DROP DATABASE IF EXISTS test; 
CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	birthday_at DATE DEFAULT NULL, -- дата по умолчанию NULL
	INDEX users_name_birthday_at_idx(name, birthday_at)
);

INSERT INTO users (name, birthday_at)
VALUES ('Petr', '1991-07-16'),('Mariya','1990-06-23'),('Oleg','1986-01-11'),('Anya','2001-05-17'),('David','1998-09-09'),('Sergey','2015-01-01');

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age FROM users; 
-- AVG() - возвращает среднее значение
-- TIMESTAMPDIFF() - возвращает значени после вычитания DATATIME из другого
-- YEAR - сокращает дату до года выдаваемый результат (еденица измерения)
-- NOW() - текущее время
-- AS - как - присваивает наименование




/*
 НЕ РЕШЕНА
2.Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.


DROP DATABASE IF EXISTS test; 
CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	birthday_at DATE DEFAULT NULL, -- дата по умолчанию NULL
	INDEX users_name_birthday_at_idx(name, birthday_at)
);

INSERT INTO users (name, birthday_at)
VALUES ('Petr', '1991-07-16'),('Mariya','1990-06-23'),('Oleg','1986-01-11'),('Anya','2001-05-17'),('David','1998-09-09'),('Sergey','2015-01-01');

SELECT TIMESTAMPDIFF(WEEK, birthday_at, NOW()) AS num from users;

*/


/*

3.(по желанию) Подсчитайте произведение чисел в столбце таблицы.
*/

DROP DATABASE IF EXISTS test; 
CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (
	id SERIAL PRIMARY KEY,
	value INT,  
	INDEX tbl_value_idx(value)
);

INSERT INTO tbl (value)
VALUES (1),(2),(3),(4),(5);

SELECT ROUND(EXP(SUM(LOG(value))),1) FROM tbl; -- с решением помогли 
-- LOG() логарифм
-- SUM() сумма
-- EXP() экспонициал
-- ROUND() округление результата


