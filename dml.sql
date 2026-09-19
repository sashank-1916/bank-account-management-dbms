-- =====================================================
-- Bank Account Management System
-- DML Script: Sample Data Insertion
-- =====================================================

USE bank_management;

-- ---------------------------------------------------
-- Branch
-- ---------------------------------------------------
INSERT INTO Branch (Branch_Name, City, IFSC_Code) VALUES
('MG Road Branch',    'Bengaluru',   'BANK0001234'),
('Anna Nagar Branch', 'Chennai',     'BANK0005678'),
('Banjara Hills Branch', 'Hyderabad','BANK0009012');

-- ---------------------------------------------------
-- Employee
-- ---------------------------------------------------
INSERT INTO Employee (Branch_ID, Name, Designation, Phone, Salary) VALUES
(1, 'Suresh Nair',    'Branch Manager', '9000011111', 65000.00),
(1, 'Priya Menon',    'Loan Officer',   '9000022222', 42000.00),
(2, 'Karthik Raja',   'Teller',         '9000033333', 30000.00),
(2, 'Divya Shankar',  'Branch Manager', '9000044444', 68000.00),
(3, 'Mohammed Faizan','Teller',         '9000055555', 29000.00);

-- ---------------------------------------------------
-- Customer
-- ---------------------------------------------------
INSERT INTO Customer (Name, Aadhar_No, Phone, Email, Address, DOB) VALUES
('Ravi Kumar',    '123456789012', '9876543210', 'ravi@mail.com',    'Bengaluru', '1990-05-12'),
('Anitha Reddy',  '234567890123', '9876501234', 'anitha@mail.com',  'Chennai',   '1988-11-23'),
('Farhan Ahmed',  '345678901234', '9876512345', 'farhan@mail.com',  'Hyderabad', '1995-02-14'),
('Meera Iyer',    '456789012345', '9876523456', 'meera@mail.com',   'Bengaluru', '1992-07-30'),
('Vikram Singh',  '567890123456', '9876534567', 'vikram@mail.com',  'Chennai',   '1985-09-18'),
('Sneha Pillai',  '678901234567', '9876545678', 'sneha@mail.com',   'Hyderabad', '1998-01-05');

-- ---------------------------------------------------
-- Account
-- ---------------------------------------------------
INSERT INTO Account (Customer_ID, Branch_ID, Account_Type, Balance, Open_Date) VALUES
(1, 1, 'Savings', 25000.00, '2022-01-10'),
(2, 2, 'Current', 50000.00, '2022-02-15'),
(3, 3, 'Savings', 12000.00, '2022-03-20'),
(4, 1, 'Savings', 80000.00, '2021-11-05'),
(5, 2, 'Current', 15000.00, '2023-01-18'),
(6, 3, 'Savings', 5000.00,  '2023-06-02'),
(1, 2, 'Current', 30000.00, '2023-08-14'),
(4, 3, 'Savings', 42000.00, '2022-09-09');

-- ---------------------------------------------------
-- Transaction_Log
-- ---------------------------------------------------
INSERT INTO Transaction_Log (Account_No, Txn_Type, Amount) VALUES
(1, 'Deposit',    5000.00),
(1, 'Withdrawal', 2000.00),
(2, 'Deposit',    10000.00),
(3, 'Deposit',    3000.00),
(3, 'Withdrawal', 1000.00),
(4, 'Deposit',    20000.00),
(4, 'Withdrawal', 5000.00),
(5, 'Deposit',    7000.00),
(6, 'Deposit',    2000.00),
(7, 'Deposit',    15000.00),
(7, 'Withdrawal', 3000.00),
(8, 'Deposit',    10000.00),
(2, 'Withdrawal', 4000.00),
(5, 'Withdrawal', 1500.00),
(8, 'Withdrawal', 2000.00);

-- ---------------------------------------------------
-- Loan
-- ---------------------------------------------------
INSERT INTO Loan (Account_No, Loan_Type, Principal_Amount, Interest_Rate, Status) VALUES
(1, 'Personal', 100000.00, 10.50, 'Active'),
(2, 'Home',     2500000.00, 7.25, 'Active'),
(4, 'Vehicle',  500000.00,  9.00, 'Closed'),
(5, 'Personal', 75000.00,  11.00, 'Overdue');

-- ---------------------------------------------------
-- Card
-- ---------------------------------------------------
INSERT INTO Card (Card_No, Account_No, Card_Type, Expiry_Date) VALUES
('4111111111111111', 1, 'Debit',  '2027-05-31'),
('4222222222222222', 2, 'Credit', '2026-11-30'),
('4333333333333333', 3, 'Debit',  '2028-03-31'),
('4444444444444444', 4, 'Debit',  '2027-09-30'),
('4555555555555555', 7, 'Credit', '2026-12-31');

-- ---------------------------------------------------
-- Sample updates / deletes (demonstrating operations)
-- ---------------------------------------------------

-- Deposit example: credit account 1 with 5000
UPDATE Account SET Balance = Balance + 5000 WHERE Account_No = 1;
INSERT INTO Transaction_Log (Account_No, Txn_Type, Amount) VALUES (1, 'Deposit', 5000);

-- Withdrawal example: debit account 1 with 2000
UPDATE Account SET Balance = Balance - 2000 WHERE Account_No = 1;
INSERT INTO Transaction_Log (Account_No, Txn_Type, Amount) VALUES (1, 'Withdrawal', 2000);

-- Delete example: remove a closed loan record (if needed for demo)
DELETE FROM Loan WHERE Loan_ID = 3;
