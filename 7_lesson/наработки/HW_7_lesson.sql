
-- 1.Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

USE shop;

SELECT 
	firstname AS 'имя', 
	lastname AS 'фамилия',
	order_num AS 'номкер заявки', -- обращаюсь к записи номера заявки в  orders
	name AS 'товар', -- обращаюсь к записи наименования товара в catalogs
	price AS 'цена' -- обращаюсь к записи цены в catalogs
FROM users
JOIN orders -- соединяю таблицы
ON users.id = orders.user_id -- логика соединения
JOIN catalogs
ON orders.product_id = catalogs.catalogs_id; -- выводит имя фамилию номер заявки наименование товара только тех, кто купил

-- 2.Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT 