CREATE DATABASE company_db;
USE company_db;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    city VARCHAR(50),
    joining_date DATE,
    status VARCHAR(20)
);
DESC employees;
SHOW TABLES;
INSERT INTO employees
-- TASK 6
VALUES (101, 'Rahul Patil', 'Development', 45000, 'Pune', '2026-01-10', 'Active');
SELECT * FROM employees;
-- TASK 7
INSERT INTO employees
VALUES (102, 'Priya Sharma', 'Testing', 38000, 'Mumbai', '2026-02-15', 'Active');

-- TASK 8
INSERT INTO employees
VALUES (103, 'Amit Joshi', 'Development', 52000, 'Pune', '2025-12-05', 'Active');

-- TASK 9
INSERT INTO employees
VALUES (104, 'Sneha Kulkarni', 'HR', 35000, 'Nashik', '2026-03-20', 'Active');

-- TASK 10
INSERT INTO employees
VALUES (105, 'Rohan Deshmukh', 'Support', 30000, 'Mumbai', '2026-04-01', 'Inactive');

-- TASK 11
INSERT INTO employees
VALUES (106, 'Anjali More', 'Testing', 42000, 'Pune', '2026-05-12', 'Active');



-- PART C - BASIC SELECT QUERIES


-- TASK 12
SELECT * FROM employees;

-- TASK 13
SELECT employee_name FROM employees;

-- TASK 14
SELECT employee_name, salary
FROM employees;

-- TASK 15
SELECT employee_name, department, city
FROM employees;

-- TASK 16
SELECT *
FROM employees
WHERE city = 'Pune';

-- TASK 17
SELECT *
FROM employees
WHERE city = 'Mumbai';

-- TASK 18
SELECT *
FROM employees
WHERE department = 'Development';

-- TASK 19
SELECT *
FROM employees
WHERE department = 'Testing';

-- TASK 20
SELECT *
FROM employees
WHERE status = 'Active';

-- TASK 21
SELECT *
FROM employees
WHERE status = 'Inactive';

-- TASK 22
SELECT *
FROM employees
WHERE employee_id = 103;

-- TASK 23
SELECT *
FROM employees
WHERE employee_name = 'Priya Sharma';

-- TASK 24
SELECT *
FROM employees
WHERE salary > 40000;

-- TASK 25
SELECT *
FROM employees
WHERE salary < 40000;

-- TASK 26
SELECT *
FROM employees
WHERE salary = 35000;

-- TASK 27
SELECT *
FROM employees
WHERE salary >= 42000;

-- TASK 28
SELECT *
FROM employees
WHERE city = 'Pune'
AND status = 'Active';

-- TASK 29
SELECT *
FROM employees
WHERE department = 'Development'
AND salary > 45000;

-- TASK 30
SELECT *
FROM employees
WHERE city = 'Pune'
OR city = 'Mumbai';



-- PART D - UPDATE OPERATIONS

SET SQL_SAFE_UPDATES = 0;
-- TASK 31
UPDATE employees
SET salary = 48000
WHERE employee_name = 'Rahul Patil';

-- TASK 32
UPDATE employees
SET status = 'Active'
WHERE employee_name = 'Rohan Deshmukh';

-- TASK 33
UPDATE employees
SET city = 'Pune'
WHERE employee_name = 'Sneha Kulkarni';

-- TASK 34
UPDATE employees
SET department = 'Development'
WHERE employee_name = 'Priya Sharma';

-- TASK 35
UPDATE employees
SET salary = 45000
WHERE employee_id = 106;

-- TASK 36
UPDATE employees
SET salary = salary + 3000
WHERE employee_id = 103;

-- TASK 37
UPDATE employees
SET salary = salary + 2000
WHERE department = 'Testing';

-- TASK 38
UPDATE employees
SET city = 'Mumbai Branch'
WHERE city = 'Mumbai';



-- PART E - DELETE OPERATIONS


-- TASK 39
DELETE FROM employees
WHERE employee_id = 105;

-- TASK 40
DELETE FROM employees
WHERE employee_name = 'Rohan Deshmukh';

-- TASK 41
DELETE FROM employees
WHERE status = 'Inactive';

-- TASK 42
DELETE FROM employees
WHERE salary < 30000;

-- TASK 43
DELETE FROM employees
WHERE employee_id = 104;



-- PART F - ALTER TABLE / DDL


-- TASK 44
ALTER TABLE employees
ADD COLUMN email VARCHAR(100);

-- TASK 45
ALTER TABLE employees
ADD COLUMN mobile VARCHAR(15);

-- TASK 46
ALTER TABLE employees
MODIFY COLUMN city VARCHAR(100);

-- TASK 47
ALTER TABLE employees
RENAME COLUMN employee_name TO name;

-- TASK 48
ALTER TABLE employees
DROP COLUMN mobile;

-- TASK 49
ALTER TABLE employees
ADD COLUMN experience INT;

-- TASK 50
UPDATE employees
SET experience = 2
WHERE employee_id = 101;



-- PART G - DEPARTMENTS TABLE


-- TASK 51
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

-- TASK 52
INSERT INTO departments
VALUES
(1, 'Development', 'Pune'),
(2, 'Testing', 'Mumbai'),
(3, 'HR', 'Nashik');

-- TASK 53
SELECT * FROM departments;

-- TASK 54
UPDATE departments
SET location = 'Pune'
WHERE department_id = 2;

-- TASK 55
DELETE FROM departments
WHERE department_id = 3;

-- TASK 56
RENAME TABLE departments TO company_departments;

-- TASK 57
DESC company_departments;

-- TASK 58
TRUNCATE TABLE company_departments;

-- TASK 59
DROP TABLE company_departments;

-- TASK 60
SHOW TABLES;
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM employees;