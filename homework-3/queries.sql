-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select customers.company_name, concat(employees.first_name, ' ', employees.last_name) as employee from orders
join shippers on orders.ship_via = shippers.shipper_id
join customers on orders.customer_id = customers.customer_id
join employees on orders.employee_id = employees.employee_id
where shippers.company_name = 'United Package' and customers.city = 'London' and employees.city = 'London';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select product_name, units_in_stock, suppliers.contact_name, suppliers.phone from products
join suppliers on products.supplier_id = suppliers.supplier_id
join categories on products.category_id = categories.category_id
where products.units_in_stock < 25 and products.discontinued = 0 and categories.category_name in ('Dairy Products', 'Condiments')
order by products.units_in_stock;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select customers.company_name
from customers
left join orders on orders.customer_id = customers.customer_id
where orders.customer_id is null;

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select products.product_name
from products
where products.product_id in (select order_details.product_id from order_details where order_details.quantity = 10);