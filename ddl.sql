-- =====================================================
-- Bank Account Management System
-- DDL Script: Database and Table Creation
-- =====================================================

CREATE DATABASE IF NOT EXISTS bank_management;
USE bank_management;

-- ---------------------------------------------------
-- Table: Branch
-- ---------------------------------------------------
CREATE TABLE Branch (
    Branch_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Branch_Name VARCHAR(50) NOT NULL,
    City        VARCHAR(30) NOT NULL,
    IFSC_Code   CHAR(11) UNIQUE NOT NULL
);

-- ---------------------------------------------------
-- Table: Employee
-- ---------------------------------------------------
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    Branch_ID   INT NOT NULL,
    Name        VARCHAR(50) NOT NULL,
    Designation VARCHAR(30) NOT NULL,
    Phone       VARCHAR(15),
    Salary      DECIMAL(10,2) CHECK (Salary > 0),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID)
        ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Table: Customer
-- ---------------------------------------------------
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name        VARCHAR(50) NOT NULL,
    Aadhar_No   CHAR(12) UNIQUE NOT NULL,
    Phone       VARCHAR(15) NOT NULL,
    Email       VARCHAR(50) UNIQUE,
    Address     VARCHAR(100),
    DOB         DATE
);

-- ---------------------------------------------------
-- Table: Account
-- ---------------------------------------------------
CREATE TABLE Account (
    Account_No   INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID  INT NOT NULL,
    Branch_ID    INT NOT NULL,
    Account_Type VARCHAR(15) NOT NULL CHECK (Account_Type IN ('Savings','Current')),
    Balance      DECIMAL(12,2) DEFAULT 0 CHECK (Balance >= 0),
    Open_Date    DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID)
);

-- ---------------------------------------------------
-- Table: Transaction_Log
-- ---------------------------------------------------
CREATE TABLE Transaction_Log (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Account_No     INT NOT NULL,
    Txn_Type       VARCHAR(10) NOT NULL CHECK (Txn_Type IN ('Deposit','Withdrawal','Transfer')),
    Amount         DECIMAL(12,2) NOT NULL CHECK (Amount > 0),
    Txn_Date       DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Account_No) REFERENCES Account(Account_No)
        ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Table: Loan
-- ---------------------------------------------------
CREATE TABLE Loan (
    Loan_ID          INT PRIMARY KEY AUTO_INCREMENT,
    Account_No       INT NOT NULL,
    Loan_Type        VARCHAR(20) NOT NULL,
    Principal_Amount DECIMAL(12,2) NOT NULL CHECK (Principal_Amount > 0),
    Interest_Rate    DECIMAL(4,2) NOT NULL,
    Status           VARCHAR(15) DEFAULT 'Active' CHECK (Status IN ('Active','Closed','Overdue')),
    FOREIGN KEY (Account_No) REFERENCES Account(Account_No)
        ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Table: Card
-- ---------------------------------------------------
CREATE TABLE Card (
    Card_No     CHAR(16) PRIMARY KEY,
    Account_No  INT NOT NULL,
    Card_Type   VARCHAR(10) NOT NULL CHECK (Card_Type IN ('Debit','Credit')),
    Expiry_Date DATE NOT NULL,
    FOREIGN KEY (Account_No) REFERENCES Account(Account_No)
        ON DELETE CASCADE
);
