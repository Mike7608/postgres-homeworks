-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE IF EXISTS products
ADD CONSTRAINT check_unit_price
CHECK (unit_price > 0);

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE IF EXISTS products
ADD CONSTRAINT check_discontinued
CHECK (discontinued IN (0, 1));

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
-- вариант 1
CREATE TABLE products_discontinued AS
SELECT *
FROM products
WHERE discontinued = 1;
-- вариант 2
SELECT * INTO products_discontinued
FROM products
WHERE discontinued = 1;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
-- вариант 1
ALTER TABLE order_details DROP CONSTRAINT fk_order_details_products;

ALTER TABLE order_details ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id)
REFERENCES products(product_id)
ON DELETE CASCADE;

DELETE FROM products
WHERE products.discontinued = 1

-- вариант 2
DELETE FROM order_details
WHERE product_id IN (SELECT product_id FROM products WHERE discontinued = 1)
DELETE FROM products
WHERE discontinued = 1