CREATE TABLE cars (
    id INTEGER PRIMARY KEY,
    brand VARCHAR(255) UNIQUE
);

CREATE TABLE car_classes (
    id INTEGER PRIMARY KEY,
    class_name VARCHAR(255) UNIQUE,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE car_usage (
    car_id INTEGER REFERENCES cars (id),
    class_id INTEGER REFERENCES car_classes (id),
    trunk_volume INTEGER NOT NULL,
    PRIMARY KEY (car_id, class_id)
);

INSERT INTO cars VALUES (1, 'Toyota');
INSERT INTO cars VALUES (2, 'Honda');
INSERT INTO cars VALUES (3, 'BMW');
INSERT INTO cars VALUES (4, 'Suzuki');

INSERT INTO car_classes VALUES (1, 'Sedan', 25000.00);
INSERT INTO car_classes VALUES (2, 'SUV', 35000.00);
INSERT INTO car_classes VALUES (3, 'Wagon', 65000.00);
INSERT INTO car_classes VALUES (4, 'Hatchback', 32000.00);

INSERT INTO car_usage VALUES (1, 1, 400);
INSERT INTO car_usage VALUES (1, 2, 600);
INSERT INTO car_usage VALUES (2, 2, 550);

-- Вывести все данные из таблицы cars
SELECT * FROM cars;

-- Вывести данные о car_id и trunk_volume из таблицы car_usage
SELECT car_id, trunk_volume FROM car_usage;

-- Вывести данные из таблицы car_classes, где class_name = 'SUV'
SELECT * FROM car_classes
WHERE class_name = 'SUV';

-- Внесение данных о покупателях
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE
);

CREATE TABLE product_categories (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE,
    discount DECIMAL(5, 2) NOT NULL
);

CREATE TABLE purchases (
    customer_id INTEGER REFERENCES customers (customer_id),
    category_id INTEGER REFERENCES product_categories (category_id),
    quantity INTEGER NOT NULL,
    PRIMARY KEY (customer_id, category_id)
);

-- Внесение данных о покупателях
INSERT INTO customers VALUES (1, 'John Doe', 'john@example.com');
INSERT INTO customers VALUES (2, 'Jane Smith', 'jane@example.com');

-- Внесение данных в таблицу product_categories
INSERT INTO product_categories VALUES (1, 'Sedan', 0.05);
INSERT INTO product_categories VALUES (2, 'SUV', 0.10);

-- Внесение данных в таблицу purchases
INSERT INTO purchases VALUES (1, 1, 2);
INSERT INTO purchases VALUES (1, 2, 3);
INSERT INTO purchases VALUES (2, 1, 1);

-- Запрос с операциями группировки и сортировки для таблицы "покупатели"
SELECT
    customers.name AS customer_name,
    product_categories.category_name AS category_name,
    SUM(purchases.quantity) AS total_quantity
FROM
    purchases
JOIN
    customers ON purchases.customer_id = customers.customer_id
JOIN
    product_categories ON purchases.category_id = product_categories.category_id
GROUP BY
    customers.name, product_categories.category_name
ORDER BY
    customers.name, total_quantity ASC;

-- Запрос с использованием агрегатных функций для таблицы "покупатели"
SELECT
    customers.customer_id,
    customers.name,
    COUNT(*) AS total_purchases,
    AVG(purchases.quantity) AS average_quantity
FROM
    purchases
JOIN
    customers ON purchases.customer_id = customers.customer_id
GROUP BY
    customers.customer_id, customers.name;
	
