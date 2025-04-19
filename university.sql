-- Создание базы данных
CREATE DATABASE university;

-- Таблица факультетов
CREATE TABLE faculties (
    faculty_id SERIAL PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL,
    dean VARCHAR(100),
    office_location VARCHAR(50)
);

-- Таблица кафедр
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    faculty_id INTEGER NOT NULL,
    head_of_department VARCHAR(100),
    FOREIGN KEY (faculty_id) REFERENCES faculties(faculty_id)
);

-- Таблица преподавателей
CREATE TABLE teachers (
    teacher_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    birth_date DATE,
    department_id INTEGER NOT NULL,
    academic_degree VARCHAR(50),
    academic_title VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Таблица направлений подготовки
CREATE TABLE study_programs (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL,
    department_id INTEGER NOT NULL,
    duration_years INTEGER,
    degree_level VARCHAR(50),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Таблица студентов
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    birth_date DATE,
    program_id INTEGER NOT NULL,
    admission_year INTEGER,
    student_group VARCHAR(20),
    scholarship DECIMAL(10,2),
    FOREIGN KEY (program_id) REFERENCES study_programs(program_id)
);

-- Таблица курсов
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INTEGER NOT NULL,
    credits INTEGER,
    hours_total INTEGER,
    description VARCHAR(500),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Таблица учебного плана
CREATE TABLE curriculum (
    curriculum_id SERIAL PRIMARY KEY,
    program_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    semester INTEGER NOT NULL,
    hours_lecture INTEGER,
    hours_practice INTEGER,
    hours_lab INTEGER,
    exam_type VARCHAR(20), 
    FOREIGN KEY (program_id) REFERENCES study_programs(program_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Таблица назначения преподавателей на курсы
CREATE TABLE teaching_assignments (
    assignment_id SERIAL PRIMARY KEY,
    teacher_id INTEGER NOT NULL,
    curriculum_id INTEGER NOT NULL,
    academic_year INTEGER NOT NULL,
    semester INTEGER NOT NULL,
    group_name VARCHAR(20) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (curriculum_id) REFERENCES curriculum(curriculum_id)
);

-- Таблица посещаемости
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    assignment_id INTEGER NOT NULL,
    date DATE NOT NULL,
    status VARCHAR(20) NOT NULL, -- присутствовал/отсутствовал
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (assignment_id) REFERENCES teaching_assignments(assignment_id)
);

-- Таблица успеваемости
CREATE TABLE grades (
    grade_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    assignment_id INTEGER NOT NULL,
    grade INTEGER, -- оценка от 2 до 5
    grade_date DATE,
    grade_type VARCHAR(20), -- текущая/промежуточная/итоговая
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (assignment_id) REFERENCES teaching_assignments(assignment_id)
);

-- Заполнение таблицы факультетов
INSERT INTO faculties (faculty_name, dean, office_location) VALUES
('Факультет информационных технологий', 'Иванов Иван Иванович', 'Главный корпус, к. 301'),
('Факультет экономики', 'Петрова Мария Сергеевна', 'Главный корпус, к. 205'),
('Факультет гуманитарных наук', 'Сидоров Алексей Владимирович', 'Корпус Б, к. 101'),
('Факультет естественных наук', 'Кузнецова Елена Дмитриевна', 'Корпус В, к. 45'),
('Факультет инженерных наук', 'Смирнов Дмитрий Олегович', 'Корпус Г, к. 12');

-- Заполнение таблицы кафедр
INSERT INTO departments (department_name, faculty_id, head_of_department) VALUES
('Кафедра программирования', 1, 'Алексеев Михаил Петрович'),
('Кафедра информационной безопасности', 1, 'Николаева Ольга Игоревна'),
('Кафедра экономической теории', 2, 'Федоров Сергей Александрович'),
('Кафедра банковского дела', 2, 'Волкова Анна Викторовна'),
('Кафедра иностранных языков', 3, 'Ковалева Ирина Сергеевна'),
('Кафедра истории', 3, 'Тимофеев Андрей Николаевич'),
('Кафедра математики', 4, 'Белов Павел Дмитриевич'),
('Кафедра физики', 4, 'Григорьева Татьяна Михайловна'),
('Кафедра машиностроения', 5, 'Орлов Виктор Иванович'),
('Кафедра электротехники', 5, 'Жуков Артем Сергеевич');

-- Заполнение таблицы преподавателей
INSERT INTO teachers (last_name, first_name, middle_name, birth_date, department_id, academic_degree, academic_title, hire_date, salary) VALUES
('Соколов', 'Андрей', 'Михайлович', '1975-03-15', 1, 'Доктор наук', 'Профессор', '2005-09-01', 120000),
('Морозова', 'Елена', 'Викторовна', '1980-07-22', 1, 'Кандидат наук', 'Доцент', '2010-02-15', 95000),
('Козлов', 'Дмитрий', 'Сергеевич', '1985-11-30', 2, 'Кандидат наук', 'Доцент', '2012-08-20', 90000),
('Павлова', 'Ольга', 'Игоревна', '1978-05-10', 2, 'Доктор наук', 'Профессор', '2008-03-01', 115000),
('Лебедев', 'Иван', 'Александрович', '1982-09-18', 3, 'Кандидат наук', 'Доцент', '2015-01-10', 85000),
('Громова', 'Наталья', 'Дмитриевна', '1970-12-05', 3, 'Доктор наук', 'Профессор', '2000-09-01', 125000),
('Кудрявцев', 'Сергей', 'Васильевич', '1988-04-25', 4, 'Кандидат наук', 'Доцент', '2016-02-20', 88000),
('Беляева', 'Марина', 'Анатольевна', '1973-08-12', 4, 'Доктор наук', 'Профессор', '2003-09-01', 118000),
('Тихонов', 'Алексей', 'Павлович', '1987-06-30', 5, 'Кандидат наук', 'Доцент', '2014-09-01', 87000),
('Данилова', 'Екатерина', 'Валерьевна', '1976-02-14', 5, 'Доктор наук', 'Профессор', '2007-09-01', 110000),
('Фролов', 'Максим', 'Олегович', '1983-10-20', 6, 'Кандидат наук', 'Доцент', '2013-09-01', 86000),
('Семенова', 'Анна', 'Сергеевна', '1979-07-08', 6, 'Доктор наук', 'Профессор', '2009-09-01', 112000),
('Гусев', 'Артем', 'Игоревич', '1984-03-25', 7, 'Кандидат наук', 'Доцент', '2015-09-01', 89000),
('Медведева', 'Татьяна', 'Викторовна', '1972-11-12', 7, 'Доктор наук', 'Профессор', '2002-09-01', 122000),
('Егоров', 'Павел', 'Дмитриевич', '1986-05-15', 8, 'Кандидат наук', 'Доцент', '2017-09-01', 91000),
('Крылова', 'Ирина', 'Алексеевна', '1974-09-28', 8, 'Доктор наук', 'Профессор', '2004-09-01', 119000),
('Сорокин', 'Виктор', 'Николаевич', '1981-12-10', 9, 'Кандидат наук', 'Доцент', '2011-09-01', 93000),
('Зайцева', 'Людмила', 'Петровна', '1977-04-05', 9, 'Доктор наук', 'Профессор', '2006-09-01', 116000),
('Макаров', 'Александр', 'Владимирович', '1989-01-20', 10, 'Кандидат наук', 'Доцент', '2018-09-01', 92000),
('Антонова', 'Светлана', 'Борисовна', '1971-08-15', 10, 'Доктор наук', 'Профессор', '2001-09-01', 121000);

-- Заполнение таблицы направлений подготовки
INSERT INTO study_programs (program_name, department_id, duration_years, degree_level) VALUES
('Программная инженерия', 1, 4, 'Бакалавриат'),
('Информационная безопасность', 2, 4, 'Бакалавриат'),
('Экономика', 3, 4, 'Бакалавриат'),
('Банковское дело', 4, 4, 'Бакалавриат'),
('Лингвистика', 5, 4, 'Бакалавриат'),
('История', 6, 4, 'Бакалавриат'),
('Прикладная математика', 7, 4, 'Бакалавриат'),
('Физика', 8, 4, 'Бакалавриат'),
('Машиностроение', 9, 4, 'Бакалавриат'),
('Электроэнергетика', 10, 4, 'Бакалавриат'),
('Искусственный интеллект', 1, 2, 'Магистратура'),
('Кибербезопасность', 2, 2, 'Магистратура'),
('Финансы и кредит', 3, 2, 'Магистратура'),
('Международная экономика', 4, 2, 'Магистратура'),
('Перевод и переводоведение', 5, 2, 'Магистратура'),
('Археология', 6, 2, 'Магистратура'),
('Математическое моделирование', 7, 2, 'Магистратура'),
('Ядерная физика', 8, 2, 'Магистратура'),
('Робототехника', 9, 2, 'Магистратура'),
('Электронные системы', 10, 2, 'Магистратура');

-- Заполнение таблицы студентов
INSERT INTO students (last_name, first_name, middle_name, birth_date, program_id, admission_year, student_group, scholarship) VALUES
('Иванов', 'Алексей', 'Сергеевич', '2000-05-12', 1, 2020, 'ПИ-201', 2000),
('Петрова', 'Мария', 'Андреевна', '2001-07-23', 1, 2020, 'ПИ-201', 2500),
('Сидоров', 'Дмитрий', 'Игоревич', '2000-11-15', 1, 2020, 'ПИ-201', 0),
('Кузнецова', 'Елена', 'Дмитриевна', '2001-03-28', 1, 2020, 'ПИ-201', 2000),
('Смирнов', 'Артем', 'Олегович', '2000-09-10', 1, 2020, 'ПИ-201', 0),
('Федорова', 'Анна', 'Викторовна', '2001-01-20', 2, 2020, 'ИБ-201', 3000),
('Николаев', 'Сергей', 'Павлович', '2000-08-05', 2, 2020, 'ИБ-201', 2500),
('Васильева', 'Ольга', 'Сергеевна', '2001-04-17', 2, 2020, 'ИБ-201', 0),
('Павлов', 'Иван', 'Александрович', '2000-12-30', 2, 2020, 'ИБ-201', 2000),
('Громова', 'Татьяна', 'Дмитриевна', '2001-02-14', 2, 2020, 'ИБ-201', 0),
('Белов', 'Павел', 'Дмитриевич', '2000-06-25', 3, 2020, 'ЭК-201', 2000),
('Ковалева', 'Ирина', 'Сергеевна', '2001-10-08', 3, 2020, 'ЭК-201', 0),
('Орлов', 'Виктор', 'Иванович', '2000-07-19', 3, 2020, 'ЭК-201', 2500),
('Жукова', 'Анастасия', 'Артемовна', '2001-05-03', 3, 2020, 'ЭК-201', 3000),
('Тихонов', 'Алексей', 'Павлович', '2000-04-11', 3, 2020, 'ЭК-201', 0),
('Данилов', 'Егор', 'Валерьевич', '2001-09-22', 4, 2020, 'БД-201', 2000),
('Фролова', 'Марина', 'Олеговна', '2000-03-07', 4, 2020, 'БД-201', 0),
('Семенов', 'Сергей', 'Сергеевич', '2001-11-18', 4, 2020, 'БД-201', 2500),
('Гусева', 'Екатерина', 'Игоревна', '2000-08-29', 4, 2020, 'БД-201', 0),
('Медведев', 'Дмитрий', 'Викторович', '2001-01-05', 4, 2020, 'БД-201', 3000),
('Егорова', 'Наталья', 'Дмитриевна', '2000-10-15', 5, 2020, 'ЛГ-201', 2000),
('Крылов', 'Артем', 'Алексеевич', '2001-04-27', 5, 2020, 'ЛГ-201', 0),
('Сорокина', 'Виктория', 'Николаевна', '2000-12-08', 5, 2020, 'ЛГ-201', 2500),
('Зайцев', 'Петр', 'Петрович', '2001-07-01', 5, 2020, 'ЛГ-201', 0),
('Макарова', 'Александра', 'Владимировна', '2000-02-14', 5, 2020, 'ЛГ-201', 3000),
('Антонов', 'Борис', 'Борисович', '2001-06-23', 6, 2020, 'ИС-201', 2000),
('Беляева', 'Людмила', 'Анатольевна', '2000-09-16', 6, 2020, 'ИС-201', 0),
('Тимофеев', 'Андрей', 'Николаевич', '2001-03-05', 6, 2020, 'ИС-201', 2500),
('Ковалев', 'Игорь', 'Сергеевич', '2000-11-28', 6, 2020, 'ИС-201', 0),
('Орлова', 'Виктория', 'Ивановна', '2001-05-10', 6, 2020, 'ИС-201', 3000),
('Жуков', 'Артем', 'Сергеевич', '2000-04-19', 7, 2020, 'ПМ-201', 2000),
('Тихонова', 'Александра', 'Павловна', '2001-08-22', 7, 2020, 'ПМ-201', 0),
('Данилова', 'Елизавета', 'Валерьевна', '2000-01-07', 7, 2020, 'ПМ-201', 2500),
('Фролов', 'Максим', 'Олегович', '2001-10-30', 7, 2020, 'ПМ-201', 0),
('Семенова', 'Алина', 'Сергеевна', '2000-07-12', 7, 2020, 'ПМ-201', 3000),
('Гусев', 'Илья', 'Игоревич', '2001-02-25', 8, 2020, 'ФЗ-201', 2000),
('Медведева', 'Дарья', 'Викторовна', '2000-06-18', 8, 2020, 'ФЗ-201', 0),
('Егоров', 'Никита', 'Дмитриевич', '2001-12-01', 8, 2020, 'ФЗ-201', 2500),
('Крылова', 'Анна', 'Алексеевна', '2000-09-24', 8, 2020, 'ФЗ-201', 0),
('Сорокин', 'Владимир', 'Николаевич', '2001-05-07', 8, 2020, 'ФЗ-201', 3000),
('Зайцева', 'Ольга', 'Петровна', '2000-03-16', 9, 2020, 'МШ-201', 2000),
('Макаров', 'Алексей', 'Владимирович', '2001-11-29', 9, 2020, 'МШ-201', 0),
('Антонова', 'Светлана', 'Борисовна', '2000-08-12', 9, 2020, 'МШ-201', 2500),
('Белов', 'Михаил', 'Дмитриевич', '2001-04-05', 9, 2020, 'МШ-201', 0),
('Ковалева', 'Елена', 'Сергеевна', '2000-10-28', 9, 2020, 'МШ-201', 3000),
('Орлов', 'Григорий', 'Иванович', '2001-01-19', 10, 2020, 'ЭЛ-201', 2000),
('Жукова', 'Мария', 'Артемовна', '2000-07-02', 10, 2020, 'ЭЛ-201', 0),
('Тихонов', 'Степан', 'Павлович', '2001-03-15', 10, 2020, 'ЭЛ-201', 2500),
('Данилов', 'Валерий', 'Валерьевич', '2000-12-28', 10, 2020, 'ЭЛ-201', 0),
('Фролова', 'Ксения', 'Олеговна', '2001-09-11', 10, 2020, 'ЭЛ-201', 3000),
('Семенов', 'Артем', 'Сергеевич', '1998-05-24', 11, 2019, 'ИИ-191', 3500),
('Гусева', 'Виктория', 'Игоревна', '1999-02-17', 11, 2019, 'ИИ-191', 0),
('Медведев', 'Александр', 'Викторович', '1998-10-30', 11, 2019, 'ИИ-191', 4000),
('Егорова', 'Татьяна', 'Дмитриевна', '1999-07-13', 11, 2019, 'ИИ-191', 0),
('Крылов', 'Денис', 'Алексеевич', '1998-04-26', 11, 2019, 'ИИ-191', 3500),
('Сорокина', 'Юлия', 'Николаевна', '1999-01-09', 12, 2019, 'КБ-191', 0),
('Зайцев', 'Роман', 'Петрович', '1998-08-22', 12, 2019, 'КБ-191', 4000),
('Макарова', 'Евгения', 'Владимировна', '1999-05-05', 12, 2019, 'КБ-191', 3500),
('Антонов', 'Владислав', 'Борисович', '1998-12-18', 12, 2019, 'КБ-191', 0),
('Беляева', 'Анастасия', 'Анатольевна', '1999-09-01', 12, 2019, 'КБ-191', 4000),
('Тимофеев', 'Кирилл', 'Николаевич', '1998-06-14', 13, 2019, 'ФК-191', 3500),
('Ковалев', 'Станислав', 'Сергеевич', '1999-03-27', 13, 2019, 'ФК-191', 0),
('Орлова', 'Арина', 'Ивановна', '1998-11-10', 13, 2019, 'ФК-191', 4000),
('Жуков', 'Георгий', 'Сергеевич', '1999-08-23', 13, 2019, 'ФК-191', 0),
('Тихонова', 'Валерия', 'Павловна', '1998-05-06', 13, 2019, 'ФК-191', 3500),
('Данилова', 'Ангелина', 'Валерьевна', '1999-02-19', 14, 2019, 'МЭ-191', 0),
('Фролов', 'Артур', 'Олегович', '1998-10-02', 14, 2019, 'МЭ-191', 4000),
('Семенова', 'Диана', 'Сергеевна', '1999-07-15', 14, 2019, 'МЭ-191', 3500),
('Гусев', 'Ярослав', 'Игоревич', '1998-04-28', 14, 2019, 'МЭ-191', 0),
('Медведева', 'Элина', 'Викторовна', '1999-01-11', 14, 2019, 'МЭ-191', 4000),
('Егоров', 'Руслан', 'Дмитриевич', '1998-08-24', 15, 2019, 'ПП-191', 3500),
('Крылова', 'Алиса', 'Алексеевна', '1999-05-07', 15, 2019, 'ПП-191', 0),
('Сорокин', 'Тимур', 'Николаевич', '1998-12-20', 15, 2019, 'ПП-191', 4000),
('Зайцева', 'Полина', 'Петровна', '1999-09-03', 15, 2019, 'ПП-191', 0),
('Макаров', 'Даниил', 'Владимирович', '1998-06-16', 15, 2019, 'ПП-191', 3500),
('Антонова', 'Кристина', 'Борисовна', '1999-03-29', 16, 2019, 'АР-191', 0),
('Белов', 'Глеб', 'Дмитриевич', '1998-11-12', 16, 2019, 'АР-191', 4000),
('Ковалева', 'Вероника', 'Сергеевна', '1999-08-25', 16, 2019, 'АР-191', 3500),
('Орлов', 'Илья', 'Иванович', '1998-05-08', 16, 2019, 'АР-191', 0),
('Жукова', 'София', 'Артемовна', '1999-02-21', 16, 2019, 'АР-191', 4000),
('Тихонов', 'Арсений', 'Павлович', '1998-10-04', 17, 2019, 'ММ-191', 3500),
('Данилов', 'Матвей', 'Валерьевич', '1999-07-17', 17, 2019, 'ММ-191', 0),
('Фролова', 'Александра', 'Олеговна', '1998-04-30', 17, 2019, 'ММ-191', 4000),
('Семенов', 'Мирон', 'Сергеевич', '1999-01-13', 17, 2019, 'ММ-191', 0),
('Гусева', 'Милана', 'Игоревна', '1998-08-26', 17, 2019, 'ММ-191', 3500),
('Медведев', 'Платон', 'Викторович', '1999-05-09', 18, 2019, 'ЯФ-191', 0),
('Егорова', 'Амелия', 'Дмитриевна', '1998-12-22', 18, 2019, 'ЯФ-191', 4000),
('Крылов', 'Марк', 'Алексеевич', '1999-09-05', 18, 2019, 'ЯФ-191', 3500),
('Сорокина', 'Ева', 'Николаевна', '1998-06-18', 18, 2019, 'ЯФ-191', 0),
('Зайцев', 'Лев', 'Петрович', '1999-03-01', 18, 2019, 'ЯФ-191', 4000),
('Макарова', 'Арина', 'Владимировна', '1998-10-14', 19, 2019, 'РТ-191', 3500),
('Антонов', 'Давид', 'Борисович', '1999-07-27', 19, 2019, 'РТ-191', 0),
('Беляева', 'Виолетта', 'Анатольевна', '1998-05-10', 19, 2019, 'РТ-191', 4000),
('Ковалев', 'Григорий', 'Сергеевич', '1999-02-23', 19, 2019, 'РТ-191', 0),
('Орлова', 'Алисия', 'Ивановна', '1998-11-06', 19, 2019, 'РТ-191', 3500),
('Жуков', 'Арсений', 'Сергеевич', '1999-08-19', 20, 2019, 'ЭС-191', 0),
('Тихонова', 'Марьяна', 'Павловна', '1998-05-02', 20, 2019, 'ЭС-191', 4000),
('Данилова', 'Каролина', 'Валерьевна', '1999-02-15', 20, 2019, 'ЭС-191', 3500),
('Фролов', 'Всеволод', 'Олегович', '1998-09-28', 20, 2019, 'ЭС-191', 0),
('Семенова', 'Эмилия', 'Сергеевна', '1999-06-11', 20, 2019, 'ЭС-191', 4000);

-- Заполнение таблицы курсов
INSERT INTO courses (course_name, department_id, credits, hours_total, description)
VALUES
('Программирование на Python', 1, 4, 144, 'Основы программирования на языке Python'),
('Базы данных', 1, 3, 108, 'Проектирование и работа с реляционными базами данных'),
('Алгоритмы и структуры данных', 1, 4, 144, 'Изучение основных алгоритмов и структур данных'),
('Введение в информационную безопасность', 2, 3, 108, 'Основные концепции информационной безопасности'),
('Криптография', 2, 4, 144, 'Методы шифрования и защиты информации'),
('Сетевые технологии', 2, 3, 108, 'Основы компьютерных сетей и сетевых технологий'),
('Микроэкономика', 3, 3, 108, 'Основы микроэкономической теории'),
('Макроэкономика', 3, 3, 108, 'Основы макроэкономической теории'),
('Эконометрика', 3, 4, 144, 'Применение статистических методов в экономике'),
('Банковское дело', 4, 3, 108, 'Основы банковской деятельности'),
('Финансовый менеджмент', 4, 4, 144, 'Управление финансами организации'),
('Инвестиционный анализ', 4, 3, 108, 'Методы анализа инвестиционных проектов'),
('Английский язык', 5, 2, 72, 'Общий курс английского языка'),
('Немецкий язык', 5, 2, 72, 'Общий курс немецкого языка'),
('Теория перевода', 5, 3, 108, 'Основы теории и практики перевода'),
('История России', 6, 3, 108, 'История России с древнейших времен до наших дней'),
('История древнего мира', 6, 3, 108, 'История древних цивилизаций'),
('Археология', 6, 4, 144, 'Основы археологии и методы археологических исследований'),
('Линейная алгебра', 7, 4, 144, 'Основы линейной алгебры'),
('Математический анализ', 7, 4, 144, 'Дифференциальное и интегральное исчисление'),
('Дифференциальные уравнения', 7, 3, 108, 'Решение обыкновенных дифференциальных уравнений'),
('Общая физика', 8, 4, 144, 'Основные законы физики'),
('Квантовая механика', 8, 4, 144, 'Основы квантовой механики'),
('Термодинамика', 8, 3, 108, 'Основы термодинамики и статистической физики'),
('Теоретическая механика', 9, 4, 144, 'Основы теоретической механики'),
('Сопротивление материалов', 9, 4, 144, 'Основы сопротивления материалов'),
('Детали машин', 9, 3, 108, 'Основы проектирования деталей машин'),
('Электротехника', 10, 4, 144, 'Основы электротехники'),
('Электроника', 10, 4, 144, 'Основы электроники'),
('Силовая электроника', 10, 3, 108, 'Основы силовой электроники'),
('Машинное обучение', 1, 5, 180, 'Основы машинного обучения и анализа данных'),
('Глубокое обучение', 1, 5, 180, 'Нейронные сети и глубокое обучение'),
('Кибербезопасность', 2, 5, 180, 'Продвинутые методы защиты информации'),
('Пентестинг', 2, 5, 180, 'Методы тестирования на проникновение'),
('Международные финансы', 4, 5, 180, 'Финансы в международном контексте'),
('Финансовые рынки', 4, 5, 180, 'Анализ и функционирование финансовых рынков'),
('Теория языков', 5, 5, 180, 'Теоретические основы языкознания'),
('Историческая лингвистика', 5, 5, 180, 'Развитие языков в исторической перспективе'),
('История искусства', 6, 5, 180, 'Развитие мирового искусства'),
('История науки', 6, 5, 180, 'Развитие научной мысли в истории'),
('Численные методы', 7, 5, 180, 'Методы численного решения математических задач'),
('Оптимизация', 7, 5, 180, 'Методы оптимизации в математике'),
('Квантовая теория поля', 8, 5, 180, 'Основы квантовой теории поля'),
('Физика твердого тела', 8, 5, 180, 'Физические свойства твердых тел'),
('Теория механизмов', 9, 5, 180, 'Теоретические основы механики машин'),
('Гидравлика', 9, 5, 180, 'Основы гидравлики и гидромеханики'),
('Автоматизированные системы', 10, 5, 180, 'Проектирование автоматизированных систем'),
('Микропроцессорная техника', 10, 5, 180, 'Основы микропроцессорной техники');

-- Заполнение таблицы учебного плана
INSERT INTO curriculum (program_id, course_id, semester, hours_lecture, hours_practice, hours_lab, exam_type) 
values
(1, 1, 1, 36, 36, 72, 'Экзамен'),
(1, 2, 2, 36, 36, 36, 'Экзамен'),
(1, 3, 3, 36, 36, 72, 'Экзамен'),
(1, 31, 4, 36, 36, 108, 'Экзамен'),
(2, 4, 1, 36, 36, 36, 'Экзамен'),
(2, 5, 2, 36, 36, 72, 'Экзамен'),
(2, 6, 3, 36, 36, 36, 'Экзамен'),
(2, 33, 4, 36, 36, 108, 'Экзамен'),
(3, 7, 1, 36, 36, 36, 'Экзамен'),
(3, 8, 2, 36, 36, 36, 'Экзамен'),
(3, 9, 3, 36, 36, 72, 'Экзамен'),
(3, 35, 4, 36, 36, 72, 'Экзамен'),
(4, 10, 1, 36, 36, 36, 'Экзамен'),
(4, 11, 2, 36, 36, 72, 'Экзамен'),
(4, 12, 3, 36, 36, 36, 'Экзамен'),
(4, 36, 4, 36, 36, 72, 'Экзамен'),
(5, 13, 1, 18, 54, 0, 'Зачет'),
(5, 14, 2, 18, 54, 0, 'Зачет'),
(5, 15, 3, 36, 36, 36, 'Экзамен'),
(5, 37, 4, 36, 36, 108, 'Экзамен'),
(6, 16, 1, 36, 36, 36, 'Экзамен'),
(6, 17, 2, 36, 36, 36, 'Экзамен'),
(6, 18, 3, 36, 36, 72, 'Экзамен'),
(6, 39, 4, 36, 36, 108, 'Экзамен');

--1. Найти средний балл студентов 2 курса по направлению "Информатика и вычислительная техника", у которых в 3 семестре по предмету "ООП" была оценка 4
SELECT AVG(g.grade) AS average_grade
FROM students s
JOIN study_programs sp ON s.program_id = sp.program_id
JOIN grades g ON s.student_id = g.student_id
JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
JOIN courses co ON c.course_id = co.course_id
WHERE sp.program_name = 'Информатика и вычислительная техника'
  AND s.admission_year = EXTRACT(YEAR FROM CURRENT_DATE) - 2 
  AND co.course_name = 'ООП'
  AND c.semester = 3
  AND g.grade = 4;

--2. Найти топ-5 преподавателей с самым высоким средним баллом по их предметам за последний учебный год
SELECT 
    t.last_name || ' ' || LEFT(t.first_name, 1) || '.' || COALESCE(LEFT(t.middle_name, 1) || '.', '') AS teacher_name,
    AVG(g.grade) AS avg_grade,
    COUNT(DISTINCT g.student_id) AS students_count
FROM teachers t
JOIN teaching_assignments ta ON t.teacher_id = ta.teacher_id
JOIN grades g ON ta.assignment_id = g.assignment_id
WHERE ta.academic_year = EXTRACT(YEAR FROM CURRENT_DATE) - 1
GROUP BY t.teacher_id, t.last_name, t.first_name, t.middle_name
ORDER BY avg_grade DESC
LIMIT 5;

--3. Определить процент посещаемости для каждой группы по каждому предмету в текущем семестре
SELECT 
    s.student_group,
    co.course_name,
    COUNT(CASE WHEN a.status = 'присутствовал' THEN 1 END) * 100.0 / COUNT(*) AS attendance_percentage
FROM students s
JOIN attendance a ON s.student_id = a.student_id
JOIN teaching_assignments ta ON a.assignment_id = ta.assignment_id
JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
JOIN courses co ON c.course_id = co.course_id
WHERE ta.academic_year = EXTRACT(YEAR FROM CURRENT_DATE)
  AND ta.semester = CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) BETWEEN 9 AND 12 THEN 1 ELSE 2 END
GROUP BY s.student_group, co.course_name
ORDER BY s.student_group, attendance_percentage DESC;

--4. Найти студентов, которые имеют задолженности (оценки ниже 3) более чем по 2 предметам в текущем семестре
SELECT 
    s.last_name || ' ' || s.first_name AS student_name,
    s.student_group,
    COUNT(*) AS failed_courses_count
FROM students s
JOIN grades g ON s.student_id = g.student_id
JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
WHERE ta.academic_year = EXTRACT(YEAR FROM CURRENT_DATE)
  AND ta.semester = CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) BETWEEN 9 AND 12 THEN 1 ELSE 2 END
  AND g.grade < 3
