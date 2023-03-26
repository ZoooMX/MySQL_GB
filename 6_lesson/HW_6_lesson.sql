-- Урок 6. Вебинар. Операторы, фильтрация, сортировка и ограничение. Агрегация данных
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”


-- 1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- РЕШЕНИЕ
SELECT 
	from_user_id,
	(SELECT CONCAT(firtsname, ' ', lastname) FROM users 
		WHERE id = masseges.from_user_id) as fullname, -- полное имя друга
	COUNT(*) AS cnt -- счетчик 
FROM messages -- наименование таблицы 
WHERE to_user_id  = 1 -- кому отностятся сообщения
AND from_user_id IN (
	SELECT initiator_users_id FROM friend_requests
	WHERE (target_user_id = 1) AND status = 'approved' -- подтвержденные заявки пользователю 1
UNION -- объединение
	SELECT target_user_id FROM friend_requests
	WHERE (initiator_users_id = 1) AND status = 'approved') -- подтвержденные заявки от пользователя 1
GROUP BY from_users_id -- группировка
ORDER BY cant DESC -- сортировка от большего к меньшему
LIMIT 1; -- выводить только 1 
-- доработал после разбора, при выполнении задания выполнил не полностью


-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.

-- шаг 1
SELECT user_id FROM profiles 
WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 11
; -- нахожу в таблице profiles пользователей, возраст которых меньше 11

-- РЕШЕНИЕ
SELECT COUNT(*) AS cnt_likes -- счетчик
FROM likes 
WHERE media_id IN(
	SELECT id FROM media WHERE user_id IN (
		SELECT user_id FROM profiles 
		WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 11)
); -- объединяю логику следования по таблицам



-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT (SELECT gender FROM profiles WHERE user_id = l.user_id) AS gender, -- запрос пола и таблицы профилей	
	COUNT(*) AS cnt -- счетчик пола
FROM likes l 
GROUP BY gender -- грцппировка по полу
ORDER BY cnt DESC; -- сортировка от большего к меньшему  