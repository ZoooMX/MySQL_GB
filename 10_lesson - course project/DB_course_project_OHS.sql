DROP DATABASE IF EXISTS ohs_gss;
CREATE DATABASE ohs_gss; -- создание БД по организации Охраны труда в организации ГСС
USE ohs_gss; 

-- Создание таблиц

-- -- ИСХОДНЫЕ ДАННЫЕ ПО СОТРУДНИКАМ
-- штатное расписание
DROP TABLE IF EXISTS staffing_table; 
CREATE TABLE staffing_table(	
	id SERIAL PRIMARY KEY, 
	structurial_usnit VARCHAR(255) NOT NULL, -- структурное подразделение
	positions VARCHAR(255) NOT NULL -- должность работника
);

INSERT INTO staffing_table (structurial_usnit, positions)
VALUES 
('Администрация', 'Генеральный директор'),
('Администрация', 'Главный инженер'),
('Администрация', 'Заместитель генерального директора по экономике и финансам'),
('Администрация', 'Руководитель камерального отдела'),
('Администрация', 'Руководитель отдела контроля качества'),
('Администрация', 'Начальник экспедиции'),
('Администрация', 'Главный специалист по геофизике'),
('Администрация', 'Главный специаилст по геологии'),
('Администрация', 'Главный специаилст по геодезии'),
('Администрация', 'Руководитель отдела кадров'),
('Администрация', 'Специалист по охране труда'),
('Основное производство', 'Инженер-геолог'),
('Основное производство', 'Инженер-геофизик'),
('Основное производство', 'Инженер-геодезист'),
('Основное производство', 'Машинист буровой установки'),
('Основное производство', 'Водитель-механик'),
('Основное производство', 'Водитель'),
('Основное производство', 'Рабочий'),
('Основное производство', 'Механик'),
('ОП в г.Норильске', 'Инженер-геолог'),
('ОП в г.Норильске', 'Машинист буровой установки'),
('ОП в г.Норильске', 'Водитель-механик'),
('ОП в г.Норильске', 'Водитель'),
('ОП в г.Норильске', 'Рабочий');


-- таблица с работниками
DROP TABLE IF EXISTS workers; 
CREATE TABLE workers (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR (100), 
	lastname VARCHAR (100),
	surname VARCHAR (100),
	phone BIGINT UNSIGNED UNIQUE,
	postition_w BIGINT UNSIGNED NOT NULL, -- должность
	start_date_d DATETIME DEFAULT NOW(), -- (start date of employment) дата трудоустройства
	FOREIGN KEY (postition_w) REFERENCES staffing_table(id)
);

INSERT INTO workers (firstname, lastname, surname, phone, postition_w, start_date_d)
VALUES
('Тамагашев','Дмитрий','Александрович','89999999991','1','2017-05-19'),
('Абрамов','Василий','Анатольевич','89999999992','2','2017-01-16'),
('Сулская','Олеся','Владимировна','89999999993','4','2017-01-16'),
('Хайрединов','Руслан','Михайлович','89999999994','5','2018-01-09'),
('Куликовский','Александр','Олегович','89999999995','3','2020-04-25'),
('Масензов','Вячеслав','Петрович','89999999996','6','2018-07-12'),
('Масензов','Алексей','Павлович','89999999997','19','2020-11-17'),
('Федоров','Георгий','Святославович','89999999998','8','2017-01-16'),
('Попова','Елена','Александровна','8999999981','10','2019-10-22'),
('Сизых','Андрей','Иванович','89999999982','9','2017-01-16'),
('Шишлин','Евгений','Павлович','89999999983','7','2017-01-16'),
('Яковенко','Петр','Юрьевич','89999999984','11','2018-12-10'),
('Федеров','Николай','Юрьевич','89999999883','12','2018-11-28'),
('Новосельцев','Виктор','Викторович','89999999882','12','2022-02-07'),
('Карманов','Гроигорий','Ревирович','89999999981','12','2022-01-16'),
('Латыпов','Радмир','Ильмирович','89999999980','12','2021-10-22'),
('Аксиненко','Слава','Григорьевич','89999999979','12','2021-10-13'),
('Сердюк','Павел','Алексеевич','89999999978','12','2022-06-14'),
('Смиирнов','Дмитрий','Андреевич','89999999977','13','2021-11-08'),
('Ильин','Георгий','Игоревич','89999999976','13','2022-04-04'),
('Чернов','Никита','Сергеевич','89999999975','14','2022-06-01'),
('Чеботарь','Сергей','Сергеевич','89999999974','14','2022-07-18'),
('Середкин','Виталий','Витальевич','89999999973','14','2022-01-27'),
('Тивиков','Сергей','Анатольевич','89999999972','14','2021-11-17'),
('Арсланов','Фанис','Фанилович','89999999971','15','2021-10-28'),
('Чокля','Юрий','Константинович','89999999970','15','2021-10-29'),
('Козлов','Игорь','Анатольевич','89999999969','15','2021-10-29'),
('Трифонов','Илья','Валентинович','89999999968','15','2021-12-03'),
('Рафейчиков','Владимир','Иванович','89999999967','15','2022-01-10'),
('Чуплан', 'Алексей','Викторович','89999999965','15','2022-06-14'),
('Карманов','Евгений','Анатольевич','89999999964','16','2022-06-14'),
('Хулхасов','Алексей','Владимирович','89999999963','16','2022-08-07'),
('Яхно','Николай','Николаевич','89999999962','16','2022-07-13'),
('Колосов','Сергей','Сергеевич','89999999961','16','2022-07-28'),
('Шатрюк','Давыд','Геннадьевич','89999999960','16','2022-07-20'),
('Федоров','Николай','Александрович','89999999959','16','2022-01-27'),
('Масензов','Илья','Алексеевич','89999999958','17','2022-06-22'),
('Лебедев','Иван','Васильевич','89999999957','17','2022-02-25'),
('Кугаевский','Максим','Игоревич','89999999956','17','2022-01-14'),
('Неверовский','Алесандр','Николаевич','89999999955','17','2022-06-10'),
('Воронин','Алексей','Витальевич','89999999954','18','2022-04-27'),
('Дудоровсий','Валерий','Викторович','89999999953','18','2022-04-15'),
('Луковкин','Михаил','Николаевич','89999999952','18','2022-04-12'),
('Заболотский','Денис','Александрович','89999999951','18','2022-03-29'),
('Бобрицкий','Олег','Дмитриевич','89999999950','20','2022-04-29'),
('Широбоков','Лев','Анатольевич','89999999949','21','2022-06-05'),
('Емельянцев','Александр','Сергеевич','89999999948','22','2022-04-29');

