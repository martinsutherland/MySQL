-- SQL notes

-- (INNER) JOIN: Returns records that have matching values in both tables
-- LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
-- RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
-- FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table

-- INNER JOINS

-- This query below joins two tables based on matching customers IDs. This will discount entries in the customer table who do not have an order

SELECT order_id, o.customer_id, first_name, last_name
FROM orders o
INNER JOIN customers c
	ON o.customer_id = c.customer_id

-- This query joins 3 tables, the customer and order tables are joined as above, but in this instance the order_status table is also joined which includes the name of the order_status, 
-- rather than just the reference

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name AS status 
FROM orders o
INNER JOIN customers c
	ON o.customer_id = c.customer_id
INNER JOIN order_statuses os
	ON o.status = os.order_status_id

-- RIGHT INNER JOIN

-- This query joins two tables based on the customer_id, this example also includes customers who have no orders and the order_id is displayed as null
-- This additional ORDER BY line lists the data (by default) in ascending order. This can be changed by adding 'DESC'

SELECT c.customer_id, c.first_name, o.order_id FROM ORDERS o 
RIGHT JOIN customers c
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id

-- JOINING ACROSS DATABASES

-- In this example we join tables from 2 different databases. This is done by specifying the databases within your query

SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id

-- SELF JOINS

-- A SELF JOIN is joining the same table together. In this example we can list the manager's name next to each employee. In the original table you can only see the employee_id of who they report to

SELECT e.employee_id, e.first_name, e.last_name, m.first_name as Manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id

-- JOINING MULTIPLE TABLES

-- In this example, we JOIN 3 tables

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name AS status 
FROM orders o
INNER JOIN customers c
	ON o.customer_id = c.customer_id
INNER JOIN order_statuses os
	ON o.status = os.order_status_id

-- CROSS JOIN

SELECT c.first_name AS customer, p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name

-- COMPOUND JOIN CONDITIONS

SELECT
	o.order_id,
	o.order_date,
	c.first_name AS customer,
    sh.name AS shipper,
    os.name as status
FROM orders o
 JOIN customers c
	ON o.customer_id = c.customer_id
 LEFT JOIN shippers sh	
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os 
	ON o.status = os.order_status_id

-- IMPLICIT JOIN

-- OUTER JOIN

-- OUTER JOIN MULTIPLE TABLES

-- SELF OUTER JOIN