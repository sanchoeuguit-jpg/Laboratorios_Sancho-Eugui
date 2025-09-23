-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS ZaraBusiness;
USE ZaraBusiness;

-- Tabla de Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    email_cliente VARCHAR(100),
    ciudad VARCHAR(100),
    pais VARCHAR(100)
);

-- Tabla de Tiendas
CREATE TABLE Tiendas (
    id_tienda INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tienda VARCHAR(100),
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    pais VARCHAR(100)
);

-- Tabla de Empleados
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empleado VARCHAR(100),
    puesto VARCHAR(100),
    tienda_id INT,
    fecha_contratacion DATE,
    FOREIGN KEY (tienda_id) REFERENCES Tiendas(id_tienda)
);

-- Tabla de Prendas de Ropa
CREATE TABLE Prendas (
    id_prenda INT AUTO_INCREMENT PRIMARY KEY,
    tipo_prenda VARCHAR(100),
    talla VARCHAR(10),
    color VARCHAR(50),
    precio DECIMAL(10, 2)
);

-- Tabla de Compras
CREATE TABLE Compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_compra DATE,
    monto_total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (nombre_cliente, email_cliente, ciudad, pais)
VALUES
('Carlos Ramírez', 'carlos.ramirez@email.com', 'Madrid', 'España'),
('Laura González', 'laura.gonzalez@email.com', 'Barcelona', 'España'),
('Andrés García', 'andres.garcia@email.com', 'Valencia', 'España'),
('Lucía Martínez', 'lucia.martinez@email.com', 'Sevilla', 'España'),
('Miguel Torres', 'miguel.torres@email.com', 'Zaragoza', 'España');

-- Insertar datos en la tabla Tiendas
INSERT INTO Tiendas (nombre_tienda, direccion, ciudad, pais)
VALUES
('Zara Gran Vía', 'Calle Gran Vía, 32', 'Madrid', 'España'),
('Zara Portal de l\'Àngel', 'Portal de l\'Àngel, 10', 'Barcelona', 'España'),
('Zara Calle de Colón', 'Calle de Colón, 20', 'Valencia', 'España'),
('Zara Calle Sierpes', 'Calle Sierpes, 40', 'Sevilla', 'España'),
('Zara Paseo de la Independencia', 'Paseo de la Independencia, 5', 'Zaragoza', 'España');

-- Insertar datos en la tabla Empleados
INSERT INTO Empleados (nombre_empleado, puesto, tienda_id, fecha_contratacion)
VALUES
('Juan Pérez', 'Vendedor', 1, '2022-01-10'),
('María López', 'Gerente', 2, '2021-11-15'),
('Carlos Fernández', 'Vendedor', 3, '2023-02-01'),
('Ana García', 'Encargada', 4, '2023-05-25'),
('Luis Martínez', 'Vendedor', 5, '2023-06-10');

-- Insertar datos en la tabla Prendas
INSERT INTO Prendas (tipo_prenda, talla, color, precio)
VALUES
('Camiseta', 'M', 'Negro', 19.99),
('Pantalón', 'L', 'Azul', 39.99),
('Chaqueta', 'S', 'Rojo', 59.99),
('Falda', 'M', 'Verde', 29.99),
('Zapatos', '42', 'Negro', 49.99),
('Vestido', 'L', 'Blanco', 59.99),
('Camisa', 'M', 'Azul', 29.99),
('Abrigo', 'L', 'Gris', 89.99),
('Shorts', 'S', 'Rosa', 24.99),
('Sudadera', 'XL', 'Negro', 34.99);

-- Insertar datos en la tabla Compras
INSERT INTO Compras (id_cliente, fecha_compra, monto_total)
VALUES
(1, '2023-04-01', 100.50),
(2, '2023-05-15', 59.99),
(3, '2023-06-20', 75.00),
(4, '2023-07-18', 120.00),
(5, '2023-08-10', 99.99),
(1, '2023-09-01', 200.00),
(2, '2023-09-10', 150.00),
(3, '2023-09-15', 50.00),
(4, '2023-09-20', 90.00),
(5, '2023-09-25', 30.00);


USE ZaraBusiness;

-- 1. Selecciona todos los clientes
SELECT * FROM Clientes;

-- 2. Selecciona todos los empleados
SELECT * FROM Empleados;

-- 3. Selecciona todas las tiendas
SELECT * FROM Tiendas;

-- 4. Selecciona todas las prendas de ropa
SELECT * FROM Prendas;

-- 5. Clientes cuyo nombre empieza con "L"
SELECT * FROM Clientes
WHERE nombre_cliente LIKE 'L%';

-- 6. Cuenta cuántos clientes hay
SELECT COUNT(*) AS total_clientes
FROM Clientes;

-- 7. Compras después del 1 de mayo de 2023
SELECT * FROM Compras
WHERE fecha_compra > '2023-05-01';

-- 8. Actualizar email de un cliente (ejemplo: id=1)
UPDATE Clientes
SET email_cliente = 'nuevo_correo@email.com'
WHERE id_cliente = 1;