-- -- ОБУЧЕНИЕ РАБОТНИКОВ
-- виды обучения
DROP TABLE IF EXISTS training_type; 
CREATE TABLE training_type (
	id SERIAL PRIMARY KEY,
	name_training VARCHAR(255) NOT NULL, -- наименование обучения
	place_trainig ENUM('ВК', 'УЦ', 'РТН'), -- место обучения (внутренняя комиссия организации-ВК, учебный центр-УЦ, ростехнеадзор-РТН)
	valid_period VARCHAR (100) NOT NULL
	);

INSERT INTO training_type (id, name_training, place_trainig, valid_period)
VALUES
('1','Программа для руководителей и специалистов','УЦ', '3 года'),
('2','Программа для руководителей и специалистов','ВК', '3 года'),
('3','Программа для машиниста буровой установки','ВК', '1 год'),
('4','Программа для водителя-механика','ВК', '1 год'),
('5','Программа для водителя','ВК', '1 год'),
('6','Программа для рабочего','ВК', '1 год'),
('11','Оказание первой помощи на произвосдвте','УЦ', '3 года'),
('12','Оказание первой помощи на произвосдвте','ВК', '1 год'),
('21','Электробезопасность - IV гр.','РТН', '1 год'),
('22','Электробезопасность - II гр.','РТН', '1 год'),
('23','Электробезопасность - II гр.','ВК', '1 год'),
('31','Промышленная безопасность','РТН', '5 лет'),
('32','Промышленная безопасность','ВК', '5 лет'),
('41','Экология - обращение с отходами','УЦ', '3 года'),
('51','Защитное, Зимнее вождение','УЦ', '3 года'),
('61','Пожарная безопасность','УЦ','3 года');


-- таблица с обучениями по требованиям ОТ сотрудников
DROP TABLE IF EXISTS training_workers; 
CREATE TABLE training_workers (
	id SERIAL PRIMARY KEY,
	workers_t BIGINT UNSIGNED NOT NULL,
	training_t BIGINT UNSIGNED NOT NULL, -- тип обучение
	date_training DATETIME DEFAULT NOW(), -- дата проведения обучения
	end_training DATETIME DEFAULT NULL, -- дата окончания срока действия обучения
	FOREIGN KEY (workers_t) REFERENCES workers(id),
	FOREIGN KEY (training_t) REFERENCES training_type(id)
	);

