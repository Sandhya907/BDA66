CREATE DATABASE snowflake_schema;
use snowflake_schema;

-- CREATING DIMENSION TABLE
CREATE TABLE geography (
geography_id INT AUTO_INCREMENT PRIMARY KEY,
country VARCHAR (100) NOT NULL,
region VARCHAR (100) NOT NULL
);

-- CREATING PRODUCT DIMENSION
CREATE TABLE product(
product_id INT AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
product_category VARCHAR(100) NOT NULL
);

-- CREATING TIME DIMENSION
CREATE TABLE time (
time_id INT AUTO_INCREMENT PRIMARY KEY,
date DATE NOT NULL,
month VARCHAR (50) NOT NULL,
year INT NOT NULL
);

-- CREATING FACT TABLE
CREATE TABLE sales1 (
sales1_id INT AUTO_INCREMENT PRIMARY KEY,
geography_id INT NOT NULL,
product_id INT NOT NULL,
time_id INT NOT NULL,
quantity_sold INT NOT NULL,
total_revenue DECIMAL (10,2) NOT NULL,
FOREIGN KEY (geography_id) REFERENCES geography(geography_id),
FOREIGN KEY (product_id) REFERENCES product(product_id),
FOREIGN KEY (time_id) REFERENCES time(time_id)
);

-- Inserting Geography Data
INSERT INTO geography (country, region) VALUES
('USA', 'NORTH AMERICA'),
('ITALY', 'EUROPE'),
('NEPAL', 'ASIA'),
('NIGERIA', 'AFRICA'),
('COLUMBIA', 'SOUTH AMERICA');

-- INSERTING INTO PRODUCT DATA 
INSERT INTO product (product_name, product_category) VALUES
('Laptop', 'Electronics'),
('Shoes', 'Apparel'),
('Book', 'Stationery'),
('Water Bottle', 'Drinkware'),
('CANDLE', 'Home Decor');

-- INSERTING INTO TIME DATA 
INSERT INTO time (date, month, year) VALUES
('2024-02-12', 'February', 2024),
('2024-07-18', 'July', 2024),
('2024-08-21', 'August', 2024),
('2024-10-07', 'October', 2024),
('2024-11-09', 'November', 2024);

-- INSERTING INTO sales1
INSERT INTO sales1 (geography_id, product_id, time_id, quantity_sold, total_revenue) VALUES
(1, 1, 1, 10, 10000.00),
(2, 2, 2, 20, 2000.00),
(3, 3, 3, 15, 150.00),
(4, 4, 4, 40, 40000.00),
(5, 5, 5, 75, 46000.00);

show tables;

-- FORIEGN KEYS IN FACT TABLE - geography_id, product_id and time_id links to dimension table 

-- FACT TABLE 
SELECT 
s.sales1_id,
s.geography_id,
s.product_id,
s.time_id,
s.quantity_sold,
s.total_revenue
FROM sales1 s;

-- ADDING GEOGRAPHY TABLE
SELECT 
    s.sales1_id,
    g.country,
    g.region,
    s.quantity_sold,
    s.total_revenue
FROM sales1 s
JOIN geography g ON s.geography_id = g.geography_id;

-- ADDING PRODUCT TABLE
SELECT 
s.sales1_id,
g.country,
g.region,
p.product_name,
p.product_category,
s.quantity_sold,
s.total_revenue
FROM sales1 s
JOIN geography g ON s.geography_id = g.geography_id
JOIN product p ON s.product_id = p.product_id;

-- ADDING TIME TABLE 
SELECT 
s.sales1_id,
g.country,
g.region,
p.product_name,
p.product_category,
t.date,
t.month,
t.year,
s.quantity_sold,
s.total_revenue
FROM sales1 s
JOIN geography g ON s.geography_id = g.geography_id
JOIN product p ON s.product_id = p.product_id
JOIN time t ON s.time_id = t.time_id;