GROUP BY s.student_id, s.last_name, s.first_name, s.student_group
HAVING COUNT(*) > 2
ORDER BY failed_courses_count DESC;

--5. Определить нагрузку преподавателей (количество часов) в текущем семестре по кафедрам
SELECT 
    d.department_name,
    t.last_name || ' ' || LEFT(t.first_name, 1) || '.' AS teacher_name,
    SUM(c.hours_lecture + c.hours_practice + c.hours_lab) AS total_hours
FROM teachers t
JOIN teaching_assignments ta ON t.teacher_id = ta.teacher_id
JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
JOIN departments d ON t.department_id = d.department_id
WHERE ta.academic_year = EXTRACT(YEAR FROM CURRENT_DATE)
  AND ta.semester = CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) BETWEEN 9 AND 12 THEN 1 ELSE 2 END
GROUP BY d.department_name, t.teacher_id, t.last_name, t.first_name
ORDER BY d.department_name, total_hours DESC;

--6. Найти предметы с самым высоким и самым низким средним баллом на факультете за последние 3 года
WITH course_stats AS (
    SELECT 
        f.faculty_name,
        co.course_name,
        AVG(g.grade) AS avg_grade,
        COUNT(*) AS grades_count
    FROM grades g
    JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
    JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
    JOIN courses co ON c.course_id = co.course_id
    JOIN departments d ON co.department_id = d.department_id
    JOIN faculties f ON d.faculty_id = f.faculty_id
    WHERE ta.academic_year BETWEEN EXTRACT(YEAR FROM CURRENT_DATE) - 3 AND EXTRACT(YEAR FROM CURRENT_DATE)
    GROUP BY f.faculty_name, co.course_name
    HAVING COUNT(*) > 20
)
SELECT 
    faculty_name,
    course_name AS highest_avg_grade_course,
    avg_grade AS highest_avg_grade
