-- Create customers table
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           name TEXT,
                           email TEXT,
                           region_id INTEGER
);

-- Create sales table
CREATE TABLE sales (
                       sale_id SERIAL PRIMARY KEY,
                       product_id INTEGER,
                       customer_id INTEGER,
                       employee_id INTEGER,
                       sale_date DATE,
                       amount NUMERIC
);

-- Create employees table
CREATE TABLE employees (
                           employee_id SERIAL PRIMARY KEY,
                           name TEXT,
                           department_id INTEGER
);

-- Create products table
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          name TEXT,
                          price NUMERIC
);

-- Create interactions table
CREATE TABLE interactions (
                              interaction_id SERIAL PRIMARY KEY,
                              customer_id INTEGER,
                              employee_id INTEGER,
                              interaction_date DATE,
                              notes TEXT
);

-- Create regions table
CREATE TABLE regions (
                         region_id SERIAL PRIMARY KEY,
                         name TEXT
);

-- Create departments table
CREATE TABLE departments (
                             department_id SERIAL PRIMARY KEY,
                             name TEXT
);

-- Create feedback table
CREATE TABLE feedback (
                          feedback_id SERIAL PRIMARY KEY,
                          customer_id INTEGER,
                          rating INTEGER,
                          comment TEXT
);

-- INSERTING INTO TABLES...

-- Insert into customers table
INSERT INTO customers (name, email, region_id) VALUES
                                                   ('Kwame Asante', 'kwame@yahoo.com', 1),
                                                   ('Fatoumata Diop', 'fatoumata@yahoo.com', 2),
                                                   ('Chinedu Okonkwo', 'chinedu@yahoo.com', 3),
                                                   ('Nokukhanya Zulu', 'nokukhanya@yahoo.com', 1),
                                                   ('Musa Abubakar', 'musa@yahoo.com', 2);

-- Insert into sales table
INSERT INTO sales (product_id, customer_id, employee_id, sale_date, amount) VALUES
                                                                                (1, 1, 1, '2024-03-10', 150000.00),
                                                                                (2, 2, 2, '2024-03-11', 20000.00),
                                                                                (3, 3, 3, '2024-03-12', 10000.00),
                                                                                (4, 4, 1, '2024-03-13', 180000.00),
                                                                                (5, 5, 2, '2024-03-14', 220000.00);

-- Insert into employees table
INSERT INTO employees (name, department_id) VALUES
                                                ('Aisha Abubakar', 1),
                                                ('Lungile Ndlovu', 2),
                                                ('Kwasi Boateng', 3);

-- Insert into products table
INSERT INTO products (name, price) VALUES
                                       ('Mobile Phone', 60000.00),
                                       ('Laptop', 100000.00),
                                       ('Tablet', 50000.00);

-- Insert into interactions table
INSERT INTO interactions (customer_id, employee_id, interaction_date, notes) VALUES
                                                                                 (1, 1, '2024-03-10', 'Follow-up call made.'),
                                                                                 (2, 2, '2024-03-11', 'Product demonstration conducted.'),
                                                                                 (3, 3, '2024-03-12', 'Customer inquiry addressed.'),
                                                                                 (4, 1, '2024-03-13', 'Feedback collected.'),
                                                                                 (5, 2, '2024-03-14', 'New product introduced.');

-- Insert into regions table
INSERT INTO regions (name) VALUES
                               ('Littoral'),
                               ('South West'),
                               ('Adamawa');

-- Insert into departments table
INSERT INTO departments (name) VALUES
                                   ('Sales'),
                                   ('Marketing'),
                                   ('Finance');

-- Insert into feedback table
INSERT INTO feedback (customer_id, rating, comment) VALUES
                                                        (1, 4, 'Great service!'),
                                                        (2, 5, 'Very satisfied with the product.'),
                                                        (3, 3, 'Could improve delivery times.'),
                                                        (4, 4, 'Responsive customer support.'),
                                                        (5, 5, 'Love the new features!');


-- List all Customers and their regions
SELECT c.name AS customer_name, r.name AS region_name
FROM customers c
         LEFT JOIN regions r ON c.region_id = r.region_id;

-- Sales Report by Product
SELECT p.name AS product_name, COUNT(s.sale_id) AS num_sales, SUM(s.amount) AS total_sales_amount
FROM sales s
         JOIN products p ON s.product_id = p.product_id
GROUP BY p.name;

-- Employee-Customer Interactions


-- Customer Feedback and Sales
SELECT c.name AS customer_name, f.rating AS feedback_rating, COALESCE(SUM(s.amount), 0) AS total_sales_amount
FROM customers c
         JOIN feedback f ON c.customer_id = f.customer_id
         LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.name, f.rating;

-- Region-Wise Sales Performance
SELECT r.name AS region_name, SUM(s.amount) AS total_sales_amount, COUNT(s.sale_id) AS num_sales
FROM sales s
         JOIN customers c ON s.customer_id = c.customer_id
         JOIN regions r ON c.region_id = r.region_id
GROUP BY r.name;


--Department Interaction Report
SELECT d.name AS department_name, COUNT(i.interaction_id) AS num_interactions
FROM departments d
         JOIN employees e ON d.department_id = e.department_id
         LEFT JOIN interactions i ON e.employee_id = i.employee_id
GROUP BY d.name;

--BONUS TASK
--High-Value Customers
SELECT c.name AS customer_name, SUM(s.amount) AS total_purchase_amount
FROM customers c
         JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.name
HAVING SUM(s.amount) > 100000

--Product Feedback Analysis
SELECT p.name AS product_name, AVG(f.rating) AS average_feedback_rating
FROM products p
         JOIN sales s ON p.product_id = s.product_id
         JOIN feedback f ON s.customer_id = f.customer_id
GROUP BY p.name;


-- Employee Sales vs. Interactions
WITH SalesTotal AS (
    SELECT employee_id, SUM(amount) AS total_sales
    FROM sales
    GROUP BY employee_id
),
     InteractionsCount AS (
         SELECT employee_id, COUNT(interaction_id) AS num_interactions
         FROM interactions
         GROUP BY employee_id
     )
SELECT e.name AS employee_name, COALESCE(S.total_sales, 0) AS total_sales, COALESCE(I.num_interactions, 0) AS num_interactions
FROM employees e
         LEFT JOIN SalesTotal S ON e.employee_id = S.employee_id
         LEFT JOIN InteractionsCount I ON e.employee_id = I.employee_id;


--Unsatisfied Customer Follow-ups
SELECT c.name AS customer_name, MAX(i.interaction_date) AS last_interaction_date
FROM customers c
         JOIN feedback f ON c.customer_id = f.customer_id
         LEFT JOIN interactions i ON c.customer_id = i.customer_id
WHERE f.rating < 3
GROUP BY c.name;

-- Unsatisfied Customer Follow-ups
SELECT c.name AS customer_name, MAX(i.interaction_date) AS last_interaction_date
FROM customers c
         JOIN feedback f ON c.customer_id = f.customer_id
         LEFT JOIN interactions i ON c.customer_id = i.customer_id
WHERE f.rating < 4
GROUP BY c.name;

