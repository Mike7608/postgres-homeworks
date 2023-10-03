"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv

conn = psycopg2.connect(
    host="localhost",
    database="north",
    user="postgres",
    password="admin"
)

cur = conn.cursor()

# Заполняем таблицу CUSTOMERS
with open('north_data/customers_data.csv', 'r') as file:
    csv_reader = csv.reader(file)
    next(csv_reader)  # пропускаем заголовок CSV файла

    for row in csv_reader:
        cur.execute("INSERT INTO customers (customer_id, company_name, contact_name) VALUES (%s, %s, %s)", row)
print("Таблица CUSTOMERS данными заполнена")

# Заполняем таблицу EMPLOYEES
with open('north_data/employees_data.csv', 'r') as file:
    csv_reader = csv.reader(file)
    next(csv_reader)  # пропускаем заголовок CSV файла

    for row in csv_reader:
        cur.execute("INSERT INTO employees (employee_id, first_name, last_name, title, birth_date, notes) "
                    "VALUES (%s, %s, %s, %s, %s, %s)", row)
print("Таблица EMPLOYEES данными заполнена")

# Заполняем таблицу ORDERS
with open('north_data/orders_data.csv', 'r') as file:
    csv_reader = csv.reader(file)
    next(csv_reader)  # пропускаем заголовок CSV файла

    for row in csv_reader:
        cur.execute("INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city) "
                    "VALUES (%s, %s, %s, %s, %s)", row)
print("Таблица ORDERS данными заполнена")

conn.commit()

cur.close()
conn.close()
