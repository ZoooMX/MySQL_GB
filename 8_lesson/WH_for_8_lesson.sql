-- Урок 8. Вебинар. Сложные запросы

USE VK;

/*
1. Пусть задан некоторый пользователь id=1. Из всех друзей этого пользователя найдите 
человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
*/

SELECT 
	CONCAT(u.firstname, ' ', lastname) AS fullname, -- объединяю имя и фамилию
	COUNT(*) AS cnt_msg -- счетчик сообщений
from users u  
JOIN messages m  
ON  u.id = m.from_user_id OR u.id = m.to_user_id -- условие для JOIN 
WHERE u.id = 2; -- id пользователя по которому считает счетчик


/*
2. Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.
*/

SELECT 
	COUNT(*) AS cnt -- счетчик
FROM profiles p 
JOIN likes l
ON p.user_id = l.user_id -- логика для JOIN соответствия
WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 11; -- подсчитывание возраста и логическое условия для выборки из profiles

/*
3. Определить кто больше поставил лайков (всего): мужчины или женщины.
*/

SELECT 
	COUNT(gender) AS cnt_likes, -- счетчик лайков 
	p.gender -- наименование пола
FROM profiles p 
JOIN likes l  
ON p.user_id = l.user_id -- логика для JOIN соответствий 
WHERE p.gender = 'f' -- вывод запроса по женскому полу
UNION -- объединяю запросы
SELECT 
	COUNT(gender) AS cnt_likes,
	p.gender 
FROM profiles p 
JOIN likes l2 
ON p.user_id = l2.user_id  
WHERE p.gender = 'm'; -- вывод запроса по мужскому полу