FROM (
    SELECT 
        faculty_name,
        course_name,
        avg_grade,
        RANK() OVER (PARTITION BY faculty_name ORDER BY avg_grade DESC) AS rank_high
    FROM course_stats
) AS high
WHERE rank_high = 1

UNION ALL

SELECT 
    faculty_name,
    course_name AS lowest_avg_grade_course,
    avg_grade AS lowest_avg_grade
FROM (
    SELECT 
        faculty_name,
        course_name,
        avg_grade,
        RANK() OVER (PARTITION BY faculty_name ORDER BY avg_grade ASC) AS rank_low
    FROM course_stats
) AS low
WHERE rank_low = 1;

--7. Определить динамику успеваемости студентов по курсам (сравнить средние баллы по семестрам)
SELECT 
    co.course_name,
    ta.semester,
    ta.academic_year,
    AVG(g.grade) AS avg_grade,
    COUNT(DISTINCT g.student_id) AS students_count
FROM grades g
JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
JOIN courses co ON c.course_id = co.course_id
WHERE ta.academic_year BETWEEN EXTRACT(YEAR FROM CURRENT_DATE) - 3 AND EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY co.course_name, ta.semester, ta.academic_year
ORDER BY co.course_name, ta.academic_year, ta.semester;

--8. Найти студентов, которые улучшили свою успеваемость во втором семестре по сравнению с первым
WITH semester_grades AS (
    SELECT 
        s.student_id,
        s.last_name || ' ' || s.first_name AS student_name,
        s.student_group,
        ta.semester,
        AVG(g.grade) AS avg_grade
    FROM students s
    JOIN grades g ON s.student_id = g.student_id
    JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
    WHERE ta.academic_year = EXTRACT(YEAR FROM CURRENT_DATE)
    GROUP BY s.student_id, s.last_name, s.first_name, s.student_group, ta.semester
)
SELECT 
    sg1.student_name,
    sg1.student_group,
    sg1.avg_grade AS first_semester_grade,
    sg2.avg_grade AS second_semester_grade,
    sg2.avg_grade - sg1.avg_grade AS improvement