-- 9. Eliminar cliente por ID (ejemplo: id=1)
DELETE FROM Clientes
WHERE id_cliente = 1;

-- 10. Prendas de color Negro
SELECT * FROM Prendas
WHERE color = 'Negro';

-- 11. Tiendas en Madrid
SELECT * FROM Tiendas
WHERE ciudad = 'Madrid';

-- 12. Prendas con precio > 50
SELECT COUNT(*) AS prendas_caras
FROM Prendas
WHERE precio > 50;

-- 13. Empleados en la tienda con ID=1
SELECT * FROM Empleados
WHERE tienda_id = 1;

-- 14. Clientes cuyo nombre contenga "Andrés"
SELECT * FROM Clientes
WHERE nombre_cliente LIKE '%Andrés%';

-- 15. Compras del cliente con ID=2
SELECT * FROM Compras
WHERE id_cliente = 2;

-- 16. Eliminar compras con monto < 30
DELETE FROM Compras
WHERE monto_total < 30;

-- 17. Prendas con precio entre 20 y 40
SELECT * FROM Prendas
WHERE precio BETWEEN 20 AND 40;

-- 18. Empleados cuyo nombre contenga "a"
SELECT * FROM Empleados
WHERE nombre_empleado LIKE '%a%';

-- 19. Las 5 prendas más caras
SELECT * FROM Prendas
ORDER BY precio DESC
LIMIT 5;

-- 20. Compras con monto > 75
SELECT * FROM Compras
WHERE monto_total > 75;

-- 21. Prendas de talla M
SELECT * FROM Prendas
WHERE talla = 'M';

-- 22. Actualizar talla de una prenda específica (ejemplo: id=1)
UPDATE Prendas
SET talla = 'XL'
WHERE id_prenda = 1;

-- 23. Empleados contratados después del 1 de enero de 2022
SELECT * FROM Empleados
WHERE fecha_contratacion > '2022-01-01';

-- 24. Tiendas en Barcelona
SELECT * FROM Tiendas
WHERE ciudad = 'Barcelona';

-- 25. Eliminar un empleado por su ID (ejemplo: id=5)
DELETE FROM Empleados
WHERE id_empleado = 5;

-- 26. Compras antes del 1 de julio de 2023
SELECT * FROM Compras
WHERE fecha_compra < '2023-07-01';

-- 27. Prendas cuyo nombre termine en "eta"
SELECT * FROM Prendas
WHERE tipo_prenda LIKE '%eta';

-- 28. Clientes que no tengan email con "hotmail"
SELECT * FROM Clientes
WHERE email_cliente NOT LIKE '%hotmail%';

-- 29. Número de compras en septiembre de 2023
SELECT COUNT(*) AS compras_septiembre
FROM Compras
WHERE MONTH(fecha_compra) = 9 AND YEAR(fecha_compra) = 2023;

-- 30. Actualizar dirección de una tienda por ID (ejemplo: id=2)
UPDATE Tiendas
SET direccion = 'Nueva Dirección 123'
WHERE id_tienda = 2;

-- 31. Prendas que sean camisetas
SELECT * FROM Prendas
WHERE tipo_prenda LIKE '%Camiseta%';

-- 32. Eliminar prendas con precio < 20
DELETE FROM Prendas
WHERE precio < 20;

-- 33. Todas las tiendas ordenadas por ciudad
SELECT * FROM Tiendas
ORDER BY ciudad;

-- 34. Empleados que sean vendedores
SELECT * FROM Empleados
WHERE puesto = 'Vendedor';

-- 35. Número de prendas de color blanco
SELECT COUNT(*) AS prendas_blancas
FROM Prendas
WHERE color = 'Blanco';

-- 36. Clientes con nombres de más de 10 caracteres
SELECT * FROM Clientes
WHERE LENGTH(nombre_cliente) > 10;

-- 37. Compras con monto entre 50 y 100
SELECT * FROM Compras
WHERE monto_total BETWEEN 50 AND 100;

-- 38. Las 3 compras más recientes
SELECT * FROM Compras
ORDER BY fecha_compra DESC
LIMIT 3;

-- Q39: Busca cursos cuyo nombre contenga la palabra "Digital"
SELECT * FROM Cursos
WHERE nombre_curso LIKE '%Digital%';

-- 40. Agrupar prendas por color y contar cuántas hay
SELECT color, COUNT(*) AS cantidad
FROM Prendas
GROUP BY color;

-- 41. Añadir dos tiendas en Madrid
INSERT INTO Tiendas (nombre_tienda, direccion, ciudad, pais)
VALUES ('Zara Centro', 'Calle Mayor 10', 'Madrid', 'España'),
       ('Zara Norte', 'Avenida Castellana 200', 'Madrid', 'España');

-- 42. Cambiar nombre de cliente Miguel Torres a Micaela + actualizar email
UPDATE Clientes
SET nombre_cliente = 'Micaela Torres',
    email_cliente = 'micaela.torres@email.com'
WHERE nombre_cliente = 'Miguel Torres';