INSERT INTO training_workers (workers_t, training_t, date_training, end_training)
VALUES 
('1','1','2020-05-28','2023-05-28'),('1','11','2020-05-28','2023-05-28'),('1','21','2022-05-28','2023-05-28'),('1','31','2022-05-28','2027-05-28'),
('2','1','2020-01-26','2023-01-26'),('2','11','2020-01-26','2023-01-26'),('2','22','2022-01-26','2023-01-26'),('2','31','2022-01-26','2027-01-26'),
('3','2','2020-01-26','2023-01-26'),
('4','2','2021-01-17','2024-01-17'),
('5','2','2020-05-05','2023-05-05'),
('6','2','2021-07-23','2024-07-23'),('6','22','2022-07-23','2023-07-23'),('6','32','2018-07-23','2023-07-23'),
('7','2','2020-11-26','2023-11-26'),('7','22','2021-11-26','2022-11-26'),('7','41','2020-11-26','2023-11-26'),('7','51','2020-11-26','2023-11-26'),
('8','2','2020-01-27','2023-01-27'),('8','22','2022-01-27','2023-01-27'),('8','32','2022-01-27','2027-01-27'),
('9','2','2019-10-28','2022-10-28'),
('10','1','2020-01-27','2023-01-27'),('10','11','2020-01-27','2023-01-27'),('10','22','2022-01-27','2023-01-27'),('10','31','2022-01-27','2027-01-27'),
('11','2','2020-01-27','2023-01-27'),('11','22','2022-01-27','2023-01-27'),('11','32','2022-01-27','2027-01-27'),
('12','1','2021-12-25','2024-12-25'),('12','12','2021-12-25','2022-12-25'),('12','23','2021-12-25','2022-12-25'),('12','32','2018-12-25','2023-12-25'),('12','61','2021-12-25','2024-12-25'),
('13','2','2021-12-10','2024-12-10'),('13','12','2021-12-10','2022-12-10'),('13','23','2021-12-10','2022-12-10'),('13','32','2018-12-10','2023-12-10'),
('14','2','2022-02-28','2025-02-28'),('14','12','2022-02-28','2023-02-28'),('14','23','2022-02-28','2023-02-28'),('14','32','2022-02-28','2027-02-28'),
('15','2','2022-01-27','2025-01-27'),('15','12','2022-01-27','2023-01-27'),('15','23','2022-01-27','2023-01-27'),('15','32','2022-01-27','2027-01-27'),
('16','2','2021-11-03','2024-11-03'),('16','12','2021-11-03','2022-11-03'),('16','23','2021-11-03','2022-11-03'),('16','32','2021-11-03','2026-11-03'),
('17','2','2021-10-25','2024-10-25'),('17','12','2021-10-25','2022-10-25'),('17','23','2021-10-25','2022-10-25'),('17','32','2021-10-25','2026-10-25'),
('18','2','2022-06-27','2025-06-27'),('18','12','2022-06-27','2023-06-27'),('18','23','2022-06-27','2023-06-27'),('18','32','2022-06-27','2027-06-27'),
('19','2','2021-11-17','2024-11-17'),('19','12','2021-11-17','2022-11-17'),('19','23','2021-11-17','2022-11-17'),('19','32','2021-11-17','2026-11-17'),
('20','2','2022-04-19','2025-04-19'),('20','12','2022-04-19','2023-04-19'),('20','23','2022-04-19','2023-04-19'),('20','32','2022-04-19','2027-04-19'),
('21','2','2022-06-13','2025-06-13'),('21','12','2022-06-13','2022-06-13'),('21','23','2022-06-13','2022-06-13'),('21','32','2022-06-13','2027-06-13'),
('22','2','2022-07-27','2025-07-27'),('22','12','2022-07-27','2023-07-27'),('22','23','2022-07-27','2023-07-27'),('22','32','2022-07-27','2027-07-27'),
('23','2','2022-02-12','2025-02-12'),('23','12','2022-02-12','2023-02-12'),('23','23','2022-02-12','2023-02-12'),('23','32','2022-02-12','2027-02-12'),
('24','2','2022-11-27','2025-11-27'),('24','12','2022-11-27','2023-11-27'),('24','23','2022-11-27','2023-11-27'),('24','32','2022-11-27','2027-11-27'),
('25','3','2022-11-17','2022-11-17'),('25','12','2022-11-17','2022-11-17'),('25','23','2022-11-17','2022-11-17'),
('26','3','2021-11-17','2022-11-17'),('26','12','2021-11-17','2022-11-17'),('26','23','2021-11-17','2022-11-17'),
('27','3','2021-11-12','2022-11-12'),('27','12','2021-11-12','2022-11-12'),('27','23','2021-11-12','2022-11-12'),
('28','3','2021-12-15','2022-12-15'),('28','12','2021-12-15','2022-12-15'),('28','23','2021-12-15','2022-12-15'),
('29','3','2022-01-21','2023-01-21'),('29','12','2022-01-21','2023-01-21'),('29','23','2022-01-21','2023-01-21'),
('30','3','2022-06-24','2023-06-24'),('30','12','2022-06-24','2023-06-24'),('30','23','2022-06-24','2023-06-24'),
('31','4','2022-06-24','2023-06-24'),('31','12','2022-06-24','2023-06-24'),('31','23','2022-06-24','2023-06-24'),('31','51','2022-06-24','2025-06-24'),
('32','4','2022-08-18','2023-08-18'),('32','12','2022-08-18','2023-08-18'),('32','23','2022-08-18','2023-08-18'),('32','51','2022-08-18','2025-08-18'),
('33','4','2022-07-24','2023-07-24'),('33','12','2022-07-24','2023-07-24'),('33','23','2022-07-24','2023-07-24'),('33','51','2022-07-24','2025-07-24'),
('34','4','2022-08-07','2023-08-07'),('34','12','2022-08-07','2023-08-07'),('34','23','2022-08-07','2023-08-07'),('34','51','2022-08-07','2025-08-07'),
('35','4','2022-07-29','2022-07-29'),('35','12','2022-07-29','2022-07-29'),('35','23','2022-07-29','2023-07-29'),('35','51','2022-07-29','2025-07-29'),
('36','4','2022-02-06','2023-02-06'),('36','12','2022-02-06','2023-02-06'),('36','23','2022-02-06','2023-02-06'),('36','51','2022-02-06','2025-02-06'),
('37','5','2022-06-29','2023-06-29'),('37','12','2022-06-29','2023-06-29'),('37','23','2022-06-29','2023-06-29'),('37','51','2022-06-27','2025-06-27'),
('38','5','2022-03-08','2023-03-08'),('38','12','2022-03-08','2023-03-08'),('38','23','2022-03-08','2023-03-08'),('38','51','2022-03-08','2025-03-08'),
('39','5','2022-01-24','2023-01-24'),('39','12','2022-01-24','2023-01-24'),('39','23','2022-01-24','2023-01-24'),('39','51','2022-01-24','2023-01-24'),
('40','5','2022-06-19','2023-06-19'),('40','12','2022-06-19','2023-06-19'),('40','23','2022-06-19','2023-06-19'),('40','51','2022-06-19','2023-06-19'),
('41','6','2022-05-09','2023-05-09'),('41','12','2022-05-09','2023-05-09'),('41','23','2022-05-09','2023-05-09'),
('42','6','2022-04-25','2023-04-25'),('42','12','2022-04-25','2023-04-25'),('42','23','2022-04-25','2023-04-25'),
('43','6','2022-04-22','2023-04-22'),('43','12','2022-04-22','2023-04-22'),('43','23','2022-04-22','2023-04-22'),
('44','6','2022-04-12','2023-04-12'),('44','12','2022-04-12','2023-04-12'),('44','23','2022-04-12','2023-04-12'),
('45','2','2022-05-20','2025-05-20'),('45','12','2022-05-20','2023-05-20'),('45','23','2022-05-20','2023-05-20'),('45','32','2022-05-20','2023-05-20'),
('46','3','2022-03-29','2023-06-15'),('46','12','2022-03-29','2023-06-15'),('46','23','2022-06-15','2023-06-15'),
('47','4','2022-05-10','2025-05-10'),('47','12','2022-05-10','2025-05-10'),('47','23','2022-05-10','2025-05-10'),('47','51','2022-05-04','2025-05-04');


