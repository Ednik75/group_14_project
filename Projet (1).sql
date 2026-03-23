-- ==========================================================
-- CS27 PROJECT: E-COMMERCE MANAGEMENT SYSTEM
-- PART 2 & 3: ENGLISH SCHEMA & QUERIES
-- ==========================================================

CREATE DATABASE IF NOT EXISTS EcommerceBIT_EN;

USE EcommerceBIT_EN;

-- Temporarily disable foreign key checks to drop tables safely
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Payments,
Order_Items,
Orders,
Products,
Categories,
Customers;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------
-- 2.1 DATABASE AND TABLE CREATION
-- ---------------------------------------------------------

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    address TEXT,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories (category_id) ON DELETE SET NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM(
        'Pending',
        'Shipped',
        'Delivered',
        'Cancelled'
    ) DEFAULT 'Pending',
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers (customer_id) ON DELETE CASCADE
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products (product_id) ON DELETE RESTRICT
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    order_id INT UNIQUE,
    FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 2.2 DATA INSERTION
-- ---------------------------------------------------------

INSERT INTO
    Categories (category_name)
VALUES ('Electronics'),
    ('Fashion'),
    ('Beverages'),
    ('Books'),
    ('Beauty'),
    ('Hardware'),
    ('Toys'),
    ('Computing'),
    ('School Supplies'),
    ('Groceries');

INSERT INTO
    Customers (
        last_name,
        first_name,
        email,
        password_hash,
        address,
        registration_date
    )
VALUES (
        'Traore',
        'Adama',
        'adama@email.bf',
        'pass1',
        'Ouagadougou',
        '2024-01-01 09:00:00'
    ),
    (
        'Savadogo',
        'Fatim',
        'fatim@email.bf',
        'pass2',
        'Bobo-Dioulasso',
        '2024-01-02 10:30:00'
    ),
    (
        'Ouedraogo',
        'Issa',
        'issa@email.bf',
        'pass3',
        'Koudougou',
        '2024-01-03 14:15:00'
    ),
    (
        'Zongo',
        'Moussa',
        'moussa@email.bf',
        'pass4',
        'Ouagadougou',
        '2024-01-04 16:45:00'
    ),
    (
        'Barry',
        'Ali',
        'ali@email.bf',
        'pass5',
        'Banfora',
        '2024-01-05 08:20:00'
    ),
    (
        'Diallo',
        'Awa',
        'awa@email.bf',
        'pass6',
        'Dori',
        '2024-01-06 11:10:00'
    ),
    (
        'Sawadogo',
        'Rokia',
        'rokia@email.bf',
        'pass7',
        'Kaya',
        '2024-01-07 13:50:00'
    ),
    (
        'Coulibaly',
        'Yacouba',
        'yac@email.bf',
        'pass8',
        'Ouahigouya',
        '2024-01-08 15:30:00'
    ),
    (
        'Sanou',
        'Mariam',
        'mariam@email.bf',
        'pass9',
        'Bobo-Dioulasso',
        '2024-01-09 17:05:00'
    ),
    (
        'Ilboudo',
        'Paul',
        'paul@email.bf',
        'pass10',
        'Fada N\'Gourma',
        '2024-01-10 09:40:00'
    );

INSERT INTO
    Products (
        product_name,
        price,
        stock,
        category_id
    )
VALUES (
        'Smartphone S23',
        250000,
        10,
        1
    ),
    ('iPhone 15', 800000, 5, 1),
    ('Blue Jeans', 15000, 50, 2),
    (
        'Cotton T-shirt',
        5000,
        100,
        2
    ),
    (
        'Champagne Bottle',
        300000,
        2,
        3
    ),
    (
        'SQL Database Book',
        12000,
        20,
        4
    ),
    ('Face Cream', 8000, 30, 5),
    ('Power Drill', 10000, 15, 6),
    (
        'Dell XPS Laptop',
        450000,
        8,
        8
    ),
    (
        'Math Notebooks',
        2000,
        200,
        9
    );

INSERT INTO
    Orders (
        customer_id,
        status,
        order_date
    )
VALUES (
        1,
        'Delivered',
        '2024-02-10 10:00:00'
    ),
    (
        2,
        'Pending',
        '2024-02-12 14:30:00'
    ),
    (
        3,
        'Shipped',
        '2024-02-15 09:15:00'
    ),
    (
        4,
        'Pending',
        '2024-02-18 16:45:00'
    ),
    (
        5,
        'Delivered',
        '2024-02-20 11:20:00'
    ),
    (
        6,
        'Cancelled',
        '2024-02-22 08:10:00'
    ),
    (
        7,
        'Shipped',
        '2024-02-25 13:50:00'
    ),
    (
        8,
        'Delivered',
        '2024-02-28 15:30:00'
    ),
    (
        9,
        'Pending',
        '2024-03-01 17:05:00'
    ),
    (
        10,
        'Delivered',
        '2024-03-05 09:40:00'
    );

INSERT INTO
    Order_Items (
        order_id,
        product_id,
        quantity,
        unit_price
    )
VALUES (1, 1, 1, 250000),
    (2, 3, 2, 15000),
    (3, 6, 1, 12000),
    (4, 4, 3, 5000),
    (5, 5, 1, 300000),
    (6, 7, 1, 8000),
    (7, 8, 2, 10000),
    (8, 9, 1, 450000),
    (9, 10, 5, 2000),
    (10, 2, 1, 800000);

