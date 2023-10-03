-- SQL-команды для создания таблиц

CREATE TABLE employees
(
	employee_id int primary key,
	first_name varchar(20),
	last_name varchar(20),
	title varchar(50),
	birth_date date,
	notes text
);


CREATE TABLE customers
(
	customer_id varchar(5) PRIMARY KEY,
	company_name text,
	contact_name varchar(50)
);


CREATE TABLE orders
(
	order_id int primary key,
	customer_id varchar(5) NOT NULL REFERENCES customers(customer_id),
	employee_id int NOT NULL REFERENCES employees(employee_id),
	order_date date,
	ship_city varchar(30)
);