-- таблица с интруктажами по ОТ сотрудников
DROP TABLE IF EXISTS briefing_workers; 
CREATE TABLE briefing_workers (
	id SERIAL PRIMARY KEY,
	to_worker_id BIGINT UNSIGNED NOT NULL, -- кому провели инструктаж
	from_worker_id BIGINT UNSIGNED NOT NULL, -- кто провел инструктаж
	name_breifing ENUM('ПБ','РМ','РМ-П','РМ-В','РМ-Ц'), -- наименование инструктажа Вводный, Повторный, Внеплановый, Целевой (Пожбез, На рабочем месте)
	info_breifing VARCHAR (255) DEFAULT NULL,
	date_brifing DATETIME DEFAULT NOW(), -- дата проведения инструктажа
	end_brifing DATETIME DEFAULT NULL, -- дата окончания срока действия инструктажа
	FOREIGN KEY (to_worker_id) REFERENCES workers(id),
	FOREIGN KEY (from_worker_id) REFERENCES workers(id)
	);

INSERT INTO briefing_workers 
(id, to_worker_id, from_worker_id, name_breifing, date_brifing, end_brifing)
VALUES 
('1','25','13','РМ','2022-11-20','2023-11-20'),('2','25','11','ПБ','2022-11-20','2023-11-20'),
('3','26','14','РМ','2022-11-20','2023-11-20'),('4','26','11','ПБ','2022-11-20','2023-11-20'),
('5','27','15','РМ','2021-11-15','2022-11-15'),('6','27','11','ПБ','2021-11-15','2022-11-15'),
('7','28','16','РМ','2021-12-20','2022-12-20'),('8','28','11','ПБ','2021-12-20','2022-12-20'),
('9','29','17','РМ','2022-01-25','2023-01-25'),('10','29','11','ПБ','2022-01-25','2023-01-25'),
('11','30','18','РМ','2022-06-25','2023-06-25'),('12','30','11','ПБ','2022-06-25','2023-06-25'),
-- водитель-механик
('13','31','13','РМ','2022-06-25','2023-06-25'),('14','31','11','ПБ','2022-06-25','2023-06-25'),
('15','32','14','РМ','2022-08-15','2022-08-15'),('16','32','11','ПБ','2022-08-15','2022-08-15'),
('17','33','15','РМ','2022-07-25','2023-07-25'),('18','33','11','ПБ','2022-07-25','2023-07-25'),
('19','34','16','РМ','2022-08-10','2023-08-10'),('20','34','11','ПБ','2022-08-10','2023-08-10'),
('21','35','17','РМ','2022-08-01','2023-08-01'),('22','35','11','ПБ','2022-08-01','2023-08-01'),
('23','36','18','РМ','2022-02-10','2023-02-10'),('24','36','11','ПБ','2022-02-10','2023-02-10'),
-- водители
('25','37','7','РМ','2022-07-01','2023-07-01'),('26','37','11','ПБ','2022-07-01','2023-07-01'),
('27','38','7','РМ','2022-03-10','2023-03-10'),('28','38','11','ПБ','2022-03-10','2023-03-10'),
('29','39','7','РМ','2022-01-25','2023-01-25'),('30','39','11','ПБ','2022-01-25','2023-01-25'),
('31','40','7','РМ','2022-06-20','2023-06-20'),('32','40','11','ПБ','2022-06-20','2023-06-20'),
-- рабочие
('33','41','21','РМ','2022-05-10','2023-05-10'),('34','41','11','ПБ','2022-05-10','2023-05-10'),
('35','42','22','РМ','2022-04-25','2023-04-25'),('36','42','11','ПБ','2022-04-25','2023-04-25'),
('37','43','23','РМ','2022-04-25','2023-04-25'),('38','43','11','ПБ','2022-04-25','2023-04-25'),
('39','44','24','РМ','2022-04-15','2023-04-15'),('40','44','11','ПБ','2022-04-15','2023-04-15'),
-- Норильск
('41','46','45','РМ','2022-04-01','2023-04-01'),('42','46','11','ПБ','2022-04-01','2023-04-01'),
('43','47','45','РМ','2022-05-10','2023-05-10'),('44','47','11','ПБ','2022-05-10','2023-05-10');


-- таблица с медосмотрами
DROP TABLE IF EXISTS medical_examination; 
CREATE TABLE medical_examination(
	id SERIAL PRIMARY KEY,
	me_worker_id BIGINT UNSIGNED NOT NULL,
	me_st_id BIGINT UNSIGNED NOT NULL,
	num_me ENUM ('п.18.1, п.11.4', 'п.11.4'), -- пункты согласно которым проходят МО
	date_me DATETIME DEFAULT NOW() NOT NULL, -- дата предоставления заключения по МО
	date_me_re DATETIME DEFAULT NOW() NOT NULL, -- дата повторного МО
	FOREIGN KEY (me_worker_id) REFERENCES workers(id),
	FOREIGN KEY (me_st_id) REFERENCES staffing_table(id)
	);

