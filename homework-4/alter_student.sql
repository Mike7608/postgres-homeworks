-- 1. Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar
create table if not exists student (
	student_id serial primary key,
	first_name varchar not null,
	last_name varchar not null,
	birthday date,
  	phone varchar
);

-- 2. Добавить в таблицу student колонку middle_name varchar
alter table if exists student
add column middle_name varchar;

-- 3. Удалить колонку middle_name
alter table if exists student
drop column middle_name;

-- 4. Переименовать колонку birthday в birth_date
alter table if exists student
rename column birthday to birth_date;

-- 5. Изменить тип данных колонки phone на varchar(32)
alter table if exists student
alter column phone type varchar(32);

-- 6. Вставить три любых записи с автогенерацией идентификатора
insert into student (first_name, last_name, birth_date, phone)
values ('Mike', 'Myers', '1970-10-10', '123-45-46');
insert into student (first_name, last_name, birth_date, phone)
values ('Rita', 'Myers', '1971-2-1', '147-58-69');
insert into student (first_name, last_name, birth_date, phone)
values ('Jon', 'Watson', '1969-12-31', '111-22-33');

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
truncate table student restart identity;