FROM semester_grades sg1
JOIN semester_grades sg2 ON sg1.student_id = sg2.student_id
WHERE sg1.semester = 1 AND sg2.semester = 2
  AND sg2.avg_grade > sg1.avg_grade
ORDER BY improvement DESC;

--9. Определить корреляцию между посещаемостью и успеваемостью студентов по предметам
SELECT 
    co.course_name,
    (COUNT(*) * SUM(a.attendance_rate * g.avg_grade) - SUM(a.attendance_rate) * SUM(g.avg_grade)) / 
    (SQRT((COUNT(*) * SUM(a.attendance_rate * a.attendance_rate) - SUM(a.attendance_rate) * SUM(a.attendance_rate)) * 
     (COUNT(*) * SUM(g.avg_grade * g.avg_grade) - SUM(g.avg_grade) * SUM(g.avg_grade)))) AS correlation
FROM (
    SELECT 
        a.student_id,
        a.assignment_id,
        COUNT(CASE WHEN a.status = 'присутствовал' THEN 1 END) * 1.0 / COUNT(*) AS attendance_rate
    FROM attendance a
    GROUP BY a.student_id, a.assignment_id
) a
JOIN (
    SELECT 
        g.student_id,
        g.assignment_id,
        AVG(g.grade) AS avg_grade
    FROM grades g
    GROUP BY g.student_id, g.assignment_id
) g ON a.student_id = g.student_id AND a.assignment_id = g.assignment_id
JOIN teaching_assignments ta ON a.assignment_id = ta.assignment_id
JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
JOIN courses co ON c.course_id = co.course_id
GROUP BY co.course_name
HAVING COUNT(*) > 10
ORDER BY ABS(correlation) DESC;