INSERT INTO medical_examination (id, me_worker_id, me_st_id, num_me, date_me, date_me_re)
VALUES 
('1','13','12','п.11.4','2021-11-28','2022-11-28'),
('2','14','12','п.11.4','2022-02-07','2023-02-07'),
('3','15','12','п.11.4','2022-01-16','2023-01-16'),
('4','16','12','п.11.4','2021-10-22','2022-10-22'),
('5','17','12','п.11.4','2021-10-13','2022-10-13'),
('6','18','12','п.11.4','2022-06-14','2023-06-14'),
('7','19','13','п.11.4','2021-11-08','2022-11-08'),
('8','20','13','п.11.4','2022-04-04','2023-04-04'),
('9','21','14','п.11.4','2022-06-01','2023-06-01'),
('10','22','14','п.11.4','2022-07-18','2023-07-18'),
('11','23','14','п.11.4','2022-01-27','2023-01-27'),
('12','24','14','п.11.4','2021-11-17','2022-11-17'),
('13','25','15','п.11.4','2021-10-28','2022-10-28'),
('14','26','15','п.11.4','2021-10-29','2022-10-29'),
('15','27','15','п.11.4','2021-10-29','2022-10-29'),
('16','28','15','п.11.4','2021-12-03','2022-12-03'),
('17','29','15','п.11.4','2022-01-10','2023-01-10'),
('18','30','15','п.11.4','2022-06-14','2023-06-14'),
('19','31','16','п.18.1, п.11.4','2022-06-14','2023-06-14'),
('20','32','16','п.18.1, п.11.4','2022-08-07','2023-08-07'),
('21','33','16','п.18.1, п.11.4','2022-07-13','2023-07-13'),
('22','34','16','п.18.1, п.11.4','2022-07-28','2023-07-28'),
('23','35','16','п.18.1, п.11.4','2022-07-20','2023-07-20'),
('24','36','16','п.18.1, п.11.4','2022-01-27','2023-01-27'),
('25','37','17','п.18.1, п.11.4','2022-06-22','2023-06-22'),
('26','38','17','п.18.1, п.11.4','2022-02-25','2023-02-25'),
('27','39','17','п.18.1, п.11.4','2022-01-14','2023-01-14'),
('28','40','17','п.18.1, п.11.4','2022-06-10','2023-06-10'),
('29','41','18','п.11.4','2022-04-27','2023-04-27'),
('30','42','18','п.11.4','2022-04-15','2023-04-15'),
('31','43','18','п.11.4','2022-04-12','2023-04-12'),
('32','44','18','п.11.4','2022-03-29','2023-03-29'),
('33','45','20','п.11.4','2022-04-29','2023-04-29'),
('34','46','21','п.11.4','2022-06-05','2023-06-05'),
('35','47','22','п.18.1, п.11.4','2022-04-29','2023-04-29'),
('36','7','19','п.18.1, п.11.4','2021-11-17','2022-11-17');


-- (personal protective equipment) таблица с средствами индивидуальной защиты
DROP TABLE IF EXISTS ppe; 
CREATE TABLE ppe (
	id SERIAL PRIMARY KEY,
	name_ppe VARCHAR (255) NOT NULL,-- наименование СИЗ
	period_ppe ENUM('До износа', '24мес', '12мес'),
	season_ppe VARCHAR (255) NOT NULL, -- сизон носки
	certificate_num VARCHAR(100) DEFAULT NULL, -- номер сертификата
	end_certificate DATETIME DEFAULT NULL, -- срок окончания действия сертииката
	price_ppe BIGINT UNSIGNED DEFAULT NULL -- цена за 1 шт
);

INSERT INTO ppe (id, name_ppe, period_ppe, season_ppe, price_ppe)
VALUES
('1','Перчатки ХБ','До износа', 'Лето', '137'),
('2','Перчатки прорезиненные','До износа', 'Лето', '240'),
('3','Перчатки  ХБ','До износа', 'Зима', '200'),
('4','Верхонки','До износа', 'Зима', '320'),
('11','Защитная каска ЖЕЛТАЯ','До износа', '-', '120'),
('12','Защитная каска БЕЛАЯ','До износа', '-', '120'),
('13','Очки защитные открытого типа','До износа', '-', '144'),
('14','Защита органов слуха','До износа', '-', '100'),
('15','Сигнальный жилет','До износа', '-', '83'),
('16','Плащ влагоотталкивающий','До износа', '-', '3460'),
('17','Горн от дикого зверя','До износа', '-', '2800'),
('18','Балаклава утепленная','До износа', 'Зима', '1700'),
('20','Костюм от общих произодственных загрязнений','12мес', 'Лето', '2600'),
('30','Костюм от общих произодственных загрязнений','24мес', 'Зима', '8300'),
('21','Ботинки с высоким берцем с защитным подноском','12мес', 'Лето', '3240'),
('22','Сапоги резиновые с защитным подноском','12мес', 'Лето', '1700'),
('31','Ботинки утепленные прорезиненные с защитным подноском','24мес', 'Зима', '4310');

