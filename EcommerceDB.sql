CREATE DATABASE EcommerceDB;
use ECommerceDB;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);



INSERT INTO customers VALUES 
(1, 'Tulasi', 'tulasi@mail.com', 'Nellore'),
(2, 'Shyam', 'shyam@mail.com', 'Gudur'),
(3, 'Prasanna','prasanna@mail.com','Ongole'),
(4, 'Lakshmi', 'lakshmi@mail.com','Kavali'),
(5, 'Neel' , 'neel@mail.com' , 'Kadapa');

select * from customers;

INSERT INTO products VALUES 
(101, 'Keyboard', 500.00, 50),
(102, 'Mouse', 300.00, 70),
(103, 'Monitor', 7000.00, 20),
(104, 'Speaker', 800.00, 30);

select * from products ;

INSERT INTO orders VALUES 
(1001, 1, '2024-05-20'),
(1002, 2, '2024-05-21'),
(1003, 3, '2024-06-19'),
(1004, 4, '2025-01-09'),
(1005, 5, '2025-04-18');

select * from orders;

INSERT INTO Order_Items VALUES 
(1001, 101, 2),
(1002, 102, 1),
(1003, 103, 2),
(1004, 104, 3),
(1005, 101, 4);

select * from Order_Items;

INSERT INTO Payments VALUES 
(501, 1001, 1000.00, '2024-05-20', 'UPI'),
(502, 1002, 300.00, '2024-05-21', 'Card'),
(503, 1003, 14000.00, '2024-06-19', 'Card'),
(504, 1004, 2400.00, '2025-01-09', 'UPI'),
(505, 1005, 2000.00,'2025-04-18', 'UPI');

select * from Payments;

-- Customers_name and Total_purchase to show

SELECT c.name AS Customer_Name, SUM(p.amount) AS Total_Purchase
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.name;

-- Top selling products

SELECT p.product_name, SUM(oi.quantity) AS Total_Quantity_Sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY Total_Quantity_Sold DESC;

-- Order payment greater than 1000

SELECT o.order_id, c.name, pay.amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN payments pay ON o.order_id = pay.order_id
WHERE pay.amount > 1000;

-- Customers from a Particular City 

SELECT * FROM customers WHERE city = 'Nellore';