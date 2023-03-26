-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 6. Скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы) 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- ========================================================
-- -------------------- SELECT запрос ---------------------
-- ========================================================

-- SELECT запрос с группировкой и счетчиком
USE ohs_gss;
SELECT 
	COUNT(*) AS 'кол-во сотрудников',
	num_me AS 'пункты МО'
FROM 
	medical_examination
WHERE 
	num_me = 'п.11.4'
GROUP BY num_me;

-- ========================================================
-- -------------------- JOIN запросы ----------------------
-- ========================================================

-- 1)Опредиление даты, когда необходимо пройти повторную проверку знаний руководителям и рабочим по программам охраны труда. 
SELECT 
	CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О.', -- объединение фамилии имени и отчества
	st.positions AS 'Должность',
	DATE(tw.end_training) AS 'Дата повт.обучения', -- дата повторной проверки знаний
	tt.name_training AS 'Программа обучения'	
FROM
	workers w
JOIN staffing_table st ON st.id = w.id
JOIN training_workers tw ON tw.workers_t = w.id 
JOIN training_type tt ON tt.id = tw.training_t 
WHERE tt.id = '2' OR tt.id = '3' OR tt.id = '4' OR tt.id = '5' OR tt.id = '6' -- условие отбора программ по охране труда
ORDER BY tw.end_training; -- сортировка по дате от ближайшего к дальнему


-- 2)Вывод кто из сотрудников какой инструктаж прошел (на рабочем месте)
SELECT 
	CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О. интруктируемого', -- объединение фамилии имени и отчества
	bw.name_breifing AS 'Вид инструктажа',
	DATE(bw.date_brifing) AS 'Дата прохождения',
	st.positions AS 'Должность'
	FROM 
	briefing_workers bw 
JOIN
	workers w ON w.id = bw.to_worker_id
JOIN 
	staffing_table st ON w.postition_w = st.id
WHERE bw.name_breifing = 'РМ' OR bw.name_breifing = 'РМ-П' OR bw.name_breifing = 'РМ-В' OR bw.name_breifing = 'РМ-Ц'
ORDER BY bw.date_brifing ; -- сортировка по должностям
 

-- 3) Вывод сотрудников отвественных за иснтруктаж на рабочем месте
SELECT 
	CONCAT(w2.firstname, ' ', w2.lastname, ' ', w2.surname) AS  'Ф.И.О. интруктирующего', -- объединение фамилии имени и отчества
	st2.positions AS 'Должность'
FROM 
	briefing_workers bw2 
JOIN	
	workers w2 ON w2.id = bw2.from_worker_id 
JOIN 
	staffing_table st2 ON  st2.id = w2.postition_w 
GROUP BY w2.id; -- группировка для исключкения дублирования


-- 4) Выводит сотрудника с id=13, c информацией о полученных СИЗ.
SELECT 
	CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О.', -- объединение фамилии имени и отчества
	st.positions AS 'Должность',
	DATE(w.start_date_d) AS 'Дата трудоустройства',
	DATE(pw.date_ppe) AS 'Дата выдачи СИЗ', 
	p.name_ppe AS 'Наименование СИЗ',
	p.season_ppe AS 'Сизон'
FROM 
	ppe_workers pw 
JOIN 
	ppe p ON p.id = pw.ppe_id  
JOIN 
	workers w ON pw.ppe_worker_id = w.id 
JOIN 
	staffing_table st ON st.id = w.id 
WHERE 
	w.id = '13'
ORDER BY pw.date_ppe;

-- ========================================================
-- -------------------- Пердаставления --------------------
-- ========================================================

-- 1) Cоздает таблицу(представление) с членами комиссии по всем видам проверки зананий
CREATE OR REPLACE VIEW view_commission 
AS 
	SELECT 
		CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О.', -- объединение фамилии имени и отчества
		st.positions AS 'Должность',
		tt.name_training AS 'Вид_обучения',
		DATE(tw.end_training) AS 'Конец_срока_действия' 
	FROM workers w 
	JOIN 
		staffing_table st ON w.id = st.id 
	JOIN 
		training_workers tw ON tw.workers_t = w.id 
	JOIN 
		training_type tt ON tt.id = tw.training_t 
	WHERE 
		tt.place_trainig = 'УЦ' OR tt.place_trainig = 'РТН';

SELECT *  FROM view_commission
WHERE Вид_обучения LIKE 'Эл%'; -- проверка запросом с применением регулярки


-- 2) Таблица по медосмотрам и данными сотрудников
CREATE OR REPLACE VIEW view_medical_examination_info
AS
	SELECT 
		CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О.', -- объединение фамилии имени и отчества
		st.positions AS 'Должность',
		me.num_me AS 'Номер пункта МО',
		DATE(me.date_me_re) AS 'Дата повторного МО'
	FROM 	
		workers w 
	JOIN 
		medical_examination me ON me.me_worker_id = w.id
		JOIN 
		staffing_table st ON st.id = me.me_st_id
	WHERE 
		st.structurial_usnit = 'Основное производство';
		
SELECT COUNT(*) AS 'Кол-во сотрудников с МО в "поле"' FROM view_medical_examination_info;