-- таблица  учета выдачи СИЗ
DROP TABLE IF EXISTS ppe_workers; 
CREATE TABLE ppe_workers (
	ppe_worker_id BIGINT UNSIGNED NOT NULL,
	ppe_id BIGINT UNSIGNED NOT NULL,
	amount_ppe INT DEFAULT '1', -- количество
	date_ppe DATETIME DEFAULT NOW() NOT NULL, -- дата выдачи
	PRIMARY KEY (ppe_worker_id, ppe_id),
	FOREIGN KEY (ppe_worker_id) REFERENCES workers(id),
	FOREIGN KEY (ppe_id) REFERENCES ppe(id)
);	

INSERT INTO ppe_workers (ppe_worker_id, ppe_id, amount_ppe, date_ppe)
VALUES 
('13','1','10','2022-05-01'),
('13','3','10','2021-11-28'),
('13','12','1','2021-11-28'),
('13','15','1','2021-11-28'),
('13','16','1','2021-11-28'),
('13','17','1','2021-11-28'),
('13','30','1','2021-11-28'),
('13','31','1','2021-11-28'),
('13','20','1','2022-05-01'),
('13','21','1','2022-05-01'),
('13','22','1','2022-05-01'),
-- 
('14','1','10','2022-05-01'),
('14','3','10','2022-02-07'),
('14','12','1','2022-02-07'),
('14','15','1','2022-02-07'),
('14','16','1','2022-02-07'),
('14','17','1','2022-02-07'),
('14','30','1','2022-02-07'),
('14','31','1','2022-02-07'),
('14','20','1','2022-05-01'),
('14','21','1','2022-05-01'),
('14','22','1','2022-05-01'),
-- 
('15','1','10','2022-05-01'),
('15','3','10','2022-01-16'),
('15','12','1','2022-01-16'),
('15','15','1','2022-01-16'),
('15','16','1','2022-01-16'),
('15','17','1','2022-01-16'),
('15','30','1','2022-01-16'),
('15','31','1','2022-01-16'),
('15','20','1','2022-05-01'),
('15','21','1','2022-05-01'),
('15','22','1','2022-05-01'),
-- 
('16','1','10','2022-05-01'),
('16','3','10','2021-10-22'),
('16','12','1','2021-10-22'),
('16','15','1','2021-10-22'),
('16','16','1','2021-10-22'),
('16','17','1','2021-10-22'),
('16','30','1','2021-10-22'),
('16','31','1','2021-10-22'),
('16','20','1','2022-05-01'),
('16','21','1','2022-05-01'),
('16','22','1','2022-05-01'),
-- 
('17','1','10','2022-05-01'),
('17','3','10','2021-10-13'),
('17','12','1','2021-10-13'),
('17','15','1','2021-10-13'),
('17','16','1','2021-10-13'),
('17','17','1','2021-10-13'),
('17','30','1','2021-10-13'),
('17','31','1','2021-10-13'),
('17','20','1','2022-05-01'),
('17','21','1','2022-05-01'),
('17','22','1','2022-05-01'),
-- 
('18','1','10','2022-06-14'),
('18','12','1','2022-06-14'),
('18','15','1','2022-06-14'),
('18','16','1','2022-06-14'),
('18','17','1','2022-06-14'),
('18','20','1','2022-06-14'),
('18','21','1','2022-06-14'),
('18','22','1','2022-06-14'),
-- 
('19','1','10','2022-05-01'),
('19','3','10','2021-11-08'),
('19','12','1','2021-11-08'),
('19','15','1','2021-11-08'),
('19','16','1','2021-11-08'),
('19','17','1','2021-11-08'),
('19','30','1','2021-11-08'),
('19','31','1','2021-11-08'),
('19','20','1','2022-05-01'),
('19','21','1','2022-05-01'),
('19','22','1','2022-05-01'),
-- 
('20','1','10','2022-05-01'),
('20','3','10','2022-04-04'),
('20','12','1','2022-04-04'),
('20','15','1','2022-04-04'),
('20','16','1','2022-04-04'),
('20','17','1','2022-04-04'),
('20','30','1','2022-04-04'),
('20','31','1','2022-04-04'),
('20','20','1','2022-05-01'),
('20','21','1','2022-05-01'),
('20','22','1','2022-05-01'),
-- 
('21','1','10','2022-06-01'),
('21','12','1','2022-06-01'),
('21','15','1','2022-06-01'),
('21','16','1','2022-06-01'),
('21','17','1','2022-06-01'),
('21','20','1','2022-06-01'),
('21','21','1','2022-06-01'),
('21','22','1','2022-06-01'),
-- 
('22','1','10','2022-07-18'),
('22','12','1','2022-07-18'),
('22','15','1','2022-07-18'),
('22','16','1','2022-07-18'),
('22','17','1','2022-07-18'),
('22','20','1','2022-07-18'),
('22','21','1','2022-07-18'),
('22','22','1','2022-07-18'),
-- 
('23','1','10','2022-05-01'),
('23','3','10','2022-01-27'),
('23','12','1','2022-01-27'),
('23','15','1','2022-01-27'),
('23','16','1','2022-01-27'),
('23','17','1','2022-01-27'),
('23','30','1','2022-01-27'),
('23','31','1','2022-01-27'),
('23','20','1','2022-05-01'),
('23','21','1','2022-05-01'),
('23','22','1','2022-05-01'),
-- 
('24','1','10','2022-05-01'),
('24','3','10','2021-11-17'),
('24','12','1','2021-11-17'),
('24','15','1','2021-11-17'),
('24','16','1','2021-11-17'),
('24','17','1','2021-11-17'),
('24','30','1','2021-11-17'),
('24','31','1','2021-11-17'),
('24','20','1','2022-05-01'),
('24','21','1','2022-05-01'),
('24','22','1','2022-05-01'),
-- 
('25','1','20','2022-05-01'),
('25','2','10','2022-05-01'),
('25','3','20','2021-10-28'),
('25','4','10','2021-10-28'),
('25','11','1','2021-10-28'),
('25','13','1','2021-10-28'),
('25','14','1','2021-10-28'),
('25','15','1','2021-10-28'),
('25','16','1','2021-10-28'),
('25','30','1','2021-10-28'),
('25','31','1','2021-10-28'),
('25','20','1','2022-05-01'),
('25','21','1','2022-05-01'),
('25','22','1','2022-05-01'),
-- 
('26','1','30','2022-05-01'),
('26','2','10','2022-05-01'),
('26','3','20','2021-10-29'),
('26','4','10','2021-10-29'),
('26','11','1','2021-10-29'),
('26','13','1','2021-10-29'),
('26','14','1','2021-10-29'),
('26','15','1','2021-10-29'),
('26','16','1','2021-10-29'),
('26','30','1','2021-10-29'),
('26','31','1','2021-10-29'),
('26','20','1','2022-05-01'),
('26','21','1','2022-05-01'),
('26','22','1','2022-05-01'),
-- 
('27','1','20','2022-05-01'),
('27','2','10','2022-05-01'),
('27','3','20','2021-10-29'),
('27','4','10','2021-10-29'),
('27','11','1','2021-10-29'),
('27','13','1','2021-10-29'),
('27','14','1','2021-10-29'),
('27','15','1','2021-10-29'),
('27','16','1','2021-10-29'),
('27','30','1','2021-10-29'),
('27','31','1','2021-10-29'),
('27','20','1','2022-05-01'),
('27','21','1','2022-05-01'),
('27','22','1','2022-05-01'),
-- 
('28','1','20','2022-05-01'),
('28','2','10','2022-05-01'),
('28','3','20','2021-12-03'),
('28','4','10','2021-12-03'),
('28','11','1','2021-12-03'),
('28','13','1','2021-12-03'),
('28','14','1','2021-12-03'),
('28','15','1','2021-12-03'),
('28','16','1','2021-12-03'),
('28','30','1','2021-12-03'),
('28','31','1','2021-12-03'),
('28','20','1','2022-05-01'),
('28','21','1','2022-05-01'),
('28','22','1','2022-05-01'),
-- 
('29','1','20','2022-05-01'),
('29','2','10','2022-05-01'),
('29','3','20','2022-01-10'),
('29','4','10','2022-01-10'),
('29','11','1','2022-01-10'),
('29','13','1','2022-01-10'),
('29','14','1','2022-01-10'),
('29','15','1','2022-01-10'),
('29','16','1','2022-01-10'),
('29','30','1','2022-01-10'),
('29','31','1','2022-01-10'),
('29','20','1','2022-05-01'),
('29','21','1','2022-05-01'),
('29','22','1','2022-05-01'),
-- 
('30','1','20','2022-06-14'),
('30','2','10','2022-06-14'),
('30','11','1','2022-06-14'),
('30','13','1','2022-06-14'),
('30','14','1','2022-06-14'),
('30','15','1','2022-06-14'),
('30','16','1','2022-06-14'),
('30','20','1','2022-06-14'),
('30','21','1','2022-06-14'),
('30','22','1','2022-06-14'),
-- 
('31','1','20','2022-06-14'),
('31','2','10','2022-06-14'),
('31','11','1','2022-06-14'),
('31','13','1','2022-06-14'),
('31','14','1','2022-06-14'),
('31','15','1','2022-06-14'),
('31','16','1','2022-06-14'),
('31','20','1','2022-06-14'),
('31','21','1','2022-06-14'),
('31','22','1','2022-06-14'),
-- 
('32','1','20','2022-08-07'),
('32','2','10','2022-08-07'),
('32','11','1','2022-08-07'),
('32','13','1','2022-08-07'),
('32','14','1','2022-08-07'),
('32','15','1','2022-08-07'),
('32','16','1','2022-08-07'),
('32','20','1','2022-08-07'),
('32','21','1','2022-08-07'),
('32','22','1','2022-08-07'),
-- 
('33','1','20','2022-07-13'),
('33','2','10','2022-07-13'),
('33','11','1','2022-07-13'),
('33','13','1','2022-07-13'),
('33','14','1','2022-07-13'),
('33','15','1','2022-07-13'),
('33','16','1','2022-07-13'),
('33','20','1','2022-07-13'),
('33','21','1','2022-07-13'),
('33','22','1','2022-07-13'),
-- 
('34','1','20','2022-07-28'),
('34','2','10','2022-07-28'),
('34','11','1','2022-07-28'),
('34','13','1','2022-07-28'),
('34','14','1','2022-07-28'),
('34','15','1','2022-07-28'),
('34','16','1','2022-07-28'),
('34','20','1','2022-07-28'),
('34','21','1','2022-07-28'),
('34','22','1','2022-07-28'),
-- 
('35','1','30','2022-07-20'),
('35','2','15','2022-07-20'),
('35','11','1','2022-07-20'),
('35','13','1','2022-07-20'),
('35','14','1','2022-07-20'),
('35','15','1','2022-07-20'),
('35','16','1','2022-07-20'),
('35','20','1','2022-07-20'),
('35','21','1','2022-07-20'),
('35','22','1','2022-07-20'),
-- 
('36','1','30','2022-05-01'),
('36','2','15','2022-05-01'),
('36','3','30','2022-01-27'),
('36','4','15','2022-01-27'),
('36','11','1','2022-01-27'),
('36','13','1','2022-01-27'),
('36','14','1','2022-01-27'),
('36','15','1','2022-01-27'),
('36','16','1','2022-01-27'),
('36','30','1','2022-01-27'),
('36','31','1','2022-01-27'),
('36','20','1','2022-05-01'),
('36','21','1','2022-05-01'),
('36','22','1','2022-05-01'),
-- 
('37','1','5','2022-06-22'),
('37','11','1','2022-06-22'),
('37','13','1','2022-06-22'),
('37','15','1','2022-06-22'),
('37','20','1','2022-06-22'),
('37','21','1','2022-06-22'),
-- 
('38','1','5','2022-05-01'),
('38','3','5','2022-02-25'),
('38','11','1','2022-02-25'),
('38','13','1','2022-02-25'),
('38','15','1','2022-02-25'),
('38','30','1','2022-02-25'),
('38','31','1','2022-02-25'),
('38','20','1','2022-05-01'),
('38','21','1','2022-05-01'),
-- 
('39','1','5','2022-05-01'),
('39','3','5','2022-01-14'),
('39','11','1','2022-01-14'),
('39','13','1','2022-01-14'),
('39','15','1','2022-01-14'),
('39','30','1','2022-01-14'),
('39','31','1','2022-01-14'),
('39','20','1','2022-05-01'),
('39','21','1','2022-05-01'),
-- 
('40','1','5','2022-06-10'),
('40','11','1','2022-06-10'),
('40','13','1','2022-06-10'),
('40','15','1','2022-06-10'),
('40','20','1','2022-06-10'),
('40','21','1','2022-06-10'),
-- 
('41','1','20','2022-05-01'),
('41','3','20','2022-04-27'),
('41','11','1','2022-04-27'),
('41','13','1','2022-04-27'),
('41','15','1','2022-04-27'),
('41','16','1','2022-04-27'),
('41','30','1','2022-04-27'),
('41','31','1','2022-04-27'),
('41','20','1','2022-05-01'),
('41','21','1','2022-05-01'),
('41','22','1','2022-05-01'),
-- 
('42','1','20','2022-05-01'),
('42','3','20','2022-04-15'),
('42','11','1','2022-04-15'),
('42','13','1','2022-04-15'),
('42','15','1','2022-04-15'),
('42','16','1','2022-04-15'),
('42','30','1','2022-04-15'),
('42','31','1','2022-04-15'),
('42','20','1','2022-05-01'),
('42','21','1','2022-05-01'),
('42','22','1','2022-05-01'),
-- 
('43','1','20','2022-05-01'),
('43','3','20','2022-04-12'),
('43','11','1','2022-04-12'),
('43','13','1','2022-04-12'),
('43','15','1','2022-04-12'),
('43','16','1','2022-04-12'),
('43','30','1','2022-04-12'),
('43','31','1','2022-04-12'),
('43','20','1','2022-05-01'),
('43','21','1','2022-05-01'),
('43','22','1','2022-05-01'),
-- 
('44','1','20','2022-05-01'),
('44','3','20','2022-03-29'),
('44','11','1','2022-03-29'),
('44','13','1','2022-03-29'),
('44','15','1','2022-03-29'),
('44','16','1','2022-03-29'),
('44','30','1','2022-03-29'),
('44','31','1','2022-03-29'),
('44','20','1','2022-05-01'),
('44','21','1','2022-05-01'),
('44','22','1','2022-05-01'),
-- 
('45','1','10','2022-05-01'),
('45','3','10','2022-04-29'),
('45','12','1','2022-04-29'),
('45','15','1','2022-04-29'),
('45','16','1','2022-04-29'),
('45','17','1','2022-04-29'),
('45','30','1','2022-04-29'),
('45','31','1','2022-04-29'),
('45','20','1','2022-05-01'),
('45','21','1','2022-05-01'),
('45','22','1','2022-05-01'),
-- 
('46','1','20','2022-06-05'),
('46','2','10','2022-06-05'),
('46','11','1','2022-06-05'),
('46','13','1','2022-06-05'),
('46','14','1','2022-06-05'),
('46','15','1','2022-06-05'),
('46','16','1','2022-06-05'),
('46','18','1','2022-06-05'),
('46','20','1','2022-06-05'),
('46','21','1','2022-06-05'),
('46','22','1','2022-06-05'),
-- 
('47','1','30','2022-05-01'),
('47','2','15','2022-05-01'),
('47','3','30','2022-04-29'),
('47','4','15','2022-04-29'),
('47','11','1','2022-04-29'),
('47','13','1','2022-04-29'),
('47','14','1','2022-04-29'),
('47','15','1','2022-04-29'),
('47','16','1','2022-04-29'),
('47','18','1','2022-04-29'),
('47','30','1','2022-04-29'),
('47','31','1','2022-04-29'),
('47','20','1','2022-05-01'),
('47','21','1','2022-05-01'),
('47','22','1','2022-05-01'),
-- 
('7','1','10','2022-05-01'),
('7','3','10','2021-11-17'),
('7','12','1','2021-11-17'),
('7','13','1','2021-11-17'),
('7','15','1','2021-11-17'),
('7','16','1','2021-11-17'),
('7','30','1','2021-11-17'),
('7','31','1','2021-11-17'),
('7','20','1','2022-05-01'),
('7','21','1','2022-05-01'),
('7','22','1','2022-05-01');