INSERT INTO
    Payments (
        order_id,
        amount,
        payment_method,
        payment_date
    )
VALUES (
        1,
        250000,
        'Mobile Money',
        '2024-02-10 10:05:00'
    ),
    (
        2,
        30000,
        'Mobile Money',
        '2024-02-12 14:35:00'
    ),
    (
        3,
        12000,
        'Credit Card',
        '2024-02-15 09:20:00'
    ),
    (
        4,
        15000,
        'PayPal',
        '2024-02-18 16:50:00'
    ),
    (
        5,
        300000,
        'Cash',
        '2024-02-20 11:25:00'
    ),
    (
        7,
        20000,
        'Mobile Money',
        '2024-02-25 13:55:00'
    ),
    (
        8,
        450000,
        'Credit Card',
        '2024-02-28 15:35:00'
    ),
    (
        9,
        10000,
        'Mobile Money',
        '2024-03-01 17:10:00'
    ),
    (
        10,
        800000,
        'Mobile Money',
        '2024-03-05 09:45:00'
    ),
    (
        6,
        8000,
        'Cash',
        '2024-02-22 08:15:00'
    );

-- ---------------------------------------------------------
-- 2.3 DATA MANIPULATION (UPDATE & DELETE)
-- ---------------------------------------------------------

-- 3 UPDATE statements
UPDATE Products SET price = 240000 WHERE product_id = 1;

UPDATE Orders SET status = 'Shipped' WHERE order_id = 2;

UPDATE Customers SET address = 'Ouaga Inter' WHERE customer_id = 1;

-- 2 DELETE statements
DELETE FROM Order_Items WHERE order_item_id = 10;

DELETE FROM Payments WHERE payment_id = 10;

-- Referential integrity violation demonstration (Uncomment to test error)
-- DELETE FROM Products WHERE product_id = 1;

-- ---------------------------------------------------------
-- 2.4 DATA RETRIEVAL (SELECT QUERIES)
-- ---------------------------------------------------------

-- 1. Retrieve all data from a table
SELECT * FROM Customers;

-- 2. Select specific columns with WHERE
SELECT last_name, email FROM Customers WHERE address = 'Ouagadougou';

-- 3. Filter with ORDER BY
SELECT * FROM Products ORDER BY price DESC;

-- 4. Limit results
SELECT * FROM Orders LIMIT 5;

-- 5. Filter using BETWEEN, LIKE, and IN
SELECT * FROM Products WHERE price BETWEEN 5000 AND 50000;

SELECT product_name FROM Products WHERE product_name LIKE 'S%';

SELECT * FROM Orders WHERE status IN ('Pending', 'Shipped');

-- 6. INNER JOIN
SELECT Customers.last_name, Orders.order_date, Orders.status
FROM Customers
    INNER JOIN Orders ON Customers.customer_id = Orders.customer_id;

-- 7. LEFT JOIN
SELECT Customers.last_name, Orders.order_id
FROM Customers
    LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id;

-- 8. JOIN on 3 or more tables
SELECT C.last_name AS customer_name, O.order_id, P.product_name, OI.quantity
FROM
    Orders O
    JOIN Order_Items OI ON O.order_id = OI.order_id
    JOIN Products P ON OI.product_id = P.product_id
    JOIN Customers C ON O.customer_id = C.customer_id;

-- 9. Filter with IS NULL / IS NOT NULL
SELECT * FROM Products WHERE category_id IS NOT NULL;

-- ==========================================================
-- PART 3: AGGREGATIONS AND REPORTING
-- ==========================================================

-- 1. COUNT: Total number of registered customers
SELECT COUNT(*) AS total_customers FROM Customers;

-- 2. MAX and MIN: Highest and lowest product prices
SELECT MAX(price) AS max_price, MIN(price) AS min_price
FROM Products;

-- 3. AVG: Average price of products
SELECT AVG(price) AS average_price FROM Products;

-- 4. SUM: Total revenue (sum of all payments)
SELECT SUM(amount) AS total_revenue FROM Payments;

-- 5. GROUP BY: Number of products per category
SELECT C.category_name, COUNT(P.product_id) AS number_of_products
FROM Categories C
    LEFT JOIN Products P ON C.category_id = P.category_id
GROUP BY
    C.category_name;

-- 6. GROUP BY: Total revenue generated per payment method
SELECT
    payment_method,
    SUM(amount) AS generated_revenue
FROM Payments
GROUP BY
    payment_method;

-- 7. HAVING: Payment methods that generated more than 100,000
SELECT
    payment_method,
    SUM(amount) AS generated_revenue
FROM Payments
GROUP BY
    payment_method
HAVING
    generated_revenue > 100000;

-- 8. COMPLEX FINAL REPORT: Top spending customers (more than 50,000 total spent)
SELECT
    C.last_name,
    C.first_name,
    COUNT(O.order_id) AS total_orders,
    SUM(OI.quantity * OI.unit_price) AS total_spent
FROM
    Customers C
    JOIN Orders O ON C.customer_id = O.customer_id
    JOIN Order_Items OI ON O.order_id = OI.order_id
GROUP BY
    C.customer_id,
    C.last_name,
    C.first_name
HAVING
    total_spent > 50000
ORDER BY total_spent DESC;