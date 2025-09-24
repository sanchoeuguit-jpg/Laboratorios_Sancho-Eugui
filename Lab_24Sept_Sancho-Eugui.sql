SELECT officeCode, phone 
FROM offices;

SELECT firstName, lastName
FROM employees
WHERE email LIKE '%.es'


SELECT customerName, city, country
FROM customers
WHERE state IS NULL;

SELECT customerNumber, amount
FROM payments
WHERE amount > 20000;

SELECT customerNumber, amount, paymentDate
FROM payments
WHERE amount > 20000 
  AND YEAR(paymentDate) = 2005;
  
  SELECT DISTINCT productCode
FROM orderdetails;

SELECT country, COUNT(*) AS total_compras
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY country;

SELECT productLine, LENGTH(textDescription) AS descripcion_largo
FROM productlines
ORDER BY descripcion_largo DESC
LIMIT 1;

SELECT o.officeCode, COUNT(c.customerNumber) AS total_clientes
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY o.officeCode;

SELECT DAYNAME(o.orderDate) AS dia, COUNT(*) AS total_pedidos
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.productLine LIKE '%Cars%'
GROUP BY dia
ORDER BY total_pedidos DESC
LIMIT 1;

SELECT officeCode, 
       CASE WHEN territory = 'NA' THEN 'USA' ELSE territory END AS territorio_corregido
FROM offices;

SELECT YEAR(o.orderDate) AS anio, MONTH(o.orderDate) AS mes,
       AVG(od.quantityOrdered * od.priceEach) AS promedio_carrito,
       SUM(od.quantityOrdered) AS total_items
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE (e.lastName = 'Patterson')
  AND YEAR(o.orderDate) IN (2004, 2005)
GROUP BY anio, mes;

SELECT anio, mes, AVG(total_carrito) AS promedio_carrito, SUM(total_items) AS total_items
FROM (
    SELECT YEAR(o.orderDate) AS anio, MONTH(o.orderDate) AS mes,
           (od.quantityOrdered * od.priceEach) AS total_carrito,
           od.quantityOrdered AS total_items
    FROM employees e
    JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE e.lastName = 'Patterson'
      AND YEAR(o.orderDate) IN (2004, 2005)
) AS sub
GROUP BY anio, mes;

SELECT DISTINCT o.officeCode, o.city, o.country
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.state IS NULL;








