-- Практическое задание по теме “Транзакции, переменные, представления”


/*
 * 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной 
 * базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу 
 * sample.users. Используйте транзакции.
 */

DROP DATABASE IF EXISTS shop_9ex;
CREATE DATABASE shop_9ex;
USE shop_9ex;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
DROP TABLE IF EXISTS sample;
CREATE TABLE sample (
	id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

START TRANSACTION; -- объявляю старт транзакции
SELECT * FROM users WHERE id = 1; -- вывожу (проверяю) строку с которой буду работать и возможность транзакции 
INSERT INTO sample  
SET id = (SELECT id FROM users WHERE id=1),
 	name = (SELECT name FROM users WHERE id=1),
	birthday_at = (SELECT birthday_at  FROM users WHERE id=1); -- пероношу данные в таблицу
SAVEPOINT users_to_sample_1; -- объявляю точку сохранения
UPDATE users 
SET name = NULL,
	birthday_at = NULL
WHERE id = 1; -- чищу данные после переноса
COMMIT; -- завершаю транзакцию

/*
 * 2. Создайте представление, которое выводит название name товарной позиции 
 * из таблицы products и соответствующее название каталога name из таблицы catalogs.
 */

/*
 * 3. (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены 
 * разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', 
 * '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат 
 * за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном 
 * таблице и 0, если она отсутствует.
 */

/*
 * 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, 
 * который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
 */


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)
/*
 * 1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read
 * должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в 
 * пределах базы данных shop.
 */ 

/*
 * 2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие 
 * первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts, 
 * предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел 
 * доступа к таблице accounts, однако, мог бы извлекать записи из представления username.
 */


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
/*
 * 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
 * в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
 * возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать
 * фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
 */

DELIMITER // -- изменение разделителя (окончание операции)

DROP FUNCTION IF EXISTS hello// 
CREATE FUNCTION hello () -- создаю функцию
RETURNS VARCHAR(255) DETERMINISTIC -- возвращаемый тип 
BEGIN 
	IF TIME(NOW()) >= '6:00:00' AND TIME(NOW()) < '12:00:00' THEN  -- логика отбора по условиям
	RETURN 'Доброго утра';
	ELSEIF TIME(NOW()) >= '12:00:00' AND TIME(NOW()) < '18:00:00' THEN
	RETURN 'Добрый день';
	ELSEIF TIME(NOW()) >= '18:00:00' AND TIME(NOW()) <= '24:59:59' THEN
	RETURN 'Добрый вечер';
	ELSE 
	RETURN 'Доброй ночи';
END IF;	-- конец логического блока
END// -- конец функции

DELIMITER ; -- изменение разделителя (окончание операции)

SELECT hello(); -- вызов функции

/*
 * 2. В таблице products есть два текстовых поля: name с названием товара и description 
 * с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, 
 * когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, 
 * добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить 
 * полям NULL-значение необходимо отменить операцию.
 */

/*
 * 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
 * Числами Фибоначчи называется последовательность в которой число равно сумме двух 
 * предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
 */