--10. Найти "звездных" студентов (тех, кто входит в топ-10% по успеваемости) на каждом курсе каждого направления подготовки
WITH ranked_students AS (
    SELECT 
        sp.program_name,
        EXTRACT(YEAR FROM CURRENT_DATE) - s.admission_year AS course_year,
        s.last_name || ' ' || s.first_name AS student_name,
        s.student_group,
        AVG(g.grade) AS avg_grade,
        PERCENT_RANK() OVER (PARTITION BY sp.program_name, EXTRACT(YEAR FROM CURRENT_DATE) - s.admission_year ORDER BY AVG(g.grade) DESC) AS percentile
    FROM students s
    JOIN grades g ON s.student_id = g.student_id
    JOIN study_programs sp ON s.program_id = sp.program_id
    GROUP BY sp.program_name, s.admission_year, s.last_name, s.first_name, s.student_group
)
SELECT 
    program_name,
    course_year,
    student_name,
    student_group,
    avg_grade
FROM ranked_students
WHERE percentile <= 0.1
ORDER BY program_name, course_year, avg_grade DESC;

--11. Определить преподавателей, у которых средний балл студентов ниже среднего по университету
WITH teacher_stats AS (
    SELECT 
        t.teacher_id,
        t.last_name || ' ' || LEFT(t.first_name, 1) || '.' AS teacher_name,
        AVG(g.grade) AS avg_grade,
        COUNT(DISTINCT g.student_id) AS students_count
    FROM teachers t
    JOIN teaching_assignments ta ON t.teacher_id = ta.teacher_id
    JOIN grades g ON ta.assignment_id = g.assignment_id
    GROUP BY t.teacher_id, t.last_name, t.first_name
),
uni_avg AS (
    SELECT AVG(grade) AS uni_avg_grade FROM grades
)
SELECT 
    ts.teacher_name,
    ts.avg_grade,
    ua.uni_avg_grade,
    ts.avg_grade - ua.uni_avg_grade AS difference