SELECT * FROM view_medical_examination_info
WHERE Должность = 'Водитель'; -- проверка запросом


-- ========================================================
-- ------------------ Хранимые процедуры ------------------
-- ========================================================

-- 1) Процедура показывающая у кого подходит окончание сроков обучения (менее i дней)
DELIMITER //
DROP PROCEDURE IF EXISTS re_treining //
CREATE PROCEDURE re_treining(IN i INT)
	BEGIN
		DECLARE i INT DEFAULT 0;
		SELECT 
			DATE(tw.end_training) AS 'Дата окончания обучения',
			CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О.',
			tt.name_training AS 'Наименование обучения',
			tt.place_trainig AS 'Место обучения'
		FROM 
			training_workers tw 
		JOIN
			workers w ON w.id = tw.workers_t 
		JOIN 
			training_type tt ON tt.id = tw.training_t 
		WHERE i >= DATE(end_training) - DATE(NOW());
		
	END //
DELIMITER ;

CALL re_treining('30');


-- 2) Процедура, которая выводит список персонала с контактным номером в зависимости от введенных данных.
DELIMITER //
DROP PROCEDURE IF EXISTS workers_in_staffing_table //
DROP PROCEDURE IF EXISTS adm_workers //
CREATE PROCEDURE workers_in_staffing_table(IN i INT)
	BEGIN
		IF (i = 1) THEN -- создаю условия через IF
			SELECT 
				CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О.',
				st.structurial_usnit AS 'Подразделение',
				st.positions AS 'Должность',
				w.phone AS 'Телефон'
			FROM 
				workers w  
			JOIN
				staffing_table st ON st.id = w.id 
			WHERE st.structurial_usnit  = 'Администрация';
		ELSEIF (i = 2) THEN
			SELECT 
				CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О.',
				st.structurial_usnit AS 'Подразделение',
				st.positions AS 'Должность',
				w.phone AS 'Телефон'
			FROM 
				workers w  
			JOIN
				staffing_table st ON st.id = w.id 
			WHERE st.structurial_usnit  = 'Основное производство';
		ELSEIF (i = 3) THEN
			SELECT 
				CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О.',
				st.structurial_usnit AS 'Подразделение',
				st.positions AS 'Должность',
				w.phone AS 'Телефон'
			FROM 
				workers w  
			JOIN
				staffing_table st ON st.id = w.id 
			WHERE st.structurial_usnit  = 'ОП в г.Норильске';
		ELSEIF (i = 4) THEN 
			SELECT 
				CONCAT(w.firstname, ' ', w.lastname, ' ', w.surname) AS  'Ф.И.О.',
				st.structurial_usnit AS 'Подразделение',
				st.positions AS 'Должность',
				w.phone AS 'Телефон'
			FROM 
				workers w  
			JOIN
				staffing_table st ON st.id = w.id;
		ELSE
			SELECT 'Посторите запрос. Введите номер подразделения или "4" - все подразделения';
		END IF;
	END //
DELIMITER ;

CALL workers_in_staffing_table('42'); -- проверка процедуры 
	
-- ========================================================
-- ----------------------- Триггеры -----------------------
-- ========================================================

-- 1) Триггер выдает ошибку если дата трудоустройства была позже текущей даты
DELIMITER //
DROP TRIGGER IF EXISTS worker_start_date //
CREATE TRIGGER worker_start_date BEFORE INSERT 
ON workers FOR EACH ROW 
BEGIN 
	IF NEW.start_date_w > NOW() THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Дата трудоустройства не может быть позже текущей даты!';
	END IF;
END//
DELIMITER ;

INSERT INTO workers (firstname, lastname, surname, phone, postition_w, start_date_w) -- проверка триггера
VALUES
('Иван','Иванов','Иванович','89999999661','12','2022-11-11');


-- 2) Триггер записывает лог при добавлении нового сотрудника в БД с фиксацией даты добавления
DROP TABLE IF EXISTS log_workers; -- создание таблицы логов
CREATE TABLE log_workers (
	date_create DATETIME,
	id BIGINT,
	firstname VARCHAR (100), 
	lastname VARCHAR (100),
	surname VARCHAR (100),
	postition_w BIGINT, -- должность
	start_date_w DATETIME -- (start date of employment) дата трудоустройства;
);


DELIMITER //
DROP TRIGGER IF EXISTS trigger_log_workers //
CREATE TRIGGER trigger_log_workers AFTER INSERT -- создание триггера
ON workers FOR EACH ROW 
BEGIN 
	INSERT INTO log_workers 
	SET 
		date_create = NOW(), -- дата добавления сотрудника в БД
		id = NEW.id, 
		firstname = NEW.firstname, 
		lastname = NEW.lastname, 
		surname = NEW.surname, 
		postition_w = NEW.postition_w, 
		start_date_w = NEW.start_date_w;
END//
DELIMITER ;

INSERT INTO workers (firstname, lastname, surname, phone, postition_w, start_date_w) -- проверка триггера
VALUES
('Андрей','Андреев','Андреевич','89999999651','11','2021-11-11');
	
