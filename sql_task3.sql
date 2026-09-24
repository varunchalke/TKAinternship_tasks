CREATE DATABASE banking_db;
USE banking_db;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_number VARCHAR(20),
    customer_name VARCHAR(100),
    account_type VARCHAR(30),
    branch VARCHAR(50),
    city VARCHAR(50),
    balance DECIMAL(12,2),
    credit_score INT,
    status VARCHAR(20),
    opened_date DATE
);

DESC accounts;
SHOW TABLES;

INSERT INTO accounts VALUES (1001,'ACC10001','Aarav Sharma','Savings','FC Road','Pune',85000,780,'Active','2025-01-15');
INSERT INTO accounts VALUES (1002,'ACC10002','Priya Patil','Current','Andheri','Mumbai',145000,810,'Active','2024-11-20');
INSERT INTO accounts VALUES (1003,'ACC10003','Rohan Joshi','Savings','Baner','Pune',42000,735,'Active','2026-02-10');
INSERT INTO accounts VALUES (1004,'ACC10004','Sneha Kulkarni','Salary','Nashik Road','Nashik',67000,760,'Active','2025-08-05');
INSERT INTO accounts VALUES (1005,'ACC10005','Vikram Deshmukh','Savings','Camp','Pune',18500,690,'Dormant','2023-06-18');
INSERT INTO accounts VALUES (1006,'ACC10006','Neha More','Current','Thane','Mumbai',225000,825,'Active','2024-03-12');

SELECT * FROM accounts;

SELECT customer_name, account_number FROM accounts;

SELECT customer_name, account_type, balance, status FROM accounts;

SELECT * FROM accounts WHERE account_type = 'Savings';

SELECT * FROM accounts WHERE city = 'Pune';

SELECT * FROM accounts WHERE balance > 50000;

SELECT * FROM accounts WHERE balance <= 50000;

SELECT * FROM accounts WHERE balance BETWEEN 50000 AND 200000;

SELECT * FROM accounts WHERE credit_score >= 750;

SELECT * FROM accounts WHERE status = 'Active';

SELECT * FROM accounts WHERE status IN ('Dormant','Closed');

SELECT * FROM accounts WHERE city = 'Pune' AND status = 'Active';

SELECT * FROM accounts WHERE city IN ('Mumbai','Nashik');

SELECT * FROM accounts WHERE account_type IN ('Savings','Salary');

SELECT * FROM accounts WHERE balance NOT BETWEEN 25000 AND 100000;

SELECT * FROM accounts WHERE customer_name LIKE 'A%';

SELECT * FROM accounts WHERE customer_name LIKE '%a';

SELECT * FROM accounts WHERE branch LIKE '%Road%';

SELECT * FROM accounts ORDER BY balance DESC LIMIT 3;

SELECT * FROM accounts LIMIT 5;

SELECT * FROM accounts LIMIT 3,3;

SELECT * FROM accounts WHERE city = 'Pune' AND status = 'Active' AND account_type = 'Savings' AND balance > 50000;

SELECT * FROM accounts WHERE city IN ('Pune','Mumbai','Nashik') AND credit_score >= 750;

SELECT * FROM accounts WHERE balance > 100000 AND credit_score >= 800;

SELECT * FROM accounts WHERE balance BETWEEN 50000 AND 150000 OR credit_score > 800;

SELECT * FROM accounts WHERE status = 'Active' AND account_type <> 'Current';

SELECT * FROM accounts WHERE customer_name LIKE '%ar%';

UPDATE accounts
SET balance = 95000
WHERE customer_name = 'Aarav Sharma';

UPDATE accounts
SET status = 'Active'
WHERE customer_name = 'Vikram Deshmukh';

UPDATE accounts
SET credit_score = 755
WHERE customer_name = 'Rohan Joshi';

UPDATE accounts
SET branch = 'College Road'
WHERE customer_name = 'Sneha Kulkarni';

UPDATE accounts
SET account_type = 'Premium Current'
WHERE customer_name = 'Priya Patil';

UPDATE accounts
SET balance = balance + 25000
WHERE account_id = 1006;

UPDATE accounts
SET balance = balance + 5000
WHERE account_type = 'Savings';

UPDATE accounts
SET city = 'Pune City'
WHERE city = 'Pune';

UPDATE accounts
SET credit_score = credit_score + 10
WHERE status = 'Active' AND credit_score < 750;

UPDATE accounts
SET status = 'Dormant'
WHERE balance < 20000;

DELETE FROM accounts
WHERE account_id = 1005;

DELETE FROM accounts
WHERE account_number = 'ACC10004';

DELETE FROM accounts
WHERE status = 'Closed';

DELETE FROM accounts
WHERE balance < 10000 OR credit_score < 600;

DELETE FROM accounts
WHERE city = 'Pune City' AND status = 'Dormant';

ALTER TABLE accounts
ADD COLUMN email VARCHAR(100);

ALTER TABLE accounts
ADD COLUMN mobile VARCHAR(15);

ALTER TABLE accounts
MODIFY COLUMN branch VARCHAR(100);

ALTER TABLE accounts
RENAME COLUMN customer_name TO name;

ALTER TABLE accounts
DROP COLUMN mobile;

ALTER TABLE accounts
ADD COLUMN account_category VARCHAR(30);

UPDATE accounts
SET account_category = 'Premium'
WHERE account_id = 1001;

UPDATE accounts
SET account_category = 'Regular'
WHERE account_id = 1002;

RENAME TABLE accounts TO bank_accounts;

DESC bank_accounts;

TRUNCATE TABLE bank_accounts;

DROP TABLE bank_accounts;