FROM teacher_stats ts
CROSS JOIN uni_avg ua
WHERE ts.avg_grade < ua.uni_avg_grade
  AND ts.students_count > 10
ORDER BY difference ASC;

--12. Найти предметы, по которым успеваемость студентов существенно отличается между группами
WITH group_stats AS (
    SELECT 
        co.course_name,
        s.student_group,
        AVG(g.grade) AS avg_grade,
        COUNT(*) AS grades_count
    FROM grades g
    JOIN students s ON g.student_id = s.student_id
    JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
    JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
    JOIN courses co ON c.course_id = co.course_id
    WHERE ta.academic_year = EXTRACT(YEAR FROM CURRENT_DATE)
    GROUP BY co.course_name, s.student_group
    HAVING COUNT(*) > 5
),
course_stats AS (
    SELECT 
        course_name,
        COUNT(DISTINCT student_group) AS groups_count,
        MAX(avg_grade) - MIN(avg_grade) AS grade_range,
        STDDEV(avg_grade) AS grade_stdev
    FROM group_stats
    GROUP BY course_name
    HAVING COUNT(DISTINCT student_group) > 2
)
SELECT 
    course_name,
    groups_count,
    grade_range,
    grade_stdev
FROM course_stats
WHERE grade_range > 1.0
ORDER BY grade_range DESC;

