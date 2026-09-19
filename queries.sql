-- =====================================================
-- Bank Account Management System
-- Queries Script: CRUD, Joins, Aggregates, Subqueries, Views
-- =====================================================

USE bank_management;

-- =====================================================
-- 1. BASIC CRUD OPERATIONS
-- =====================================================

-- CREATE: add a new customer
INSERT INTO Customer (Name, Aadhar_No, Phone, Email, Address, DOB)
VALUES ('Neha Kapoor', '789012345678', '9876556789', 'neha@mail.com', 'Pune', '1993-04-22');

-- READ: list all savings accounts
SELECT * FROM Account WHERE Account_Type = 'Savings';

-- UPDATE: apply 3% interest to all savings accounts
UPDATE Account SET Balance = Balance * 1.03 WHERE Account_Type = 'Savings';

-- DELETE: remove accounts with zero balance
DELETE FROM Account WHERE Balance = 0;


-- =====================================================
-- 2. JOIN QUERIES
-- =====================================================

-- 2.1 Show each account with the owning customer's name
SELECT a.Account_No, c.Name AS Customer_Name, a.Account_Type, a.Balance
FROM Account a
JOIN Customer c ON a.Customer_ID = c.Customer_ID;

-- 2.2 Multi-table join: list loans with customer and branch names
SELECT c.Name AS Customer_Name, br.Branch_Name, l.Loan_Type, l.Principal_Amount, l.Status
FROM Loan l
JOIN Account a  ON l.Account_No = a.Account_No
JOIN Customer c ON a.Customer_ID = c.Customer_ID
JOIN Branch br  ON a.Branch_ID = br.Branch_ID;

-- 2.3 List all transactions with customer name and branch
SELECT t.Transaction_ID, c.Name AS Customer_Name, br.Branch_Name, t.Txn_Type, t.Amount, t.Txn_Date
FROM Transaction_Log t
JOIN Account a  ON t.Account_No = a.Account_No
JOIN Customer c ON a.Customer_ID = c.Customer_ID
JOIN Branch br  ON a.Branch_ID = br.Branch_ID
ORDER BY t.Txn_Date DESC;


-- =====================================================
-- 3. AGGREGATE FUNCTIONS & GROUP BY
-- =====================================================

-- 3.1 Total deposits (sum of balances) per branch
SELECT br.Branch_Name, SUM(a.Balance) AS Total_Deposits
FROM Account a
JOIN Branch br ON a.Branch_ID = br.Branch_ID
GROUP BY br.Branch_Name;

-- 3.2 Branches with total balance above 50,000 (HAVING clause)
SELECT br.Branch_Name, SUM(a.Balance) AS Total_Balance
FROM Account a
JOIN Branch br ON a.Branch_ID = br.Branch_ID
GROUP BY br.Branch_Name
HAVING Total_Balance > 50000;

-- 3.3 Count of accounts per account type
SELECT Account_Type, COUNT(*) AS Number_Of_Accounts
FROM Account
GROUP BY Account_Type;

-- 3.4 Average loan amount per loan type
SELECT Loan_Type, AVG(Principal_Amount) AS Avg_Loan_Amount
FROM Loan
GROUP BY Loan_Type;


-- =====================================================
-- 4. SUBQUERIES
-- =====================================================

-- 4.1 Customers whose account balance is above the average balance
SELECT DISTINCT c.Name
FROM Customer c
JOIN Account a ON c.Customer_ID = a.Customer_ID
WHERE a.Balance > (SELECT AVG(Balance) FROM Account);

-- 4.2 Accounts that have taken a loan (correlated subquery)
SELECT a.Account_No, c.Name
FROM Account a
JOIN Customer c ON a.Customer_ID = c.Customer_ID
WHERE EXISTS (
    SELECT 1 FROM Loan l WHERE l.Account_No = a.Account_No
);

-- 4.3 Customers who have NOT taken any loan
SELECT c.Name
FROM Customer c
WHERE c.Customer_ID NOT IN (
    SELECT a.Customer_ID FROM Account a
    JOIN Loan l ON a.Account_No = l.Account_No
);


-- =====================================================
-- 5. VIEWS
-- =====================================================

-- 5.1 View of all active loans
CREATE OR REPLACE VIEW Active_Loans AS
SELECT l.Loan_ID, c.Name AS Customer_Name, l.Loan_Type, l.Principal_Amount, l.Interest_Rate
FROM Loan l
JOIN Account a  ON l.Account_No = a.Account_No
JOIN Customer c ON a.Customer_ID = c.Customer_ID
WHERE l.Status = 'Active';

-- Query the view
SELECT * FROM Active_Loans;

-- 5.2 View of branch-wise deposit summary
CREATE OR REPLACE VIEW Branch_Deposit_Summary AS
SELECT br.Branch_Name, COUNT(a.Account_No) AS Total_Accounts, SUM(a.Balance) AS Total_Deposits
FROM Account a
JOIN Branch br ON a.Branch_ID = br.Branch_ID
GROUP BY br.Branch_Name;

-- Query the view
SELECT * FROM Branch_Deposit_Summary;


-- =====================================================
-- 6. ORDER BY / LIMIT / RANKING
-- =====================================================

-- 6.1 Top 5 customers by account balance
SELECT c.Name, a.Balance
FROM Account a
JOIN Customer c ON a.Customer_ID = c.Customer_ID
ORDER BY a.Balance DESC
LIMIT 5;

-- 6.2 Most recent 10 transactions
SELECT * FROM Transaction_Log
ORDER BY Txn_Date DESC
LIMIT 10;


-- =====================================================
-- 7. MISCELLANEOUS / REPORTING QUERIES
-- =====================================================

-- 7.1 Overdue loans report
SELECT c.Name, l.Loan_Type, l.Principal_Amount, l.Status
FROM Loan l
JOIN Account a  ON l.Account_No = a.Account_No
JOIN Customer c ON a.Customer_ID = c.Customer_ID
WHERE l.Status = 'Overdue';

-- 7.2 Customers holding more than one account
SELECT c.Name, COUNT(a.Account_No) AS Num_Accounts
FROM Customer c
JOIN Account a ON c.Customer_ID = a.Customer_ID
GROUP BY c.Name
HAVING Num_Accounts > 1;

-- 7.3 Total transaction volume (deposits vs withdrawals)
SELECT Txn_Type, SUM(Amount) AS Total_Amount, COUNT(*) AS Txn_Count
FROM Transaction_Log
GROUP BY Txn_Type;
