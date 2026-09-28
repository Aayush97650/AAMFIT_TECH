CREATE DATABASE FinoraAccountingDB;
USE FinoraAccountingDB;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Audit'),
(2, 'Tax'),
(3, 'Accounting'),
(4, 'Consulting'),
(5, 'Finance'),
(6, 'Human Resources');
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    JobTitle VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE,
    
    CONSTRAINT FK_Employee_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
);





INSERT INTO Employees
(EmployeeID, EmployeeName, Email, DepartmentID, JobTitle, Salary, HireDate)
VALUES
(101, 'JAY Sharma', 'rahul@finora.com', 1, 'Audit Manager', 85000, '2022-04-10'),
(102, 'AMAN Patel', 'priya@finora.com', 2, 'Tax Consultant', 72000, '2023-01-15'),
(103, 'Amit Joshi', 'amit@finora.com', 3, 'Accountant', 58000, '2024-02-20'),
(104, 'Sneha Shah', 'sneha@finora.com', 4, 'Business Consultant', 90000, '2021-06-12'),
(105, 'Arjun Mehta', 'arjun@finora.com', 1, 'Senior Auditor', 68000, '2023-11-05'),
(106, 'Neha Verma', 'neha@finora.com', 5, 'Financial Analyst', 75000, '2022-09-18'),
(107, 'Karan Singh', 'karan@finora.com', 6, 'HR Executive', 55000, '2024-05-10'),
(108, 'Pooja Desai', 'pooja@finora.com', 3, 'Senior Accountant', 70000, '2022-12-01');


CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    ClientName VARCHAR(100) NOT NULL,
    Industry VARCHAR(50),
    City VARCHAR(50)
); 

INSERT INTO Clients
(ClientID, ClientName, Industry, City)
VALUES
(201, 'TechNova Pvt Ltd', 'Technology', 'Mumbai'),
(202, 'GreenFoods Ltd', 'Food', 'Pune'),
(203, 'MetroBuild Ltd', 'Construction', 'Delhi'),
(204, 'HealthPlus Pvt Ltd', 'Healthcare', 'Mumbai'),
(205, 'SmartRetail Ltd', 'Retail', 'Bangalore');

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    ClientID INT,
    DepartmentID INT,
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(12,2),

    FOREIGN KEY (ClientID)
    REFERENCES Clients(ClientID),

    FOREIGN KEY (DepartmentID)
    REFERENCES Departments(DepartmentID)
);




INSERT INTO Projects
(ProjectID, ProjectName, ClientID, DepartmentID, StartDate, EndDate, Budget)
VALUES
(301, 'Annual Audit 2026', 201, 1, '2026-01-10', '2026-03-30', 150000),
(302, 'Tax Compliance 2026', 202, 2, '2026-02-01', '2026-04-15', 100000),
(303, 'Financial Reporting', 203, 3, '2026-03-01', '2026-05-30', 120000),
(304, 'Business Strategy', 204, 4, '2026-04-10', '2026-07-15', 200000),
(305, 'Financial Planning', 205, 5, '2026-05-01', '2026-08-30', 180000);


SHOW TABLES;
USE FinoraAccountingDB;
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Clients;
SELECT * FROM Projects;

SELECT
    e.EmployeeID,
    e.EmployeeName,
    e.JobTitle,
    d.DepartmentName,
    e.Salary
FROM Employees AS e
INNER JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID;

SELECT
    p.ProjectName,
    c.ClientName,
    d.DepartmentName,
    p.Budget
FROM Projects p
JOIN Clients c
ON p.ClientID = c.ClientID
JOIN Departments d
ON p.DepartmentID = d.DepartmentID;

SELECT *
FROM Employees
WHERE Salary > 70000;
SELECT
    EmployeeName,
    JobTitle,
    Salary
FROM Employees
ORDER BY Salary DESC;

SELECT COUNT(*) AS TotalEmployees
FROM Employees;

SELECT AVG(Salary) AS AverageSalary
FROM Employees;



SELECT
    d.DepartmentName,
    AVG(e.Salary) AS AverageSalary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName; 

USE FinoraAccountingDB;

SELECT
    d.DepartmentName,
    AVG(e.Salary) AS AverageSalary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING AVG(e.Salary) >= 70000;


USE FinoraAccountingDB;

SELECT
    EmployeeName,
    Salary,
    CASE
        WHEN Salary >= 80000 THEN 'High'
        WHEN Salary >= 60000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;


USE FinoraAccountingDB;

SELECT
    EmployeeName,
    Salary,
    IF(Salary >= 70000, 'Good Salary', 'Below 70000') AS SalaryStatus
FROM Employees;


USE FinoraAccountingDB;

SELECT
    EmployeeName,
    Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);

USE FinoraAccountingDB;

CREATE VIEW EmployeeDepartmentView AS
SELECT
    e.EmployeeID,
    e.EmployeeName,
    e.JobTitle,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID;


UPDATE Employees
SET Salary = 75000
WHERE EmployeeID = 108;


DELETE FROM Employees
WHERE EmployeeID = 107; 



SELECT DISTINCT DepartmentID
FROM Employees;

    SELECT
    EmployeeName,
    Salary
    DepartmentName
FROM Employees
ORDER BY Salary DESC
LIMIT 5;
    

SELECT SUM(Budget) AS TotalProjectBudget
FROM Projects;


SELECT MAX(Salary) AS HighestSalary
FROM Employees;


SELECT MIN(Salary) AS LowestSalary
FROM Employees;


SELECT
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary
FROM Employees;

SELECT
    d.DepartmentName,
    COUNT(e.EmployeeID) AS TotalEmployees,
    AVG(e.Salary) AS AverageSalary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AverageSalary DESC;


SELECT
    c.ClientName,
    SUM(p.Budget) AS TotalBudget
FROM Projects p
JOIN Clients c
ON p.ClientID = c.ClientID
GROUP BY c.ClientName;


SELECT EmployeeName, Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);


SELECT
    d.DepartmentName,
    COUNT(e.EmployeeID) AS TotalEmployees,
    AVG(e.Salary) AS AverageSalary,
    MAX(e.Salary) AS HighestSalary,
    MIN(e.Salary) AS LowestSalary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AverageSalary DESC;
 