--13. Определить, как меняется успеваемость студентов от первого курса к последнему
WITH student_progress AS (
    SELECT 
        s.student_id,
        s.last_name || ' ' || s.first_name AS student_name,
        sp.program_name,
        EXTRACT(YEAR FROM CURRENT_DATE) - s.admission_year AS course_year,
        AVG(g.grade) AS avg_grade
    FROM students s
    JOIN grades g ON s.student_id = g.student_id
    JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
    JOIN study_programs sp ON s.program_id = sp.program_id
    GROUP BY s.student_id, s.last_name, s.first_name, sp.program_name, s.admission_year
    HAVING COUNT(*) > 3
)
SELECT 
    program_name,
    course_year,
    AVG(avg_grade) AS avg_grade_by_year,
    LAG(AVG(avg_grade)) OVER (PARTITION BY program_name ORDER BY course_year) AS prev_year_avg_grade,
    AVG(avg_grade) - LAG(AVG(avg_grade)) OVER (PARTITION BY program_name ORDER BY course_year) AS grade_change
FROM student_progress
GROUP BY program_name, course_year
ORDER BY program_name, course_year;

--14. Найти студентов, которые пропускают более 30% занятий по любым предметам в текущем семестре
SELECT 
    s.last_name || ' ' || s.first_name AS student_name,
    s.student_group,
    co.course_name,
    COUNT(CASE WHEN a.status = 'отсутствовал' THEN 1 END) * 100.0 / COUNT(*) AS absence_percentage,
    COUNT(*) AS total_classes
FROM students s
JOIN attendance a ON s.student_id = a.student_id
JOIN teaching_assignments ta ON a.assignment_id = ta.assignment_id
JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
JOIN courses co ON c.course_id = co.course_id
WHERE ta.academic_year = EXTRACT(YEAR FROM CURRENT_DATE)
  AND ta.semester = CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) BETWEEN 9 AND 12 THEN 1 ELSE 2 END
GROUP BY s.student_id, s.last_name, s.first_name, s.student_group, co.course_name
HAVING COUNT(CASE WHEN a.status = 'отсутствовал' THEN 1 END) * 100.0 / COUNT(*) > 30
ORDER BY absence_percentage DESC;

