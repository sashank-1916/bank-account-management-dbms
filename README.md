
# Bank Account Management System

## Introduction

Banks handle a large volume of daily financial activity — account openings, deposits,
withdrawals, fund transfers, loan processing, and card issuance — all of which depend on
accurate, centralized data. Manual or file-based record-keeping is slow, error-prone, and
hard to scale across branches. This project addresses that by designing and implementing a
relational database that models core banking operations in a structured, rule-enforced way.

This is a DBMS capstone project for the course **Database Management Systems (DBMS)**,
built and documented by our team as part of the coursework at Aditya University.

## Description

The **Bank Account Management System** is a relational database that manages branches,
employees, customers, accounts, transactions, loans, cards, and nominees in a single,
normalized schema (up to 3NF). It supports core banking workflows such as opening
accounts, recording deposits/withdrawals/transfers, processing loans, and issuing cards,
while enforcing data integrity through primary keys, foreign keys, `NOT NULL`, `UNIQUE`,
and `CHECK` constraints.

The database is implemented in **MySQL**, with SQL scripts covering schema creation (DDL),
sample data (DML), and reporting queries (joins, aggregates, subqueries, and views) used
to answer real banking questions — e.g. branch-wise deposit totals, top customers by
balance, and active loan tracking.

## Repository Structure

```
bank-account-management-dbms/
├── sql/
│   ├── ddl.sql              # CREATE TABLE statements with keys & constraints
│   ├── dml.sql               # Sample INSERT/UPDATE/DELETE data
│   └── queries.sql           # CRUD, Joins, Aggregates, Subqueries, Views
├── diagrams/
│   └── er-diagram.png        # Entity-Relationship diagram
├── docs/
│   └── Bank_Account_Management_System_DBMS_Documentation.docx
├── screenshots/
│   ├── query1_output.png
│   └── query2_output.png
└── README.md
```

## Tools & Technologies

- Database: MySQL 8.0
- Query Tool: MySQL Workbench
- Version Control: GitHub

## Team & Contributions

| Student Name | Roll Number | Responsibility | Status |
|---|---|---|---|
| G.Manoj | 25B11AI385 | Designed ER diagram, identified entities/attributes, and normalized the schema up to 3NF | Completed |
| B.Harika | 25B11AI527 | Wrote DDL scripts — created tables with primary keys, foreign keys, and CHECK/UNIQUE/NOT NULL constraints | Completed |
| V.Pavithra | 25B11AI520 | Wrote DML scripts and sample data, implemented CRUD operations, Joins, Aggregate/GROUP BY queries, Subqueries, and Views | Completed |
| G.Sashank | 25B11AI316 | Set up the GitHub repository, tested all SQL scripts, took execution screenshots, and compiled the final project documentation | Completed |

## How to Run

1. Install MySQL and open MySQL Workbench.
2. Run `sql/ddl.sql` to create the database and tables.
3. Run `sql/dml.sql` to insert sample data.
4. Run queries from `sql/queries.sql` to test operations.
