# Challenge 4 - Finance Analysis

## Intro
As a Finance Analyst for 'The Big Bank', I have been tasked with finding out about our customers and their banking behavior. I will examine the accounts they hold and the type of transactions they make to develop greater insight into our customers.

![Case Study Theme](image_file_path.png)
<!-- Insert an image that accurately captures this case study theme -->

## Tables
Here are the tables I will be using:

![Image 1](https://steeldata.org.uk/SQL4tables.png)


Table Creation:
```sql
-- Create the Customers table
CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(2) NOT NULL
);
--------------------
-- Populate the Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, City, State)
VALUES (1, 'John', 'Doe', 'New York', 'NY'),
(2, 'Jane', 'Doe', 'New York', 'NY'),
(3, 'Bob', 'Smith', 'San Francisco', 'CA'),
(4, 'Alice', 'Johnson', 'San Francisco', 'CA'),
(5, 'Michael', 'Lee', 'Los Angeles', 'CA'),
(6, 'Jennifer', 'Wang', 'Los Angeles', 'CA');
--------------------
-- Create the Branches table
CREATE TABLE Branches (
BranchID INT PRIMARY KEY,
BranchName VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(2) NOT NULL
);
--------------------
-- Populate the Branches table
INSERT INTO Branches (BranchID, BranchName, City, State)
VALUES (1, 'Main', 'New York', 'NY'),
(2, 'Downtown', 'San Francisco', 'CA'),
(3, 'West LA', 'Los Angeles', 'CA'),
(4, 'East LA', 'Los Angeles', 'CA'),
(5, 'Uptown', 'New York', 'NY'),
(6, 'Financial District', 'San Francisco', 'CA'),
(7, 'Midtown', 'New York', 'NY'),
(8, 'South Bay', 'San Francisco', 'CA'),
(9, 'Downtown', 'Los Angeles', 'CA'),
(10, 'Chinatown', 'New York', 'NY'),
(11, 'Marina', 'San Francisco', 'CA'),
(12, 'Beverly Hills', 'Los Angeles', 'CA'),
(13, 'Brooklyn', 'New York', 'NY'),
(14, 'North Beach', 'San Francisco', 'CA'),
(15, 'Pasadena', 'Los Angeles', 'CA');
--------------------
-- Create the Accounts table
CREATE TABLE Accounts (
AccountID INT PRIMARY KEY,
CustomerID INT NOT NULL,
BranchID INT NOT NULL,
AccountType VARCHAR(50) NOT NULL,
Balance DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);
--------------------
-- Populate the Accounts table
INSERT INTO Accounts (AccountID, CustomerID, BranchID, AccountType, Balance)
VALUES (1, 1, 5, 'Checking', 1000.00),
(2, 1, 5, 'Savings', 5000.00),
(3, 2, 1, 'Checking', 2500.00),
(4, 2, 1, 'Savings', 10000.00),
(5, 3, 2, 'Checking', 7500.00),
(6, 3, 2, 'Savings', 15000.00),
(7, 4, 8, 'Checking', 5000.00),
(8, 4, 8, 'Savings', 20000.00),
(9, 5, 14, 'Checking', 10000.00),
(10, 5, 14, 'Savings', 50000.00),
(11, 6, 2, 'Checking', 5000.00),
(12, 6, 2, 'Savings', 10000.00),
(13, 1, 5, 'Credit Card', -500.00),
(14, 2, 1, 'Credit Card', -1000.00),
(15, 3, 2, 'Credit Card', -2000.00);
--------------------
-- Create the Transactions table
CREATE TABLE Transactions (
TransactionID INT PRIMARY KEY,
AccountID INT NOT NULL,
TransactionDate DATE NOT NULL,
Amount DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
--------------------
-- Populate the Transactions table
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount)
VALUES (1, 1, '2022-01-01', -500.00),
(2, 1, '2022-01-02', -250.00),
(3, 2, '2022-01-03', 1000.00),
(4, 3, '2022-01-04', -1000.00),
(5, 3, '2022-01-05', 500.00),
(6, 4, '2022-01-06', 1000.00),
(7, 4, '2022-01-07', -500.00),
(8, 5, '2022-01-08', -2500.00),
(9, 6, '2022-01-09', 500.00),
(10, 6, '2022-01-10', -1000.00),
(11, 7, '2022-01-11', -500.00),
(12, 7, '2022-01-12', -250.00),
(13, 8, '2022-01-13', 1000.00),
(14, 8, '2022-01-14', -1000.00),
(15, 9, '2022-01-15', 500.00);
```

## Ad-Hoc Questions and Solutions
### 1. What are the names of all the customers who live in New York?
 
 ```sql
SELECT FirstName,
       LastName
FROM Customers
WHERE City = 'New York';
 ```

### 2. What is the total number of accounts in the Accounts table?
 ``` sql
 SELECT COUNT(*) AS TotalAccounts
 FROM Accounts;
 ```

### 3. What is the total balance of all checking accounts?

``` sql
SELECT SUM(Balance) AS TotalCheckingBalance
FROM Accounts
WHERE AccountType = 'Checking';

```
### 4. What is the total balance of all accounts associated with customers who live in Los Angeles?

``` sql
SELECT SUM(Balance) AS TotalBalanceLosAngeles
FROM Accounts
JOIN Customers ON Accounts.CustomerID = Customers.CustomerID
WHERE Customers.City = 'Los Angeles';
 ```
### 5. Which branch has the highest average account balance?

``` sql
SELECT Branches.BranchName, 
       ROUND(AVG(Accounts.Balance),2) AS AvgBalance
FROM Branches
JOIN Accounts ON Branches.BranchID = Accounts.BranchID
GROUP BY Branches.BranchName
ORDER BY AvgBalance DESC
LIMIT 1;
```
### 6. Which customer has the highest current balance in their accounts?

``` sql
SELECT Customers.FirstName,
      Customers.LastName, 
      MAX(Accounts.Balance) AS MaxBalance
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID
GROUP BY Customers.FirstName, Customers.LastName
ORDER BY MaxBalance DESC
LIMIT 1;

 ```
### 7. Which customer has made the most transactions in the Transactions table?

``` sql
SELECT Customers.FirstName, 
       Customers.LastName,
       COUNT(Transactions.TransactionID) AS TotalTransactions
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID
JOIN Transactions ON Accounts.AccountID = Transactions.AccountID
GROUP BY Customers.FirstName, Customers.LastName
ORDER BY TotalTransactions DESC
LIMIT 1;
 ```
### 8. Which branch has the highest total balance across all of its accounts?

 ``` sql
SELECT Branches.BranchName,
       SUM(Accounts.Balance) AS TotalBranchBalance
FROM Branches
JOIN Accounts ON Branches.BranchID = Accounts.BranchID
GROUP BY Branches.BranchName
ORDER BY TotalBranchBalance DESC
LIMIT 1;
 ```
 
### 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?

``` sql
SELECT Customers.FirstName,
       Customers.LastName,
       SUM(Accounts.Balance) AS TotalBalance
FROM Customers
JOIN Accounts ON Customers.CustomerID = Accounts.CustomerID
GROUP BY Customers.FirstName, Customers.LastName
ORDER BY TotalBalance DESC
LIMIT 1;
 ```

### 10. Which branch has the highest number of transactions in the Transactions table?

 ``` sql
SELECT Branches.BranchName,
       COUNT(Transactions.TransactionID) AS TotalTransactions
FROM Branches
JOIN Accounts ON Branches.BranchID = Accounts.BranchID
JOIN Transactions ON Accounts.AccountID = Transactions.AccountID
GROUP BY Branches.BranchName
ORDER BY TotalTransactions DESC
LIMIT 1;
 ```