--15. Определить, какие пары предметов чаще всего сдаются студентами на "отлично" вместе
WITH excellent_grades AS (
    SELECT 
        g.student_id,
        c.course_id,
        co.course_name
    FROM grades g
    JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
    JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
    JOIN courses co ON c.course_id = co.course_id
    WHERE g.grade = 5
),
course_pairs AS (
    SELECT 
        eg1.course_name AS course1,
        eg2.course_name AS course2,
        COUNT(*) AS excellent_students_count
    FROM excellent_grades eg1
    JOIN excellent_grades eg2 ON eg1.student_id = eg2.student_id
    WHERE eg1.course_id < eg2.course_id
    GROUP BY eg1.course_name, eg2.course_name
    HAVING COUNT(*) > 5
)
SELECT 
    course1,
    course2,
    excellent_students_count,
    RANK() OVER (ORDER BY excellent_students_count DESC) AS rank
FROM course_pairs
ORDER BY excellent_students_count DESC;

--16. Определить, как размер группы влияет на успеваемость студентов
WITH group_sizes AS (
    SELECT 
        student_group,
        COUNT(*) AS group_size
    FROM students
    GROUP BY student_group
),
group_performance AS (
    SELECT 
        s.student_group,
        AVG(g.grade) AS avg_grade
    FROM students s
    JOIN grades g ON s.student_id = g.student_id
    GROUP BY s.student_group
)
SELECT 
    gs.student_group,
    gs.group_size,
    gp.avg_grade,
    (COUNT(*) * SUM(gs.group_size * gp.avg_grade) - SUM(gs.group_size) * SUM(gp.avg_grade)) / 
    (SQRT((COUNT(*) * SUM(gs.group_size * gs.group_size) - SUM(gs.group_size) * SUM(gs.group_size)) * 
     (COUNT(*) * SUM(gp.avg_grade * gp.avg_grade) - SUM(gp.avg_grade) * SUM(gp.avg_grade)))) AS correlation
FROM group_sizes gs
JOIN group_performance gp ON gs.student_group = gp.student_group
GROUP BY gs.student_group, gs.group_size, gp.avg_grade;

--17. Найти аномалии в оценках - студентов, чьи оценки значительно отличаются от среднего по группе
WITH group_averages AS (
    SELECT 
        s.student_group,
        ta.assignment_id,
        AVG(g.grade) AS group_avg_grade,
        STDDEV(g.grade) AS group_grade_stdev
    FROM students s
    JOIN grades g ON s.student_id = g.student_id
    JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
    GROUP BY s.student_group, ta.assignment_id
    HAVING COUNT(*) > 5
)
SELECT 
    s.last_name || ' ' || s.first_name AS student_name,
    s.student_group,
    co.course_name,
    g.grade,
    ga.group_avg_grade,
    (g.grade - ga.group_avg_grade) / NULLIF(ga.group_grade_stdev, 0) AS z_score,
    CASE 
        WHEN (g.grade - ga.group_avg_grade) / NULLIF(ga.group_grade_stdev, 0) > 2 THEN 'Высокая положительная аномалия'
        WHEN (g.grade - ga.group_avg_grade) / NULLIF(ga.group_grade_stdev, 0) < -2 THEN 'Высокая отрицательная аномалия'
        ELSE 'Норма'
    END AS anomaly_status
FROM students s
JOIN grades g ON s.student_id = g.student_id
JOIN teaching_assignments ta ON g.assignment_id = ta.assignment_id
JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
JOIN courses co ON c.course_id = co.course_id
JOIN group_averages ga ON s.student_group = ga.student_group AND ta.assignment_id = ga.assignment_id
WHERE ABS((g.grade - ga.group_avg_grade) / NULLIF(ga.group_grade_stdev, 0)) > 2
ORDER BY ABS(z_score) DESC;

--18. Определить, есть ли зависимость между возрастом преподавателя и средним баллом его студентов
SELECT 
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, t.birth_date)) AS teacher_age,
    AVG(g.grade) AS avg_student_grade,
    COUNT(DISTINCT g.student_id) AS students_count
FROM teachers t
JOIN teaching_assignments ta ON t.teacher_id = ta.teacher_id
JOIN grades g ON ta.assignment_id = g.assignment_id
WHERE t.birth_date IS NOT NULL
GROUP BY EXTRACT(YEAR FROM AGE(CURRENT_DATE, t.birth_date))
HAVING COUNT(DISTINCT g.student_id) > 10
ORDER BY teacher_age;

--19. Найти студентов, которые перешли с платного обучения на бюджет (по изменению размера стипендии)
WITH scholarship_changes AS (
    SELECT 
        s.student_id,
        s.last_name || ' ' || s.first_name AS student_name,
        s.student_group,
        s.scholarship,
        LAG(s.scholarship) OVER (PARTITION BY s.student_id ORDER BY EXTRACT(YEAR FROM CURRENT_DATE) - s.admission_year) AS prev_year_scholarship
    FROM students s
)
SELECT 
    student_name,
    student_group,
    prev_year_scholarship AS old_scholarship,
    scholarship AS new_scholarship
FROM scholarship_changes
WHERE prev_year_scholarship = 0 AND scholarship > 0
ORDER BY scholarship DESC;

--20. Определить, какие предметы чаще всего преподаются преподавателями не их кафедры (межкафедральное преподавание)
SELECT 
    co.course_name,
    d.department_name AS course_department,
    COUNT(DISTINCT ta.teacher_id) AS external_teachers_count,
    COUNT(DISTINCT CASE WHEN t.department_id <> co.department_id THEN ta.teacher_id END) AS cross_department_teachers_count,
    COUNT(DISTINCT CASE WHEN t.department_id <> co.department_id THEN ta.teacher_id END) * 100.0 / 
    COUNT(DISTINCT ta.teacher_id) AS cross_department_percentage
FROM teaching_assignments ta
JOIN teachers t ON ta.teacher_id = t.teacher_id
JOIN curriculum c ON ta.curriculum_id = c.curriculum_id
JOIN courses co ON c.course_id = co.course_id
JOIN departments d ON co.department_id = d.department_id
GROUP BY co.course_name, d.department_name
HAVING COUNT(DISTINCT CASE WHEN t.department_id <> co.department_id THEN ta.teacher_id END) > 0
ORDER BY cross_department_percentage DESC;