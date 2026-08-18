CREATE DATABASE MINIPROJECT;
USE MINIPROJECT;

-- Module 1 – Data Warehouse & Employee Analytics (Tasks 1–10)
/*Task 1 – Employee Data Profiling(OUTPUT)
The Data Engineering team needs a summary of employee records loaded into the Data Warehouse.*/

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);


INSERT INTO Employee (Emp_ID, Emp_Name, Department, Salary)
VALUES
(101, 'Aarav',   'HR',        45000.00),
(102, 'Diya',    'IT',        75000.00),
(103, 'Rahul',   'Finance',   68000.00),
(104, 'Sneha',   'IT',        82000.00),
(105, 'Kiran',   'HR',        52000.00),
(106, 'Meera',   'Marketing', 60000.00),
(107, 'Arjun',   'Finance',   72000.00),
(108, 'Priya',   'Marketing', 58000.00),
(109, 'Rohan',   'IT',        90000.00),
(110, 'Ananya',  'HR',        48000.00);

SELECT * FROM Employee;

-- Display  Department
SELECT DISTINCT DEPARTMENT FROM EMPLOYEE;

-- Total Employees
SELECT COUNT(*) AS TOTAL_EMPLOYEE FROM EMPLOYEE;

-- Average Salary
SELECT AVG(SALARY) AS AVG_SAL FROM EMPLOYEE;

-- Highest Salary
SELECT MAX(SALARY) AS MAX_SAL FROM EMPLOYEE;

-- Lowest Salary
SELECT MIN(SALARY) AS MIN_SAL FROM EMPLOYEE;

-- Sort by Average Salary in descending order.
SELECT DEPARTMENT, COUNT(*) AS TOTAL_EMPLOYEE,
AVG(SALARY) AS AVG_SAL,
MAX(SALARY) AS MAX_SAL,
MIN(SALARY) AS MIN_SAL FROM EMPLOYEE
GROUP BY DEPARTMENT
ORDER BY AVG_SAL DESC;

-- Task 2 – Department Salary Analysis(OUTPUT)
/*Find departments whose total salary is greater than the company average department salary.
Display:
• Department
• Total Salary*/
SELECT AVG(SALARY) FROM EMPLOYEE;

SELECT DEPARTMENT, SUM(SALARY), AVG(SALARY)  FROM EMPLOYEE
GROUP BY DEPARTMENT
HAVING SUM(SALARY) > AVG(SALARY);

/*Task 3 – Salary Validation(OUTPUT)
Identify employees whose salary is higher than the average salary of their department.
Display:
• Employee Name
• Department
• Salary
• Department Average*/

SELECT EMP_NAME,DEPARTMENT,SALARY, DEPT_AVG_SAL
 FROM (
 SELECT EMP_NAME,DEPARTMENT, SALARY , AVG(SALARY) OVER(
PARTITION BY DEPARTMENT) AS DEPT_AVG_SAL FROM EMPLOYEE
) AS SAL
WHERE SALARY > DEPT_AVG_SAL;

-- Task 4 – Department Ranking(OUTPUT)
/*Rank departments based on total salary expenditure.
Display:
• Department
• Total Salary
• Rank*/

SELECT DEPARTMENT, SUM(SALARY) AS TOTAL_SAL, RANK()
OVER(
ORDER BY SUM(SALARY) DESC ) AS RANK_NUMBER
FROM EMPLOYEE
GROUP BY DEPARTMENT;

-- Task 5 – Duplicate Employee Detection-- OUTPUT
/*Find duplicate Employee IDs generated during ETL loading*/
CREATE TABLE Employee_Stage (
    Load_ID INT PRIMARY KEY,
    Employee_ID INT,
    Employee_Name VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10,2),
    Load_Date DATE
);
INSERT INTO Employee_Stage VALUES
(1,1001,'Aarav',10,50000,'2026-08-01'),
(2,1002,'Diya',20,52000,'2026-08-01'),
(3,1003,'Rahul',30,48000,'2026-08-01'),
(4,1004,'Sneha',40,55000,'2026-08-01'),

(5,1005,'Arjun',20,60000,'2026-08-01'),
(6,1005,'Arjun',20,60000,'2026-08-01'),

(7,1006,'Priya',10,51000,'2026-08-01'),
(8,1007,'Karan',30,47000,'2026-08-01'),
(9,1008,'Meera',20,58000,'2026-08-01'),
(10,1009,'Rohan',10,62000,'2026-08-01'),

(11,1010,'Ananya',40,53000,'2026-08-01'),
(12,1010,'Ananya',40,53000,'2026-08-01'),
(13,1010,'Ananya',40,53000,'2026-08-02'),

(14,1011,'Vikram',20,61000,'2026-08-02'),
(15,1012,'Pooja',10,45000,'2026-08-02'),
(16,1013,'Nikhil',30,52000,'2026-08-02'),
(17,1014,'Kavya',40,56000,'2026-08-02'),
(18,1015,'Aditya',20,59000,'2026-08-02'),
(19,1016,'Neha',10,47000,'2026-08-02'),
(20,1017,'Siddharth',30,54000,'2026-08-02'),
(21,1018,'Aisha',40,61000,'2026-08-02'),
(22,1019,'Manish',20,50000,'2026-08-02'),

(23,1020,'Ritika',10,63000,'2026-08-02'),
(24,1020,'Ritika',10,63000,'2026-08-03'),

(25,1021,'Yash',30,49000,'2026-08-03'),
(26,1022,'Simran',40,58000,'2026-08-03'),
(27,1023,'Harish',20,52000,'2026-08-03'),
(28,1024,'Deepa',10,61000,'2026-08-03'),
(29,1025,'Tarun',30,46000,'2026-08-03'),

(30,1026,'Bhavana',40,55000,'2026-08-03'),
(31,1027,'Gaurav',20,51000,'2026-08-03'),
(32,1028,'Ishita',10,64000,'2026-08-03'),
(33,1029,'Mohit',30,48000,'2026-08-03'),

(34,1030,'Nandhini',40,57000,'2026-08-03'),
(35,1030,'Nandhini',40,57000,'2026-08-04'),

(36,1031,'Adarsh',20,50000,'2026-08-04'),
(37,1032,'Keerthi',10,61000,'2026-08-04'),
(38,1033,'Rakesh',30,49000,'2026-08-04'),
(39,1034,'Pallavi',40,56000,'2026-08-04'),
(40,1035,'Sanjay',20,53000,'2026-08-04'),
(41,1036,'Nisha',10,52000,'2026-08-04'),
(42,1037,'Harsha',30,47000,'2026-08-04'),
(43,1038,'Vinay',40,65000,'2026-08-04'),
(44,1039,'Ajay',20,51000,'2026-08-04'),
(45,1040,'Kiran',10,60000,'2026-08-04'),
(46,1041,'Lavanya',30,59000,'2026-08-04'),
(47,1042,'Suresh',40,55000,'2026-08-04'),
(48,1043,'Mahesh',20,48000,'2026-08-04'),
(49,1044,'Bhavya',10,61000,'2026-08-04'),
(50,1045,'Ramesh',30,53000,'2026-08-04'),
(51,1046,'Geetha',40,57000,'2026-08-05'),
(52,1047,'Karthik',20,62000,'2026-08-05'),
(53,1048,'Shreya',10,54000,'2026-08-05'),
(54,1049,'Naveen',30,50000,'2026-08-05'),
(55,1050,'Swathi',40,56000,'2026-08-05'),
(56,1051,'Praveen',20,51000,'2026-08-05'),
(57,1052,'Divya',10,63000,'2026-08-05'),
(58,1053,'Aravind',30,52000,'2026-08-05'),
(59,1054,'Chaitra',40,58000,'2026-08-05'),
(60,1055,'Lokesh',20,60000,'2026-08-05');
SELECT * FROM Employee_Stage;

SELECT EMPLOYEE_ID, COUNT(*) AS DUPLICATE_RECORD FROM EMPLOYEE_STAGE

GROUP BY EMPLOYEE_ID
HAVING DUPLICATE_RECORD >1
;


-- Task 6 – Missing Department Mapping--  OUTPUT
/*Display employees whose Department_ID has no matching record in the Department table.*/
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50)
);
INSERT INTO Department (Department_ID, Department_Name)
VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(6, 'Sales');

SELECT * FROM Department;

CREATE TABLE Employe (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10,2)
);
INSERT INTO Employe (Emp_ID, Emp_Name, Department_ID, Salary)
VALUES
(101, 'Aarav',   1, 45000.00),
(102, 'Diya',    2, 75000.00),
(103, 'Rahul',   5, 68000.00),   -- No matching Department_ID
(104, 'Sneha',   3, 82000.00),
(105, 'Kiran',   1, 52000.00),
(106, 'Meera',   4, 60000.00),
(107, 'Arjun',   2, 72000.00),
(108, 'Priya',   6, 58000.00),
(109, 'Rohan',   7, 90000.00),   -- No matching Department_ID
(110, 'Ananya',  1, 48000.00);
SELECT * FROM EMPLOYE;

SELECT
    e.Emp_ID,
    e.Emp_Name,
    e.Department_ID,
    e.Salary
FROM Employe e
LEFT JOIN Department d
    ON e.Department_ID = d.Department_ID
WHERE d.Department_ID IS NULL;

-- Task 7 – Latest Employee Record-- OUTPUT
/*Each employee may have multiple records due to historical loads.
Display only the latest record for every employee.*/


CREATE TABLE Emp (
    Emp_ID INT,
    Emp_Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Load_Date DATE
);
INSERT INTO Emp (Emp_ID, Emp_Name, Department, Salary, Load_Date)
VALUES
(101, 'Aarav',  'HR',        45000, '2025-01-10'),
(101, 'Aarav',  'HR',        48000, '2025-06-15'),
(102, 'Diya',   'IT',        70000, '2025-02-20'),
(102, 'Diya',   'IT',        75000, '2025-07-01'),
(103, 'Rahul',  'Finance',   65000, '2025-03-12'),
(104, 'Sneha',  'IT',        80000, '2025-04-18'),
(104, 'Sneha',  'IT',        82000, '2025-08-01'),
(105, 'Kiran',  'HR',        52000, '2025-05-10'),
(106, 'Meera',  'Marketing', 58000, '2025-06-01'),
(106, 'Meera',  'Marketing', 60000, '2025-07-20');

SELECT * FROM EMP;

select * FROM EMP
ORDER BY LOAD_DATE DESC
LIMIT 1;

-- Task 8 – Employee Growth Analysis (OUTPUT)
/*Calculate the running total of employees hired month-wise.*/
SELECT count(*) , RANK()
OVER(
) AS R
FROM EMP
group BY MONTH(LOAD_DATE);

-- Task 9 – Department-wise Top 3 Salaries-- (OUTPUT)
/*Display the top three highest-paid employees in every department*/


select * from(
select *, row_number()
over(
partition by department 
order by salary desc
) as den_rank
from emp) as T
where den_rank <4; 

-- Task 10 – Employee Summary View(OUTPUT)
/*Create a View that displays active employee details along with department information*/
CREATE TABLE Employee2 (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10,2),
    Status VARCHAR(20)
);
INSERT INTO Employee2 (Emp_ID, Emp_Name, Department_ID, Salary, Status)
VALUES
(101, 'Aarav',   1, 45000.00, 'Active'),
(102, 'Diya',    2, 75000.00, 'Active'),
(103, 'Rahul',   3, 68000.00, 'Inactive'),
(104, 'Sneha',   2, 82000.00, 'Active'),
(105, 'Kiran',   1, 52000.00, 'Active'),
(106, 'Meera',   4, 60000.00, 'Inactive'),
(107, 'Arjun',   3, 72000.00, 'Active'),
(108, 'Priya',   4, 58000.00, 'Active'),
(109, 'Rohan',   2, 90000.00, 'Inactive'),
(110, 'Ananya',  1, 48000.00, 'Active');

select * from employee2 e
left join department d 
on e.department_id = d.department_id
where e.status ='active';

-- Module 2 – Sales Data Warehouse (Tasks 11–20)
use miniproject;
-- Task 11- Generate month-wise sales revenue.-- PARTIAL

CREATE TABLE Sales1 (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Sale_Date DATE,
    Quantity INT,
    Revenue DECIMAL(10,2)
);
INSERT INTO Sales1 (Sale_ID, Customer_ID, Product_ID, Sale_Date, Quantity, Revenue)
VALUES
(1, 101, 201, '2025-01-05', 2, 50000.00),
(2, 102, 202, '2025-01-15', 1, 30000.00),
(3, 103, 203, '2025-02-08', 3, 45000.00),
(4, 104, 204, '2025-02-20', 2, 25000.00),
(5, 105, 205, '2025-03-10', 1, 15000.00),
(6, 106, 206, '2025-03-18', 4, 60000.00),
(7, 107, 207, '2025-04-12', 2, 35000.00),
(8, 108, 208, '2025-05-05', 1, 20000.00),
(9, 109, 209, '2025-05-22', 3, 75000.00),
(10,110,210, '2025-06-15', 2, 40000.00);
select * from Sales1;

SELECT
    MONTH(Sale_Date) AS Month_Number,
    MONTHNAME(Sale_Date) AS Month_Name,
    SUM(Revenue) AS Total_Revenue
FROM Sales1
GROUP BY
    MONTH(Sale_Date),
    MONTHNAME(Sale_Date)
ORDER BY
    MONTH(Sale_Date);

-- Task 12-- NO  OUTPUT
/*Find products contributing to 80% of total revenue.*/
select * from sales1;
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100)
);
INSERT INTO Product (Product_ID, Product_Name)
VALUES
(201, 'Laptop'),
(202, 'Mobile'),
(203, 'Headphones'),
(204, 'Chair'),
(205, 'Table'),
(206, 'T-Shirt'),
(207, 'Jeans'),
(208, 'Book'),
(209, 'Printer'),
(210, 'Smart Watch');
select * from Product;



WITH Product_Revenue AS
(
    SELECT
        p.Product_ID,
        p.Product_Name,
        SUM(s.revenue) AS Revenue
    FROM Product p
    JOIN Sales1 s
        ON p.Product_ID = s.Product_ID
    GROUP BY
        p.Product_ID,
        p.Product_Name
),

Revenue_Calculation AS
(
    SELECT
        Product_Name,
        Revenue,

        SUM(Revenue) OVER (
            ORDER BY Revenue DESC
        ) AS Running_Revenue,

        SUM(Revenue) OVER () AS Total_Revenue

    FROM Product_Revenue
)

SELECT
    Product_Name,
    Revenue,
    Running_Revenue,
    ROUND(
        Running_Revenue * 100.0 / Total_Revenue,
        2
    ) AS Revenue_Percentage
FROM Revenue_Calculation
ORDER BY Revenue DESC;

-- Task 13-- NO OUTPUT
/*Display products that have never been sold.*/
CREATE TABLE Product2 (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);
INSERT INTO Product2
VALUES
(101,'Laptop','Electronics',60000),
(102,'Mobile','Electronics',30000),
(103,'Headphones','Electronics',5000),
(104,'Chair','Furniture',4000),
(105,'Table','Furniture',8000),
(106,'T-Shirt','Clothing',1200),
(107,'Jeans','Clothing',2000),
(108,'Book','Books',500),
(109,'Printer','Electronics',15000),
(110,'Smart Watch','Electronics',10000);

CREATE TABLE Sales2 (
    Sale_ID INT PRIMARY KEY,
    Product_ID INT,
    Sale_Date DATE,
    Quantity INT,
    Revenue DECIMAL(10,2),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);
INSERT INTO Sales2
VALUES( SALE_ID,PRODUCT_ID, SALE_DATE, QUANTITY, REVENUE),
(1,101,'2025-01-05',2,120000),
(2,102,'2025-01-08',3,90000),
(3,103,'2025-01-15',5,25000),
(4,104,'2025-02-10',4,16000),
(5,105,'2025-02-18',2,16000),
(6,106,'2025-03-05',8,9600),
(7,107,'2025-03-12',6,12000),
(8,108,'2025-04-01',10,5000);
CREATE TABLE Sales2 (
    Sale_ID INT PRIMARY KEY,
    Product_ID INT,
    Sale_Date DATE,
    Quantity INT,
    Revenue DECIMAL(10,2),
    FOREIGN KEY (Product_ID) REFERENCES Product2(Product_ID)
);
INSERT INTO Sales2
(Sale_ID, Product_ID, Sale_Date, Quantity, Revenue)
VALUES
(1,101,'2025-01-05',2,120000),
(2,102,'2025-01-08',3,90000),
(3,103,'2025-01-15',5,25000),
(4,104,'2025-02-10',4,16000),
(5,105,'2025-02-18',2,16000);
select * from Sales2; 

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category
FROM Product2 p
LEFT JOIN Sales2 s
    ON p.Product_ID = s.Product_ID
WHERE s.Product_ID IS NULL;

-- Task 14
/*Identify customers purchasing from multiple categories.*/
SELECT
    c.Customer_Name,
    COUNT(DISTINCT cat.Category_ID) AS Number_of_Categories_Purchased
FROM Customer c
INNER JOIN Sales s
    ON c.Customer_ID = s.Customer_ID
INNER JOIN Product p
    ON s.Product_ID = p.Product_ID
INNER JOIN Category cat
    ON p.Category_ID = cat.Category_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING COUNT(DISTINCT cat.Category_ID) > 1
ORDER BY
    Number_of_Categories_Purchased DESC,
    c.Customer_Name;


-- Task 15(OUTPUT)
/*Find the second highest selling product in every category.*/
use miniproject;
CREATE TABLE Product_Sales (
    Sale_ID INT PRIMARY KEY,
    Product_ID INT,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Quantity_Sold INT
);

INSERT INTO Product_Sales (Sale_ID, Product_ID, Product_Name, Category, Quantity_Sold) VALUES
(1, 101, 'Laptop', 'Electronics', 120),
(2, 102, 'Mobile', 'Electronics', 180),
(3, 103, 'Headphones', 'Electronics', 150),

(4, 201, 'Shirt', 'Clothing', 90),
(5, 202, 'Jeans', 'Clothing', 140),
(6, 203, 'Jacket', 'Clothing', 110),

(7, 301, 'Rice', 'Groceries', 250),
(8, 302, 'Milk', 'Groceries', 300),
(9, 303, 'Sugar', 'Groceries', 275),

(10, 401, 'Notebook', 'Stationery', 80),
(11, 402, 'Pen', 'Stationery', 150),
(12, 403, 'Marker', 'Stationery', 120);

select * from Product_Sales;

SELECT * FROM (
select *, dense_rank()
over(
PARTITION BY CATEGORY
order by quantity_sold desc
) as S 
from Product_Sales
) AS RANKPROD
WHERE S=2
;

-- Task 16
/*Generate customer lifetime value.*/   
CREATE TABLE Sales_CLV (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Sale_Date DATE,
    Quantity INT,
    Revenue DECIMAL(10,2)
);
INSERT INTO Sales_CLV
(Sale_ID, Customer_ID, Sale_Date, Quantity, Revenue)
VALUES
(1,1,'2026-01-05',2,5000),
(2,1,'2026-02-10',3,7500),

(3,2,'2026-01-08',1,3000),
(4,2,'2026-02-15',2,4500),

(5,3,'2026-01-12',2,6000),
(6,3,'2026-03-05',1,3500),

(7,4,'2026-01-20',5,15000),
(8,4,'2026-02-22',3,12000),

(9,5,'2026-01-25',2,8000),
(10,5,'2026-03-10',4,14000),

(11,6,'2026-02-01',1,2500),
(12,6,'2026-03-15',2,5000),

(13,7,'2026-01-10',3,9000),
(14,7,'2026-02-18',2,6000),

(15,8,'2026-01-14',2,7000),
(16,8,'2026-03-20',1,4000),

(17,9,'2026-01-18',4,20000),
(18,9,'2026-02-25',5,25000),

(19,10,'2026-01-22',2,5500),
(20,10,'2026-03-02',3,8500),

(21,11,'2026-02-05',1,3000),
(22,11,'2026-03-12',2,6500),

(23,12,'2026-01-30',2,7000),
(24,12,'2026-02-28',3,9000),

(25,13,'2026-01-11',4,12000),
(26,13,'2026-03-18',2,8000),

(27,14,'2026-02-07',1,2500),
(28,14,'2026-03-25',2,5500),

(29,15,'2026-01-16',3,10000),
(30,15,'2026-02-20',4,16000),

(31,16,'2026-01-19',2,6000),
(32,16,'2026-03-01',3,9000),

(33,17,'2026-01-24',5,25000),
(34,17,'2026-03-08',4,20000),

(35,18,'2026-02-02',2,5000),
(36,18,'2026-03-14',3,7500),

(37,19,'2026-01-28',6,30000),
(38,19,'2026-02-26',5,25000),

(39,20,'2026-02-10',2,7000),
(40,20,'2026-03-22',3,11000),

(41,21,'2026-01-15',1,4000),
(42,22,'2026-01-18',2,5000),
(43,23,'2026-02-12',3,9000),
(44,24,'2026-02-20',2,6000),
(45,25,'2026-03-01',4,12000),

(46,26,'2026-03-05',2,5000),
(47,27,'2026-03-10',3,7500),
(48,28,'2026-03-15',2,6000),
(49,29,'2026-03-20',5,15000),
(50,30,'2026-03-25',3,9000);

select * from customer;
SELECT
    c.Customer_Name,
    COUNT(s.Sale_ID) AS Total_Orders,
    SUM(s.Revenue) AS Total_Revenue,
    SUM(s.Revenue) AS Customer_Lifetime_Value
FROM Customer c
JOIN Sales_CLV s
    ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY
    Customer_Lifetime_Value DESC;


-- Task 17(OUTPUT)
/*Display daily sales with previous day sales and next day sales.*/

CREATE TABLE Daily_Sales (
    Sale_Date DATE PRIMARY KEY,
    Total_Sales DECIMAL(10,2)
);
INSERT INTO Daily_Sales (Sale_Date, Total_Sales) VALUES
('2026-01-01', 5000),
('2026-01-02', 7000),
('2026-01-03', 6000),
('2026-01-04', 9000),
('2026-01-05', 8000),
('2026-01-06', 10000),
('2026-01-07', 9500),
('2026-01-08', 11000),
('2026-01-09', 10500),
('2026-01-10', 12000);
SELECT * FROM Daily_Sales;

SELECT SALE_DATE, TOTAL_SALES, LAG(TOTAL_SALES)
OVER(
ORDER BY SALE_DATE
) AS PREVOIUS_DATE,
LEAD(TOTAL_SALES)
OVER(
ORDER BY SALE_DATE
) AS NEXT_DAY_SALES
FROM Daily_Sales
;

-- Task 18(OUTPUT)
/*Find the top five customers in each region.*/
USE MINIPROJECT;
CREATE TABLE Customer_Sales (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(50),
    Total_Purchase DECIMAL(10,2)
);
INSERT INTO Customer_Sales
(Customer_ID, Customer_Name, City, Total_Purchase)
VALUES
(101,'Rahul','Hyderabad',95000),
(102,'Priya','Hyderabad',87000),
(103,'Arjun','Hyderabad',92000),
(104,'Sneha','Hyderabad',78000),
(105,'Kiran','Hyderabad',85000),
(106,'Anjali','Hyderabad',69000),

(107,'Ravi','Bangalore',98000),
(108,'Meena','Bangalore',91000),
(109,'Vijay','Bangalore',86000),
(110,'Pooja','Bangalore',80000),
(111,'Deepak','Bangalore',76000),
(112,'Kavya','Bangalore',72000),

(113,'Amit','Chennai',90000),
(114,'Neha','Chennai',88000),
(115,'Rohan','Chennai',84000),
(116,'Divya','Chennai',79000),
(117,'Nikhil','Chennai',75000),
(118,'Sonia','Chennai',71000),

(119,'Ashok','Mumbai',99000),
(120,'Swathi','Mumbai',94000),
(121,'Harish','Mumbai',90000),
(122,'Keerthi','Mumbai',87000),
(123,'Ganesh','Mumbai',81000),
(124,'Lavanya','Mumbai',77000);
SELECT * FROM Customer_SaleS;

SELECT  * FROM(
SELECT *, DENSE_RANK()
OVER(
PARTITION BY CITY
ORDER BY TOTAL_PURCHASE DESC
) AS TOP_CUSTOMER
FROM CUSTOMER_SALES
) AS tc
WHERE TOP_CUSTOMER <6
;

-- Task 19-- OUTPUT
/*Create a View for monthly sales reporting.*/
CREATE TABLE Sales3 (
    Sale_ID INT PRIMARY KEY,
    Product_ID INT,
    Sale_Date DATE,
    Quantity INT,
    Revenue DECIMAL(10,2)
);
INSERT INTO Sales3
VALUES
(1,101,'2025-01-05',2,120000),
(2,102,'2025-01-08',3,90000),
(3,103,'2025-01-15',5,25000),
(4,104,'2025-02-10',4,16000),
(5,105,'2025-02-18',2,16000),
(6,106,'2025-03-05',8,9600),
(7,107,'2025-03-12',6,12000),
(8,108,'2025-04-01',10,5000);
select * from Sales3; 

SELECT  MONTH(SALE_DATE) AS MONTHLY, SUM(REVENUE) AS TOTAL_REVENUE  FROM SALES3
GROUP BY MONTH(SALE_DATE);

-- Task 20-- OUTPUT
/*Generate a CTE to simplify regional sales analysis.*/

CREATE TABLE Customer1 (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(50)
);
INSERT INTO Customer1 VALUES
(1,'Aarav','Hyderabad'),
(2,'Diya','Hyderabad'),
(3,'Rahul','Hyderabad'),
(4,'Sneha','Hyderabad'),
(5,'Arjun','Hyderabad'),
(6,'Priya','Hyderabad'),
(7,'Karan','Hyderabad'),
(8,'Meera','Hyderabad'),

(9,'Rohan','Bengaluru'),
(10,'Ananya','Bengaluru'),
(11,'Vikram','Bengaluru'),
(12,'Pooja','Bengaluru'),
(13,'Nikhil','Bengaluru'),
(14,'Kavya','Bengaluru'),
(15,'Aditya','Bengaluru'),
(16,'Neha','Bengaluru'),

(17,'Siddharth','Chennai'),
(18,'Aisha','Chennai'),
(19,'Manish','Chennai'),
(20,'Ritika','Chennai'),
(21,'Yash','Chennai'),
(22,'Simran','Chennai'),
(23,'Harish','Chennai'),
(24,'Deepa','Chennai'),

(25,'Tarun','Mumbai'),
(26,'Bhavana','Mumbai'),
(27,'Gaurav','Mumbai'),
(28,'Ishita','Mumbai'),
(29,'Mohit','Mumbai'),
(30,'Nandhini','Mumbai'),
(31,'Sanjay','Mumbai'),
(32,'Nisha','Mumbai'),

(33,'Harsha','Delhi'),
(34,'Vinay','Delhi'),
(35,'Ajay','Delhi'),
(36,'Kiran','Delhi'),
(37,'Lavanya','Delhi'),
(38,'Suresh','Delhi'),
(39,'Mahesh','Delhi'),
(40,'Bhavya','Delhi');

CREATE TABLE Sale (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Amount DECIMAL(10,2),
    Order_Date DATE,
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer1(Customer_ID)
);
DROP TABLE SALE;
INSERT INTO Sale VALUES
(1,1,2500,'2026-08-01'),
(2,1,1800,'2026-08-05'),
(3,1,3200,'2026-08-10'),
(4,1,2100,'2026-08-15'),
(5,1,4000,'2026-08-20'),

(6,2,2800,'2026-08-02'),
(7,2,1900,'2026-08-06'),
(8,2,3500,'2026-08-11'),
(9,2,2400,'2026-08-16'),
(10,2,3100,'2026-08-21'),

(11,3,2600,'2026-08-03'),
(12,3,1800,'2026-08-07'),
(13,3,3400,'2026-08-12'),
(14,3,2200,'2026-08-17'),
(15,3,3900,'2026-08-22'),

(16,4,3000,'2026-08-04'),
(17,4,2100,'2026-08-08'),
(18,4,3600,'2026-08-13'),
(19,4,2500,'2026-08-18'),
(20,4,4100,'2026-08-23'),

(21,5,2700,'2026-08-05'),
(22,5,1900,'2026-08-09'),
(23,5,3300,'2026-08-14'),
(24,5,2400,'2026-08-19'),
(25,5,4200,'2026-08-24'),

(26,6,2900,'2026-08-06'),
(27,6,2000,'2026-08-10'),
(28,6,3500,'2026-08-15'),
(29,6,2600,'2026-08-20'),
(30,6,4300,'2026-08-25'),

(31,7,3100,'2026-08-07'),
(32,7,2200,'2026-08-11'),
(33,7,3700,'2026-08-16'),
(34,7,2800,'2026-08-21'),
(35,7,4400,'2026-08-26'),

(36,8,3200,'2026-08-08'),
(37,8,2300,'2026-08-12'),
(38,8,3800,'2026-08-17'),
(39,8,2900,'2026-08-22'),
(40,8,4500,'2026-08-27'),

(41,9,3300,'2026-08-09'),
(42,9,2400,'2026-08-13'),
(43,9,3900,'2026-08-18'),
(44,9,3000,'2026-08-23'),
(45,9,4600,'2026-08-28'),

(46,10,3400,'2026-08-10'),
(47,10,2500,'2026-08-14'),
(48,10,4000,'2026-08-19'),
(49,10,3100,'2026-08-24'),
(50,10,4700,'2026-08-29'),

(51,11,3500,'2026-08-11'),
(52,11,2600,'2026-08-15'),
(53,11,4100,'2026-08-20'),
(54,11,3200,'2026-08-25'),
(55,11,4800,'2026-08-30'),

(56,12,3600,'2026-08-12'),
(57,12,2700,'2026-08-16'),
(58,12,4200,'2026-08-21'),
(59,12,3300,'2026-08-26'),
(60,12,4900,'2026-08-31'),

(61,13,3700,'2026-09-01'),
(62,13,2800,'2026-09-05'),
(63,13,4300,'2026-09-10'),
(64,13,3400,'2026-09-15'),
(65,13,5000,'2026-09-20'),

(66,14,3800,'2026-09-02'),
(67,14,2900,'2026-09-06'),
(68,14,4400,'2026-09-11'),
(69,14,3500,'2026-09-16'),
(70,14,5100,'2026-09-21'),

(71,15,3900,'2026-09-03'),
(72,15,3000,'2026-09-07'),
(73,15,4500,'2026-09-12'),
(74,15,3600,'2026-09-17'),
(75,15,5200,'2026-09-22'),

(76,16,4000,'2026-09-04'),
(77,16,3100,'2026-09-08'),
(78,16,4600,'2026-09-13'),
(79,16,3700,'2026-09-18'),
(80,16,5300,'2026-09-23'),

(81,17,4100,'2026-09-05'),
(82,17,3200,'2026-09-09'),
(83,17,4700,'2026-09-14'),
(84,17,3800,'2026-09-19'),
(85,17,5400,'2026-09-24'),

(86,18,4200,'2026-09-06'),
(87,18,3300,'2026-09-10'),
(88,18,4800,'2026-09-15'),
(89,18,3900,'2026-09-20'),
(90,18,5500,'2026-09-25'),

(91,19,4300,'2026-09-07'),
(92,19,3400,'2026-09-11'),
(93,19,4900,'2026-09-16'),
(94,19,4000,'2026-09-21'),
(95,19,5600,'2026-09-26'),

(96,20,4400,'2026-09-08'),
(97,20,3500,'2026-09-12'),
(98,20,5000,'2026-09-17'),
(99,20,4100,'2026-09-22'),
(100,20,5700,'2026-09-27'),

(101,21,4500,'2026-09-09'),
(102,21,3600,'2026-09-13'),
(103,21,5100,'2026-09-18'),
(104,21,4200,'2026-09-23'),
(105,21,5800,'2026-09-28'),

(106,22,4600,'2026-09-10'),
(107,22,3700,'2026-09-14'),
(108,22,5200,'2026-09-19'),
(109,22,4300,'2026-09-24'),
(110,22,5900,'2026-09-29'),

(111,23,4700,'2026-09-11'),
(112,23,3800,'2026-09-15'),
(113,23,5300,'2026-09-20'),
(114,23,4400,'2026-09-25'),
(115,23,6000,'2026-09-30'),

(116,24,4800,'2026-09-12'),
(117,24,3900,'2026-09-16'),
(118,24,5400,'2026-09-21'),
(119,24,4500,'2026-09-26'),
(120,24,6100,'2026-10-01'),

(121,25,4900,'2026-10-02'),
(122,25,4000,'2026-10-06'),
(123,25,5500,'2026-10-11'),
(124,25,4600,'2026-10-16'),
(125,25,6200,'2026-10-21'),

(126,26,5000,'2026-10-03'),
(127,26,4100,'2026-10-07'),
(128,26,5600,'2026-10-12'),
(129,26,4700,'2026-10-17'),
(130,26,6300,'2026-10-22'),

(131,27,5100,'2026-10-04'),
(132,27,4200,'2026-10-08'),
(133,27,5700,'2026-10-13'),
(134,27,4800,'2026-10-18'),
(135,27,6400,'2026-10-23'),

(136,28,5200,'2026-10-05'),
(137,28,4300,'2026-10-09'),
(138,28,5800,'2026-10-14'),
(139,28,4900,'2026-10-19'),
(140,28,6500,'2026-10-24'),

(141,29,5300,'2026-10-06'),
(142,29,4400,'2026-10-10'),
(143,29,5900,'2026-10-15'),
(144,29,5000,'2026-10-20'),
(145,29,6600,'2026-10-25'),

(146,30,5400,'2026-10-07'),
(147,30,4500,'2026-10-11'),
(148,30,6000,'2026-10-16'),
(149,30,5100,'2026-10-21'),
(150,30,6700,'2026-10-26'),

(151,31,5500,'2026-10-08'),
(152,31,4600,'2026-10-12'),
(153,31,6100,'2026-10-17'),
(154,31,5200,'2026-10-22'),
(155,31,6800,'2026-10-27'),

(156,32,5600,'2026-10-09'),
(157,32,4700,'2026-10-13'),
(158,32,6200,'2026-10-18'),
(159,32,5300,'2026-10-23'),
(160,32,6900,'2026-10-28'),

(161,33,5700,'2026-10-10'),
(162,33,4800,'2026-10-14'),
(163,33,6300,'2026-10-19'),
(164,33,5400,'2026-10-24'),
(165,33,7000,'2026-10-29'),

(166,34,5800,'2026-10-11'),
(167,34,4900,'2026-10-15'),
(168,34,6400,'2026-10-20'),
(169,34,5500,'2026-10-25'),
(170,34,7100,'2026-10-30'),

(171,35,5900,'2026-10-12'),
(172,35,5000,'2026-10-16'),
(173,35,6500,'2026-10-21'),
(174,35,5600,'2026-10-26'),
(175,35,7200,'2026-10-31'),

(176,36,6000,'2026-10-13'),
(177,36,5100,'2026-10-17'),
(178,36,6600,'2026-10-22'),
(179,36,5700,'2026-10-27'),
(180,36,7300,'2026-11-01'),
(181,37,6100,'2026-11-02'),
(182,37,5200,'2026-11-06'),
(183,37,6700,'2026-11-11'),
(184,37,5800,'2026-11-16'),
(185,37,7400,'2026-11-21'),

(186,38,6200,'2026-11-03'),
(187,38,5300,'2026-11-07'),
(188,38,6800,'2026-11-12'),
(189,38,5900,'2026-11-17'),
(190,38,7500,'2026-11-22'),

(191,39,6300,'2026-11-04'),
(192,39,5400,'2026-11-08'),
(193,39,6900,'2026-11-13'),
(194,39,6000,'2026-11-18'),
(195,39,7600,'2026-11-23'),

(196,40,6400,'2026-11-05'),
(197,40,5500,'2026-11-09'),
(198,40,7000,'2026-11-14'),
(199,40,6100,'2026-11-19'),
(200,40,7700,'2026-11-24');
SELECT * FROM SALE;
SELECT * FROM CUSTOMER1;

with regional_sales as
(select c.CITY,
count(c.custOMER_id) as Total_customers,
count(S.SALE_id) as Total_orders,
sum(S.order_AMOUNT) as Total_revenue
from customer1 C
inner join SALE S
on c.custOMER_id = S.custOMER_ID
group by c.CITY
)
select CITY,Total_customers,Total_orders,Total_revenue,
round(Total_revenue/Total_customers ) as Average_Revenue_per_Customer
FROM regional_sales
ORDER BY Total_revenue DESC;




-- Module 3 – Data Lake & Batch Processing (Tasks 21–30)

use miniproject;
CREATE TABLE Batch_Master (
    Batch_ID INT PRIMARY KEY,
    Batch_Name VARCHAR(100),
    Batch_Date DATE,
    Load_Status VARCHAR(20)
);
INSERT INTO Batch_Master
VALUES
(101,'Customer ETL Load','2026-08-01','Success'),
(102,'Sales ETL Load','2026-08-01','Success'),
(103,'Product ETL Load','2026-08-01','Failed'),
(104,'Employee ETL Load','2026-08-02','Success'),
(105,'Inventory ETL Load','2026-08-02','Partial'),
(106,'Finance ETL Load','2026-08-02','Success'),
(107,'Supplier ETL Load','2026-08-03','Failed'),
(108,'Orders ETL Load','2026-08-03','Success'),
(109,'Returns ETL Load','2026-08-03','Partial'),
(110,'Warehouse ETL Load','2026-08-04','Success');
select * from Batch_Master;


CREATE TABLE Source_Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(100),
    Batch_ID INT,
    FOREIGN KEY (Batch_ID) REFERENCES Batch_Master(Batch_ID)
);
INSERT INTO Source_Customer
(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID)
VALUES
(1001,'Aarav Sharma','aarav@gmail.com','9876543210','Mumbai',101),
(1002,'Diya Patel','diya@gmail.com','9876543211','Ahmedabad',101),
(1003,'Rohan Verma','rohan@gmail.com','9876543212','Delhi',101),
(1004,'Sneha Reddy','sneha@gmail.com','9876543213','Hyderabad',102),
(1005,'Arjun Nair','arjun@gmail.com','9876543214','Kochi',102),
(1006,'Priya Iyer','priya@gmail.com','9876543215','Chennai',102),
(1007,'Karan Singh','karan@gmail.com','9876543216','Jaipur',103),
(1008,'Meera Joshi','meera@gmail.com','9876543217','Pune',103),
(1009,'Rahul Gupta','rahul@gmail.com','9876543218','Lucknow',103),
(1010,'Ananya Das','ananya@gmail.com','9876543219','Kolkata',104),

(1011,'Vikram Rao','vikram@gmail.com','9876543220','Bengaluru',104),
(1012,'Pooja Sharma','pooja@gmail.com','9876543221','Mumbai',104),
(1013,'Nikhil Jain','nikhil@gmail.com','9876543222','Indore',105),
(1014,'Kavya Menon','kavya@gmail.com','9876543223','Kochi',105),
(1015,'Aditya Kulkarni','aditya@gmail.com','9876543224','Nagpur',105),
(1016,'Neha Kapoor','neha@gmail.com','9876543225','Chandigarh',106),
(1017,'Siddharth Roy','sid@gmail.com','9876543226','Kolkata',106),
(1018,'Aisha Khan','aisha@gmail.com','9876543227','Bhopal',106),
(1019,'Manish Kumar','manish@gmail.com','9876543228','Patna',107),
(1020,'Ritika Sinha','ritika@gmail.com','9876543229','Ranchi',107),

(1021,'Yash Mehta','yash@gmail.com','9876543230','Surat',107),
(1022,'Simran Kaur','simran@gmail.com','9876543231','Amritsar',108),
(1023,'Harish Babu','harish@gmail.com','9876543232','Visakhapatnam',108),
(1024,'Deepa Rani','deepa@gmail.com','9876543233','Mysuru',108),
(1025,'Mohit Arora','mohit@gmail.com','9876543234','Noida',109),
(1026,'Ishita Sen','ishita@gmail.com','9876543235','Kolkata',109),
(1027,'Gaurav Mishra','gaurav@gmail.com','9876543236','Varanasi',109),
(1028,'Nandhini S','nandhini@gmail.com','9876543237','Coimbatore',110),
(1029,'Tarun Kumar','tarun@gmail.com','9876543238','Vijayawada',110),
(1030,'Bhavana Rao','bhavana@gmail.com','9876543239','Hyderabad',110);
select * from Source_Customer;

-- Table 3 – Staging_Customer
CREATE TABLE Staging_Customer (
    Customer_ID INT,
    Customer_Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(100),
    Batch_ID INT,
    Validation_Status VARCHAR(20),
    FOREIGN KEY (Batch_ID) REFERENCES Batch_Master(Batch_ID)
);
INSERT INTO Staging_Customer
(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Validation_Status)
VALUES
(1001,'Aarav Sharma','aarav@gmail.com','9876543210','Mumbai',101,'Valid'),
(1002,'Diya Patel','diya@gmail.com','9876543211','Ahmedabad',101,'Valid'),
(1003,'Rohan Verma','rohan@gmail.com','9876543212','Delhi',101,'Valid'),
(1004,'Sneha Reddy','sneha@gmail.com','9876543213','Hyderabad',102,'Valid'),
(1005,'Arjun Nair','arjun@gmail.com','9876543214','Kochi',102,'Valid'),
(1006,'Priya Iyer','priya@gmail.com','9876543215','Chennai',102,'Valid'),
(1007,'Karan Singh','karan@gmail.com','9876543216','Jaipur',103,'Valid'),
(1008,'Meera Joshi','meera@gmail.com','9876543217','Pune',103,'Valid'),
(1009,'Rahul Gupta','rahul@gmail.com','9876543218','Lucknow',103,'Valid'),
(1010,'Ananya Das','ananya@gmail.com','9876543219','Kolkata',104,'Valid'),

(1011,'Vikram Rao','vikram@gmail.com','9876543220','Bengaluru',104,'Valid'),
(1012,'Pooja Sharma','pooja@gmail.com','9876543221','Mumbai',104,'Valid'),
(1013,'Nikhil Jain','nikhil@gmail.com','9876543222','Indore',105,'Valid'),
(1014,'Kavya Menon','kavya@gmail.com','9876543223','Kochi',105,'Valid'),
(1015,'Aditya Kulkarni','aditya@gmail.com','9876543224','Nagpur',105,'Valid'),
(1016,'Neha Kapoor','neha@gmail.com','9876543225','Chandigarh',106,'Valid'),
(1017,'Siddharth Roy','sid@gmail.com','9876543226','Kolkata',106,'Valid'),
(1018,'Aisha Khan','aisha@gmail.com','9876543227','Bhopal',106,'Valid'),
(1019,'Manish Kumar','manish@gmail.com','9876543228','Patna',107,'Valid'),
(1020,'Ritika Sinha','ritika@gmail.com','9876543229','Ranchi',107,'Valid'),

(1021,'Yash Mehta','yash@gmail.com','9876543230','Surat',107,'Valid'),
(1022,'Simran Kaur','simran@gmail.com','9876543231','Amritsar',108,'Valid'),
(1023,'Harish Babu','harish@gmail.com','9876543232','Visakhapatnam',108,'Valid'),
(1024,'Deepa Rani','deepa@gmail.com','9876543233','Mysuru',108,'Valid'),
(1025,'Mohit Arora','mohit@gmail.com','9876543234','Noida',109,'Valid'),
(1026,'Ishita Sen','ishita@gmail.com','9876543235','Kolkata',109,'Valid'),
(1027,'Gaurav Mishra','gaurav@gmail.com','9876543236','Varanasi',109,'Valid'),
(1028,'Nandhini S','nandhini@gmail.com','9876543237','Coimbatore',110,'Valid'),
(1029,'Tarun Kumar','tarun@gmail.com','9876543238','Vijayawada',110,'Valid'),
(1030,'Bhavana Rao','bhavana@gmail.com','9876543239','Hyderabad',110,'Valid'),


(1031,'Aarav Sharma','aarav@gmail.com','9876543210','Mumbai',101,'Duplicate'),
(1032,'Rakesh Kumar','rakeshgmail.com','9876543240','Delhi',108,'Invalid'),
(1033,'Pallavi Singh','pallavi@gmail.com','9876543241','Lucknow',109,'Valid'),
(1034,'Rahul Gupta','rahul@gmail.com','9876543218','Lucknow',103,'Duplicate'),
(1035,'Nisha Verma','nisha@gmail.com','9876543242','Jaipur',110,'Invalid');
select * from Staging_Customer;

-- Table 4 – Warehouse_Customer
CREATE TABLE Warehouse_Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(100),
    Batch_ID INT,
    Load_Date DATE,
    FOREIGN KEY (Batch_ID) REFERENCES Batch_Master(Batch_ID)
);
INSERT INTO Warehouse_Customer
(Customer_ID, Customer_Name, Email, Phone, City, Batch_ID, Load_Date)
VALUES
(1001,'Aarav Sharma','aarav@gmail.com','9876543210','Mumbai',101,'2026-08-01'),
(1002,'Diya Patel','diya@gmail.com','9876543211','Ahmedabad',101,'2026-08-01'),
(1003,'Rohan Verma','rohan@gmail.com','9876543212','Delhi',101,'2026-08-01'),
(1004,'Sneha Reddy','sneha@gmail.com','9876543213','Hyderabad',102,'2026-08-01'),
(1005,'Arjun Nair','arjun@gmail.com','9876543214','Kochi',102,'2026-08-01'),
(1006,'Priya Iyer','priya@gmail.com','9876543215','Chennai',102,'2026-08-01'),
(1007,'Karan Singh','karan@gmail.com','9876543216','Jaipur',103,'2026-08-01'),
(1008,'Meera Joshi','meera@gmail.com','9876543217','Pune',103,'2026-08-01'),
(1009,'Rahul Gupta','rahul@gmail.com','9876543218','Lucknow',103,'2026-08-01'),
(1010,'Ananya Das','ananya@gmail.com','9876543219','Kolkata',104,'2026-08-02'),

(1011,'Vikram Rao','vikram@gmail.com','9876543220','Bengaluru',104,'2026-08-02'),
(1012,'Pooja Sharma','pooja@gmail.com','9876543221','Mumbai',104,'2026-08-02'),
(1013,'Nikhil Jain','nikhil@gmail.com','9876543222','Indore',105,'2026-08-02'),
(1014,'Kavya Menon','kavya@gmail.com','9876543223','Kochi',105,'2026-08-02'),
(1015,'Aditya Kulkarni','aditya@gmail.com','9876543224','Nagpur',105,'2026-08-02'),
(1016,'Neha Kapoor','neha@gmail.com','9876543225','Chandigarh',106,'2026-08-02'),
(1017,'Siddharth Roy','sid@gmail.com','9876543226','Kolkata',106,'2026-08-02'),
(1018,'Aisha Khan','aisha@gmail.com','9876543227','Bhopal',106,'2026-08-02'),
(1019,'Manish Kumar','manish@gmail.com','9876543228','Patna',107,'2026-08-03'),
(1020,'Ritika Sinha','ritika@gmail.com','9876543229','Ranchi',107,'2026-08-03'),

(1021,'Yash Mehta','yash@gmail.com','9876543230','Surat',107,'2026-08-03'),
(1022,'Simran Kaur','simran@gmail.com','9876543231','Amritsar',108,'2026-08-03'),
(1023,'Harish Babu','harish@gmail.com','9876543232','Visakhapatnam',108,'2026-08-03'),
(1024,'Deepa Rani','deepa@gmail.com','9876543233','Mysuru',108,'2026-08-03'),
(1025,'Mohit Arora','mohit@gmail.com','9876543234','Noida',109,'2026-08-03'),
(1026,'Ishita Sen','ishita@gmail.com','9876543235','Kolkata',109,'2026-08-03'),
(1027,'Gaurav Mishra','gaurav@gmail.com','9876543236','Varanasi',109,'2026-08-03'),
(1028,'Nandhini S','nandhini@gmail.com','9876543237','Coimbatore',110,'2026-08-04'),
(1029,'Tarun Kumar','tarun@gmail.com','9876543238','Vijayawada',110,'2026-08-04'),
(1030,'Bhavana Rao','bhavana@gmail.com','9876543239','Hyderabad',110,'2026-08-04');

-- Table 5 – Rejected_Records
CREATE TABLE Rejected_Records (
    Reject_ID INT PRIMARY KEY,
    Customer_ID INT,
    Batch_ID INT,
    Reject_Reason VARCHAR(200),
    FOREIGN KEY (Batch_ID) REFERENCES Batch_Master(Batch_ID)
);
INSERT INTO Rejected_Records
(Reject_ID, Customer_ID, Batch_ID, Reject_Reason)
VALUES
(1,1032,108,'Invalid email format'),
(2,1035,110,'Phone number is missing'),
(3,1041,103,'Duplicate Customer ID'),
(4,1042,105,'Customer name is NULL'),
(5,1043,107,'Invalid city name'),
(6,1044,109,'Email address already exists'),
(7,1045,102,'Mandatory fields are missing'),
(8,1046,103,'Phone number contains invalid characters');
select * from Rejected_Records;
select * from Batch_Master;
select * from Staging_Customer;

-- Task 21-- no output
/*Compare today's batch record count with yesterday's batch.*/
SELECT
    b.Batch_Date,
    COUNT(s.Customer_ID) AS Total_Records_Loaded,

    LAG(COUNT(s.Customer_ID)) OVER (
        ORDER BY b.Batch_Date
    ) AS Previous_Batch_Record_Count,

    COUNT(s.Customer_ID)
        - LAG(COUNT(s.Customer_ID)) OVER (
            ORDER BY b.Batch_Date
          ) AS Difference_in_Record_Count

FROM Batch_Master b
JOIN Staging_Customer s
    ON b.Batch_ID = s.Batch_ID

GROUP BY
    b.Batch_ID,
    b.Batch_Date

ORDER BY
    b.Batch_Date;
    
-- Task 22-- OUTPUT
/*Identify duplicate records loaded into the staging table.*/
drop table staging_customer;

CREATE TABLE Staging_Customer (
    Customer_ID INT,
    Customer_Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(100),
    Batch_ID INT,
    Validation_Status VARCHAR(20)
);
INSERT INTO Staging_Customer
VALUES
(1001,'Aarav','aarav@gmail.com','9876543210','Mumbai',101,'Valid'),
(1002,'Diya','diya@gmail.com','9876543211','Delhi',101,'Valid'),
(1003,'Rahul','rahul@gmail.com','9876543212','Pune',101,'Valid'),
(1004,'Sneha','sneha@gmail.com','9876543213','Hyderabad',101,'Valid'),

(1005,'Arjun','arjun@gmail.com','9876543214','Chennai',102,'Valid'),
(1005,'Arjun','arjun@gmail.com','9876543214','Chennai',102,'Duplicate'),

(1006,'Priya','priya@gmail.com','9876543215','Kochi',102,'Valid'),
(1007,'Karan','karan@gmail.com','9876543216','Jaipur',102,'Valid'),

(1008,'Meera','meera@gmail.com','9876543217','Pune',102,'Valid'),
(1008,'Meera','meera@gmail.com','9876543217','Pune',103,'Duplicate'),

(1009,'Rohan','rohan@gmail.com','9876543218','Noida',103,'Valid'),
(1010,'Nikhil','nikhil@gmail.com','9876543219','Indore',103,'Valid'),
(1011,'Neha','neha@gmail.com','9876543220','Nagpur',103,'Valid'),

(1012,'Vikram','vikram@gmail.com','9876543221','Bhopal',103,'Valid'),
(1012,'Vikram','vikram@gmail.com','9876543221','Bhopal',104,'Duplicate'),

(1013,'Ananya','ananya@gmail.com','9876543222','Kolkata',104,'Valid'),
(1014,'Harish','harish@gmail.com','9876543223','Mysuru',104,'Valid'),
(1015,'Deepa','deepa@gmail.com','9876543224','Coimbatore',104,'Valid'),
(1016,'Simran','simran@gmail.com','9876543225','Amritsar',104,'Valid'),
(1017,'Tarun','tarun@gmail.com','9876543226','Patna',104,'Valid'),

(1018,'Bhavana','bhavana@gmail.com','9876543227','Ranchi',105,'Valid'),
(1018,'Bhavana','bhavana@gmail.com','9876543227','Ranchi',105,'Duplicate'),

(1019,'Yash','yash@gmail.com','9876543228','Lucknow',105,'Valid'),
(1020,'Pooja','pooja@gmail.com','9876543229','Ahmedabad',105,'Valid'),
(1021,'Aisha','aisha@gmail.com','9876543230','Kochi',105,'Valid'),
(1022,'Manish','manish@gmail.com','9876543231','Delhi',105,'Valid'),
(1023,'Ritika','ritika@gmail.com','9876543232','Mumbai',105,'Valid'),

(1024,'Siddharth','sid@gmail.com','9876543233','Pune',105,'Valid'),
(1024,'Siddharth','sid@gmail.com','9876543233','Pune',105,'Duplicate'),

(1025,'Kavya','kavya@gmail.com','9876543234','Hyderabad',105,'Valid'),
(1026,'Gaurav','gaurav@gmail.com','9876543235','Jaipur',105,'Valid'),
(1027,'Ishita','ishita@gmail.com','9876543236','Kolkata',105,'Valid'),
(1028,'Mohit','mohit@gmail.com','9876543237','Noida',105,'Valid'),
(1029,'Nandhini','nandhini@gmail.com','9876543238','Chennai',105,'Valid'),
(1030,'Aditya','aditya@gmail.com','9876543239','Nagpur',105,'Valid');
select * from Staging_Customer;

select customer_id,count(customer_id) as no_of_duplicate_records from Staging_Customer
group by customer_id
having  no_of_duplicate_records >1;

-- Task 23-- OUTPUT
/*Find NULL values in mandatory columns.*/
select * from Staging_Customer;
UPDATE Staging_Customer
SET CUSTOMER_NAME = NULL
WHERE CUSTOMER_ID = 1004; 
UPDATE Staging_Customer
SET CUSTOMER_NAME = NULL
WHERE CUSTOMER_ID = 1009; 

UPDATE Staging_Customer
SET EMAIL = NULL
WHERE CUSTOMER_ID = 1006;
UPDATE Staging_Customer
SET EMAIL = NULL
WHERE CUSTOMER_ID = 1029;

UPDATE Staging_Customer
SET PHONE = NULL
WHERE CUSTOMER_ID = 1026;

SELECT CUSTOMER_ID, CUSTOMER_NAME, PHONE, EMAIL FROM Staging_Customer
WHERE CUSTOMER_NAME IS NULL OR PHONE IS NULL OR EMAIL IS NULL;


-- Task 24
/*Generate batch-wise load statistics.*/
select * from Rejected_Records;
select * from Batch_Master;
select * from Staging_Customer;

SELECT
    b.Batch_ID,
    b.Batch_Date,

    COUNT(s.Customer_ID) AS Total_Records_Received,

    COUNT(s.Customer_ID) - COUNT(r.Reject_ID)
        AS Successfully_Loaded_Records,

    COUNT(r.Reject_ID) AS Rejected_Records

FROM Batch_Master b

LEFT JOIN Staging_Customer s
    ON b.Batch_ID = s.Batch_ID

LEFT JOIN Rejected_Records r
    ON b.Batch_ID = r.Batch_ID
    AND s.Customer_ID = r.Customer_ID

GROUP BY
    b.Batch_ID,
    b.Batch_Date

ORDER BY
    b.Batch_ID;


-- Task 25
/*Find records rejected during ETL processing.*/

SELECT
    Customer_ID,
    Batch_ID,
    Reject_Reason
FROM Rejected_Records
ORDER BY Batch_ID;

-- Task 26
/*Create a Temporary Table containing invalid records for further validation.*/

UPDATE Staging_Customer
SET Validation_Status = 'Valid';
UPDATE Staging_Customer
SET Validation_Status = 'Invalid'
WHERE Customer_ID IN (3, 5, 8, 10, 15, 18, 25, 32);
CREATE TEMPORARY TABLE Invalid_Records AS
SELECT *
FROM Staging_Customer
WHERE Validation_Status = 'Invalid';
SELECT *
FROM Invalid_Records;

-- Task 27
/*Find source records that failed to reach the target table.*/
SELECT
    s.Customer_ID,
    s.Customer_Name
FROM Source_Customer s
WHERE NOT EXISTS
(
    SELECT 1
    FROM Warehouse_Customer w
    WHERE w.Customer_ID = s.Customer_ID
);
-- Task 28
/*Identify records loaded multiple times into the warehouse.*/
CREATE TABLE Warehouse_Customer1 (
    Load_ID INT PRIMARY KEY,
    Customer_ID INT,
    Customer_Name VARCHAR(100)
);
INSERT INTO Warehouse_Customer1
(Load_ID, Customer_ID, Customer_Name)
VALUES
(1, 1, 'Arun Kumar'),
(2, 2, 'Priya Sharma'),
(3, 3, 'Rahul Verma'),
(4, 4, 'Sneha Reddy'),
(5, 5, 'Karthik Rao'),

(6, 6, 'Anjali Singh'),
(7, 7, 'Vijay Kumar'),
(8, 8, 'Divya Nair'),
(9, 9, 'Rohit Sharma'),
(10, 10, 'Meena Das'),

(11, 11, 'Suresh Babu'),
(12, 12, 'Pooja Patel'),
(13, 13, 'Naveen Raj'),
(14, 14, 'Lakshmi Devi'),
(15, 15, 'Manoj Kumar'),

(16, 16, 'Asha Thomas'),
(17, 17, 'Ravi Shankar'),
(18, 18, 'Neha Gupta'),
(19, 19, 'Ganesh Iyer'),
(20, 20, 'Swathi Rao'),

(21, 21, 'Ajay Menon'),
(22, 22, 'Deepa Nair'),
(23, 23, 'Vimal Kumar'),
(24, 24, 'Kavya Reddy'),
(25, 25, 'Hari Prasad'),

-- Duplicate loads
(26, 1, 'Arun Kumar'),
(27, 2, 'Priya Sharma'),
(28, 3, 'Rahul Verma'),
(29, 4, 'Sneha Reddy'),
(30, 5, 'Karthik Rao');
SELECT
    Customer_ID,
    COUNT(*) AS Number_of_Times_Loaded
FROM Warehouse_Customer1
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- Task 29
/*Generate source-to-target reconciliation report.*/
SELECT
    (SELECT COUNT(*)
     FROM Source_Customer) AS Total_Source_Records,

    (SELECT COUNT(*)
     FROM Warehouse_Customer) AS Total_Warehouse_Records,

    (SELECT COUNT(*)
     FROM Rejected_Records) AS Total_Rejected_Records,

    (
        (SELECT COUNT(*)
         FROM Source_Customer)
        -
        (
            (SELECT COUNT(*)
             FROM Warehouse_Customer)
            +
            (SELECT COUNT(*)
             FROM Rejected_Records)
        )
    ) AS Difference,

    CASE
        WHEN
            (SELECT COUNT(*)
             FROM Source_Customer)
            =
            (
                (SELECT COUNT(*)
                 FROM Warehouse_Customer)
                +
                (SELECT COUNT(*)
                 FROM Rejected_Records)
            )
        THEN 'Reconciled'
        ELSE 'Mismatch'
    END AS Reconciliation_Status;

-- Task 30
/*Find tables having the highest daily growth.*/
select * from batch_master;
select * from source_customer;
select * from staging_customer;
CREATE TABLE Warehouse_Customer2 (
    Load_ID INT PRIMARY KEY,
    Customer_ID INT,
    Customer_Name VARCHAR(100),
    Batch_ID INT
);
INSERT INTO Warehouse_Customer2
(Load_ID, Customer_ID, Customer_Name, Batch_ID)
VALUES
(1,1,'Arun Kumar',101),
(2,2,'Priya Sharma',101),
(3,3,'Rahul Verma',101),
(4,4,'Sneha Reddy',101),
(5,5,'Karthik Rao',101),

(6,6,'Anjali Singh',102),
(7,7,'Vijay Kumar',102),
(8,8,'Divya Nair',102),
(9,9,'Rohit Sharma',102),
(10,10,'Meena Das',102),
(11,11,'Suresh Babu',102),

(12,12,'Pooja Patel',103),
(13,13,'Naveen Raj',103),
(14,14,'Lakshmi Devi',103),
(15,15,'Manoj Kumar',103),
(16,16,'Asha Thomas',103),
(17,17,'Ravi Shankar',103),
(18,18,'Neha Gupta',103),
(19,19,'Ganesh Iyer',103),

(20,20,'Swathi Rao',104),
(21,21,'Ajay Menon',104),
(22,22,'Deepa Nair',104),
(23,23,'Vimal Kumar',104),
(24,24,'Kavya Reddy',104),

(25,25,'Hari Prasad',105),
(26,26,'Nisha Singh',105),
(27,27,'Mohan Das',105),
(28,28,'Rekha Sharma',105),
(29,29,'Sanjay Rao',105),
(30,30,'Divya Kumar',105);
select * from batch_master;
select * from source_customer;
select * from staging_customer;
select * from warehouse_customer2;
SELECT
    b.Batch_Date,
    'Source_Customer' AS Table_Name,
    COUNT(s.Customer_ID) AS Records_Loaded
FROM Batch_Master b
LEFT JOIN Source_Customer s
    ON b.Batch_ID = s.Batch_ID
GROUP BY
    b.Batch_ID,
    b.Batch_Date

UNION ALL

SELECT
    b.Batch_Date,
    'Staging_Customer' AS Table_Name,
    COUNT(s.Customer_ID) AS Records_Loaded
FROM Batch_Master b
LEFT JOIN Staging_Customer s
    ON b.Batch_ID = s.Batch_ID
GROUP BY
    b.Batch_ID,
    b.Batch_Date

UNION ALL

SELECT
    b.Batch_Date,
    'Warehouse_Customer' AS Table_Name,
    COUNT(w.Customer_ID) AS Records_Loaded
FROM Batch_Master b
LEFT JOIN Warehouse_Customer2 w
    ON b.Batch_ID = w.Batch_ID
GROUP BY
    b.Batch_ID,
    b.Batch_Date

ORDER BY
    Batch_Date,
    Table_Name;
    
    
-- Module 4 – Banking Data Engineering (Tasks 31–40)

-- Task 31--OUTPUT
/*Generate branch-wise total deposits.*/

CREATE TABLE Branch (
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(100),
    City VARCHAR(100)
);
INSERT INTO Branch
VALUES
(1,'Chennai Branch','Chennai'),
(2,'Bengaluru Branch','Bengaluru'),
(3,'Hyderabad Branch','Hyderabad'),
(4,'Mumbai Branch','Mumbai'),
(5,'Delhi Branch','Delhi');

CREATE TABLE Account (
    Account_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Branch_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(12,2),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID)
);

INSERT INTO Account VALUES
(101,'Aarav',1,'Savings',25000),
(102,'Diya',1,'Savings',32000),
(103,'Rahul',1,'Current',45000),
(104,'Sneha',1,'Savings',28000),
(105,'Arjun',1,'Current',50000),

(106,'Priya',2,'Savings',22000),
(107,'Karan',2,'Current',41000),
(108,'Meera',2,'Savings',36000),
(109,'Rohan',2,'Current',47000),
(110,'Nikhil',2,'Savings',29000),

(111,'Neha',3,'Savings',26000),
(112,'Vikram',3,'Current',43000),
(113,'Ananya',3,'Savings',31000),
(114,'Harish',3,'Current',52000),
(115,'Deepa',3,'Savings',34000),

(116,'Simran',4,'Savings',28000),
(117,'Tarun',4,'Current',39000),
(118,'Bhavana',4,'Savings',33000),
(119,'Yash',4,'Current',48000),
(120,'Pooja',4,'Savings',27000),

(121,'Aisha',5,'Savings',24000),
(122,'Manish',5,'Current',46000),
(123,'Ritika',5,'Savings',30000),
(124,'Siddharth',5,'Current',55000),
(125,'Kavya',5,'Savings',35000),

(126,'Gaurav',1,'Savings',26000),
(127,'Ishita',2,'Savings',37000),
(128,'Mohit',3,'Current',49000),
(129,'Nandhini',4,'Savings',31000),
(130,'Aditya',5,'Current',53000);

CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(12,2),
    Transaction_Date DATE,
    FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID)
);

INSERT INTO Transactions VALUES
(1,101,'Deposit',5000,'2026-08-01'),
(2,102,'Deposit',7000,'2026-08-01'),
(3,103,'Withdrawal',3000,'2026-08-01'),
(4,104,'Deposit',6000,'2026-08-01'),
(5,105,'Deposit',9000,'2026-08-02'),
(6,106,'Deposit',4500,'2026-08-02'),
(7,107,'Withdrawal',2500,'2026-08-02'),
(8,108,'Deposit',8000,'2026-08-02'),
(9,109,'Deposit',7500,'2026-08-03'),
(10,110,'Deposit',6500,'2026-08-03'),
(11,111,'Deposit',5200,'2026-08-03'),
(12,112,'Withdrawal',4000,'2026-08-03'),
(13,113,'Deposit',6100,'2026-08-04'),
(14,114,'Deposit',9500,'2026-08-04'),
(15,115,'Deposit',4300,'2026-08-04'),
(16,116,'Deposit',7200,'2026-08-05'),
(17,117,'Withdrawal',3500,'2026-08-05'),
(18,118,'Deposit',8100,'2026-08-05'),
(19,119,'Deposit',9200,'2026-08-05'),
(20,120,'Deposit',5100,'2026-08-05'),
(21,121,'Deposit',4800,'2026-08-06'),
(22,122,'Deposit',8600,'2026-08-06'),
(23,123,'Withdrawal',3000,'2026-08-06'),
(24,124,'Deposit',9700,'2026-08-06'),
(25,125,'Deposit',6400,'2026-08-06'),
(26,126,'Deposit',5800,'2026-08-07'),
(27,127,'Deposit',6900,'2026-08-07'),
(28,128,'Deposit',8800,'2026-08-07'),
(29,129,'Deposit',5600,'2026-08-07'),
(30,130,'Deposit',9100,'2026-08-07'),
(31,101,'Deposit',3000,'2026-08-08'),
(32,106,'Deposit',2500,'2026-08-08'),
(33,111,'Deposit',4000,'2026-08-08'),
(34,116,'Deposit',3500,'2026-08-08'),
(35,121,'Deposit',4200,'2026-08-08'),
(36,102,'Deposit',2000,'2026-08-09'),
(37,108,'Deposit',1500,'2026-08-09'),
(38,113,'Deposit',2200,'2026-08-09'),
(39,118,'Deposit',1800,'2026-08-09'),
(40,124,'Deposit',2600,'2026-08-09'),
(41,105,'Deposit',5000,'2026-08-10'),
(42,110,'Deposit',3200,'2026-08-10'),
(43,114,'Deposit',4100,'2026-08-10'),
(44,119,'Deposit',3600,'2026-08-10'),
(45,130,'Deposit',4700,'2026-08-10');

SELECT * FROM TRANSACTIONS;
SELECT * FROM Account;
SELECT * FROM Branch ;
USE MINIPROJECT;

SELECT BRANCH_NAME, SUM(T.AMOUNT) AS TOTAL_DEPOSITE_AMOUNT FROM BRANCH B
JOIN ACCOUNT A 
ON B.BRANCH_ID= A.BRANCH_ID
JOIN TRANSACTIONS T
ON A.ACCOUNT_ID = T.ACCOUNT_ID
WHERE T.TRANSACTION_TYPE = 'DEPOSIT'
GROUP BY B.BRANCH_ID
ORDER BY TOTAL_DEPOSITE_AMOUNT DESC;
 

-- Task 32
/*Identify customers with multiple active accounts.*/

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Customer VALUES
(1,'Aarav Sharma','Mumbai'),
(2,'Diya Patel','Ahmedabad'),
(3,'Rahul Verma','Delhi'),
(4,'Sneha Reddy','Hyderabad'),
(5,'Arjun Nair','Kochi'),
(6,'Priya Iyer','Chennai'),
(7,'Karan Singh','Jaipur'),
(8,'Meera Joshi','Pune'),
(9,'Rohan Gupta','Lucknow'),
(10,'Ananya Das','Kolkata'),
(11,'Vikram Rao','Bengaluru'),
(12,'Pooja Sharma','Mumbai'),
(13,'Nikhil Jain','Indore'),
(14,'Kavya Menon','Kochi'),
(15,'Aditya Kulkarni','Nagpur'),
(16,'Neha Kapoor','Chandigarh'),
(17,'Siddharth Roy','Patna'),
(18,'Aisha Khan','Bhopal'),
(19,'Manish Kumar','Ranchi'),
(20,'Ritika Sinha','Surat');
CREATE TABLE Account2 (
    Account_ID INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Status VARCHAR(20),
    Balance DECIMAL(10,2),
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
);
INSERT INTO Account2 VALUES
(101,1,'Savings','Active',50000),
(102,1,'Current','Active',30000),

(103,2,'Savings','Active',25000),
(104,2,'Current','Closed',12000),

(105,3,'Savings','Active',40000),
(106,3,'Current','Active',18000),

(107,4,'Savings','Active',35000),

(108,5,'Savings','Active',27000),
(109,5,'Current','Active',15000),

(110,6,'Savings','Closed',20000),

(111,7,'Savings','Active',33000),
(112,7,'Current','Active',25000),

(113,8,'Savings','Active',45000),

(114,9,'Savings','Closed',10000),

(115,10,'Savings','Active',42000),
(116,10,'Current','Active',22000),

(117,11,'Savings','Active',28000),

(118,12,'Savings','Closed',31000),

(119,13,'Savings','Active',26000),

(120,14,'Savings','Active',47000),

(121,15,'Savings','Active',29000),

(122,16,'Savings','Closed',21000),

(123,17,'Savings','Active',39000),

(124,18,'Savings','Active',36000),

(125,19,'Savings','Closed',18000),

(126,20,'Savings','Active',44000),

(127,8,'Current','Active',14000),
(128,11,'Current','Closed',9000),
(129,16,'Current','Active',17000),
(130,18,'Current','Active',20000);
SELECT * FROM CUSTOMER;
SELECT * FROM ACCOUNT2;
SELECT C.CUSTOMER_NAME, C.CUSTOMER_ID, COUNT(A2.ACCOUNT_ID) AS NUMBER_OF_ACTIVE_ACC FROM CUSTOMER C
INNER JOIN ACCOUNT2 A2
ON C.CUSTOMER_ID = A2.CUSTOMER_ID
GROUP BY A2.STATUS, A2.CUSTOMER_ID
HAVING NUMBER_OF_ACTIVE_ACC > 1;

-- Task 33
/*Display the latest transaction for every account.*/
CREATE TABLE Account3
(
    Account_ID INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(10,2),
    Status VARCHAR(20)
);

INSERT INTO Account3 VALUES
(1001,101,'Savings',50000,'Active'),
(1002,101,'Current',30000,'Active'),
(1003,102,'Savings',45000,'Active'),
(1004,103,'Savings',60000,'Active'),
(1005,103,'Current',25000,'Active'),
(1006,104,'Savings',52000,'Closed'),
(1007,105,'Savings',48000,'Active'),
(1008,105,'Current',22000,'Active'),
(1009,106,'Savings',55000,'Active'),
(1010,107,'Savings',39000,'Active'),
(1011,107,'Current',26000,'Active'),
(1012,108,'Savings',47000,'Closed'),
(1013,109,'Savings',51000,'Active'),
(1014,110,'Savings',62000,'Active'),
(1015,110,'Current',28000,'Active'),
(1016,111,'Savings',45000,'Active'),
(1017,112,'Savings',43000,'Closed'),
(1018,113,'Savings',58000,'Active'),
(1019,114,'Savings',49000,'Active'),
(1020,115,'Savings',61000,'Closed'),
(1021,116,'Savings',46000,'Active'),
(1022,117,'Savings',52000,'Active'),
(1023,118,'Savings',41000,'Closed'),
(1024,119,'Savings',59000,'Active'),
(1025,120,'Savings',54000,'Active'),
(1026,116,'Current',24000,'Closed'),
(1027,118,'Current',26000,'Closed'),
(1028,119,'Current',27000,'Closed'),
(1029,120,'Current',29000,'Closed'),
(1030,112,'Current',31000,'Active');
CREATE TABLE TransactionS1
(
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT,
    Transaction_Type VARCHAR(20),
    Transaction_Amount DECIMAL(10,2),
    Transaction_Date DATE,
    FOREIGN KEY(Account_ID)
    REFERENCES Account3(Account_ID)
);

INSERT INTO Transactions1 VALUES
(1,1001,'Deposit',5000,'2026-08-01'),
(2,1001,'Withdrawal',1000,'2026-08-05'),

(3,1002,'Deposit',7000,'2026-08-02'),
(4,1002,'Withdrawal',2000,'2026-08-06'),

(5,1003,'Deposit',6000,'2026-08-03'),
(6,1003,'Deposit',2500,'2026-08-08'),

(7,1004,'Withdrawal',1500,'2026-08-04'),
(8,1004,'Deposit',4000,'2026-08-10'),

(9,1005,'Deposit',8000,'2026-08-05'),
(10,1005,'Withdrawal',1000,'2026-08-11'),

(11,1006,'Deposit',9000,'2026-08-06'),
(12,1006,'Withdrawal',3000,'2026-08-12'),

(13,1007,'Deposit',4500,'2026-08-07'),
(14,1007,'Deposit',5500,'2026-08-13'),

(15,1008,'Withdrawal',2500,'2026-08-08'),
(16,1008,'Deposit',6500,'2026-08-14'),

(17,1009,'Deposit',5000,'2026-08-09'),
(18,1009,'Withdrawal',1500,'2026-08-15'),

(19,1010,'Deposit',6200,'2026-08-10'),
(20,1010,'Deposit',3200,'2026-08-16'),

(21,1011,'Withdrawal',2200,'2026-08-11'),
(22,1011,'Deposit',4200,'2026-08-17'),

(23,1012,'Deposit',3000,'2026-08-12'),
(24,1012,'Withdrawal',1000,'2026-08-18'),

(25,1013,'Deposit',7100,'2026-08-13'),
(26,1013,'Withdrawal',2100,'2026-08-19'),

(27,1014,'Deposit',8500,'2026-08-14'),
(28,1014,'Deposit',2500,'2026-08-20'),

(29,1015,'Withdrawal',3200,'2026-08-15'),
(30,1015,'Deposit',7200,'2026-08-21'),

(31,1016,'Deposit',5100,'2026-08-16'),
(32,1016,'Withdrawal',1100,'2026-08-22'),

(33,1017,'Deposit',4300,'2026-08-17'),
(34,1017,'Deposit',6300,'2026-08-23'),

(35,1018,'Withdrawal',2300,'2026-08-18'),
(36,1018,'Deposit',8300,'2026-08-24'),

(37,1019,'Deposit',9100,'2026-08-19'),
(38,1019,'Withdrawal',3100,'2026-08-25'),

(39,1020,'Deposit',4700,'2026-08-20'),
(40,1020,'Deposit',6700,'2026-08-26'),

(41,1021,'Withdrawal',1200,'2026-08-21'),
(42,1021,'Deposit',5200,'2026-08-27'),

(43,1022,'Deposit',7600,'2026-08-22'),
(44,1022,'Withdrawal',2600,'2026-08-28'),

(45,1023,'Deposit',4800,'2026-08-29');

SELECT * FROM Account3;
SELECT * FROM TRANSACTIONS1;
SELECT * FROM CUSTOMER;

WITH LATEST_TRANSACTION AS
(
SELECT ACCOUNT_ID,TRANSACTION_DATE, TRANSACTION_TYPE, TRANSACTION_AMOUNT, row_number()
OVER
(
PARTITION BY ACCOUNT_ID
ORDER BY TRANSACTION_DATE DESC
) AS RN
FROM TRANSACTIONS1
)
SELECT ACCOUNT_ID,TRANSACTION_DATE, TRANSACTION_TYPE, TRANSACTION_AMOUNT FROM LATEST_TRANSACTION
WHERE RN= 1
ORDER BY ACCOUNT_ID;

-- Task 34- NOOUTPUT
/*Rank customers based on transaction amount.*/
SELECT * FROM Account3;
SELECT * FROM TRANSACTIONS1;
SELECT * FROM CUSTOMER;
SELECT
    c.Customer_Name,
    SUM(t.transaction_Amount) AS Total_Transaction_Amount,

    RANK() OVER (
        ORDER BY SUM(t.transaction_Amount) DESC
    ) AS Customer_Rank

FROM Customer c
JOIN Account3 a
    ON c.Customer_ID = a.Customer_ID
JOIN Transactions1 t
    ON a.Account_ID = t.Account_ID

GROUP BY
    c.Customer_ID,
    c.Customer_Name

ORDER BY
    Customer_Rank;


-- Task 35
/*Identify suspicious transactions greater than three times the customers average transaction amount.*/
CREATE TABLE Customer2 (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100)
);
CREATE TABLE Account1 (
    Account_ID INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(12,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customer2(Customer_ID)
);

CREATE TABLE Transaction1 (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT,
    Transaction_Date DATE,
    Transaction_Amount DECIMAL(12,2),
    Transaction_Type VARCHAR(20),
    FOREIGN KEY (Account_ID) REFERENCES Account1(Account_ID)
);

INSERT INTO Customer2 VALUES
(1,'Aarav'),
(2,'Bhavya'),
(3,'Charan'),
(4,'Deepika'),
(5,'Eshan'),
(6,'Farah'),
(7,'Gokul'),
(8,'Harini'),
(9,'Ishaan'),
(10,'Janani'),
(11,'Karan'),
(12,'Lavanya'),
(13,'Manoj'),
(14,'Nithya'),
(15,'Omkar'),
(16,'Priya'),
(17,'Rahul'),
(18,'Sneha'),
(19,'Tarun'),
(20,'Varun');
INSERT INTO Account1 VALUES
(101,1,'Savings',80000),
(102,1,'Current',120000),
(103,2,'Savings',60000),
(104,2,'Current',90000),
(105,3,'Savings',70000),
(106,4,'Savings',50000),
(107,5,'Current',150000),
(108,6,'Savings',40000),
(109,7,'Savings',30000),
(110,8,'Current',95000),
(111,9,'Savings',65000),
(112,10,'Savings',72000),
(113,11,'Current',83000),
(114,12,'Savings',55000),
(115,13,'Savings',78000),
(116,14,'Current',92000),
(117,15,'Savings',47000),
(118,16,'Savings',88000),
(119,17,'Current',99000),
(120,18,'Savings',51000),
(121,19,'Savings',68000),
(122,20,'Current',105000),
(123,3,'Current',95000),
(124,5,'Savings',48000),
(125,7,'Current',87000),
(126,10,'Current',93000),
(127,12,'Current',76000),
(128,15,'Current',61000),
(129,18,'Current',85000),
(130,20,'Savings',73000);
INSERT INTO Transaction1 VALUES
(1,101,'2026-08-01',5000,'Deposit'),
(2,101,'2026-08-05',6000,'Withdrawal'),
(3,101,'2026-08-10',45000,'Transfer'),

(4,102,'2026-08-02',7000,'Deposit'),
(5,102,'2026-08-06',6500,'Withdrawal'),

(6,103,'2026-08-03',4000,'Deposit'),
(7,103,'2026-08-08',4200,'Withdrawal'),
(8,103,'2026-08-15',30000,'Transfer'),

(9,104,'2026-08-04',8000,'Deposit'),
(10,104,'2026-08-09',8200,'Withdrawal'),

(11,105,'2026-08-01',5500,'Deposit'),
(12,105,'2026-08-07',6000,'Withdrawal'),

(13,106,'2026-08-02',3500,'Deposit'),
(14,106,'2026-08-12',3600,'Withdrawal'),

(15,107,'2026-08-05',10000,'Deposit'),
(16,107,'2026-08-18',75000,'Transfer'),

(17,108,'2026-08-06',4200,'Deposit'),
(18,109,'2026-08-07',3900,'Withdrawal'),

(19,110,'2026-08-08',6500,'Deposit'),
(20,111,'2026-08-09',7000,'Withdrawal'),

(21,112,'2026-08-10',5200,'Deposit'),
(22,113,'2026-08-11',5800,'Withdrawal'),

(23,114,'2026-08-12',6100,'Deposit'),
(24,115,'2026-08-13',6300,'Withdrawal'),

(25,116,'2026-08-14',7200,'Deposit'),
(26,117,'2026-08-15',4300,'Withdrawal'),

(27,118,'2026-08-16',8200,'Deposit'),
(28,119,'2026-08-17',9000,'Withdrawal'),

(29,120,'2026-08-18',4800,'Deposit'),
(30,121,'2026-08-19',5100,'Withdrawal'),

(31,122,'2026-08-20',9500,'Deposit'),
(32,123,'2026-08-21',11000,'Deposit'),
(33,124,'2026-08-22',5300,'Withdrawal'),

(34,125,'2026-08-23',25000,'Transfer'),
(35,126,'2026-08-24',6800,'Deposit'),

(36,127,'2026-08-25',7100,'Withdrawal'),
(37,128,'2026-08-26',4700,'Deposit'),

(38,129,'2026-08-27',52000,'Transfer'),
(39,130,'2026-08-28',6900,'Withdrawal'),

(40,102,'2026-08-29',6200,'Deposit'),
(41,105,'2026-08-30',5700,'Withdrawal'),
(42,108,'2026-08-30',4100,'Deposit'),
(43,110,'2026-08-30',6900,'Withdrawal'),
(44,118,'2026-08-31',8400,'Deposit'),
(45,122,'2026-08-31',9800,'Withdrawal');
SELECT * FROM customer2;
SELECT * FROM Account1;
SELECT * FROM Transaction1;

SELECT C.CUSTOMER_NAME,A. ACCOUNT_ID,T.TRANSACTION_DATE, T.TRANSACTION_AMOUNT,
(
SELECT AVG(TRANSACTION_AMOUNT) FROM TRANSACTION1 T
JOIN ACCOUNT1 A
ON  T.ACCOUNT_ID= A.ACCOUNT_ID
) AS CUSTOMER_AVERAGE_TRANSACTION_AMOUNT
FROM CUSTOMER2 C
JOIN ACCOUNT1 A
ON C.CUSTOMER_ID = A.CUSTOMER_ID
JOIN TRANSACTION1 T
ON A.ACCOUNT_ID = T.ACCOUNT_ID
WHERE T.TRANSACTION_AMOUNT>(SELECT 3*AVG(T.Transaction_Amount)
 FROM TRANSACTION1 T
)
ORDER BY c.Customer_Name;

-- Task 36
USE MINIPROJECT;
/*Create a View for branch-wise transaction summary.*/
SELECT * FROM BRANCH;
SELECT * FROM ACCOUNT;
SELECT * FROM TRANSACTIONS;

CREATE VIEW Branch_Transaction_Summary AS
SELECT
    b.Branch_Name,
    COUNT(t.Transaction_ID) AS Total_Transactions,
    SUM(CASE
            WHEN t.Transaction_Type='Deposit'
            THEN t.Amount
            ELSE 0
        END) AS Total_Deposit_Amount,
    SUM(CASE
            WHEN t.Transaction_Type='Withdrawal'
            THEN t.Amount
            ELSE 0
        END) AS Total_Withdrawal_Amount
FROM Branch b
JOIN Account a
ON b.Branch_ID=a.Branch_ID
JOIN Transactions t
ON a.Account_ID=t.Account_ID
GROUP BY b.Branch_Name;

SELECT * 
FROM Branch_Transaction_Summary;

-- Task 37
/*Write a Stored Procedure to generate customer account statements.*/
DELIMITER $$

CREATE PROCEDURE Get_Account_Statement
(
    IN p_Account_ID INT
)
BEGIN

    SELECT
        a.Account_ID,
        t.Transaction_Date,
        t.Transaction_Type,
        t.Amount,
        a.Balance AS Current_Balance
    FROM Account a
    JOIN Transactions t
        ON a.Account_ID = t.Account_ID
    WHERE a.Account_ID = p_Account_ID
    ORDER BY t.Transaction_Date;

END$$
DELIMITER ;

CALL Get_Account_Statement(101);
SHOW CREATE PROCEDURE Get_Account_Statement;

-- Task 38
/*Create a Trigger that stores deleted transaction records into an audit table.*/
SELECT * FROM TRANSACTIONS;
CREATE TABLE Transaction_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Transaction_ID INT,
    Account_ID INT,
    Transaction_Date DATE,
    Transaction_Type VARCHAR(20),
    Transaction_Amount DECIMAL(12,2),
    Deleted_On DATETIME
);
DELIMITER $$

CREATE TRIGGER trg_transaction_audit
AFTER DELETE
ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO Transaction_Audit
    (
        Transaction_ID,
        Account_ID,
        Transaction_Date,
        Transaction_Type,
        Transaction_Amount,
        Deleted_On
    )
    VALUES
    (
        OLD.Transaction_ID,
        OLD.Account_ID,
        OLD.Transaction_Date,
        OLD.Transaction_Type,
        OLD.Amount,
        NOW()
    );
END$$
DELIMITER ;

DELETE FROM Transactions
WHERE Transaction_ID = 5;

DELETE FROM Transactions
WHERE Transaction_ID = 8;
SELECT * FROM Transactions;

-- Task 39
/*Create a BEFORE INSERT Trigger to reject transactions with negative amounts.*/
SELECT * FROM TRANSACTIONS;
INSERT INTO Transactions VALUES
(5,103,'Deposit',9000.00,'2026-08-05'),
(8,104,'Withdrawal',2500.00,'2026-08-08');

-- Create BEFORE INSERT Trigger
DELIMITER $$
CREATE TRIGGER trg_validate_transaction
BEFORE INSERT
ON Transactions
FOR EACH ROW
BEGIN
    IF NEW.Amount < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction amount cannot be negative';
    END IF;
END$$
DELIMITER ;
-- Insert a Valid Transaction
INSERT INTO Transactions
VALUES
(11,106,'Deposit',-6000.00,'2026-08-11');

-- Task 40
/*Recommend appropriate indexes to improve transaction search performance.*/

CREATE TABLE Acc (
    Account_ID INT PRIMARY KEY,
    Customer_ID INT,
    Branch_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(12,2)
);
CREATE TABLE Transaction1 (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT,
    Transaction_Date DATE,
    Transaction_Type VARCHAR(20),
    Transaction_Amount DECIMAL(12,2)
);

INSERT INTO Acc VALUES
(101,1,1,'Savings',50000.00),
(102,2,1,'Current',65000.00),
(103,3,1,'Savings',42000.00),
(104,4,1,'Current',80000.00),
(105,5,1,'Savings',35000.00),

(106,6,2,'Savings',70000.00),
(107,7,2,'Current',55000.00),
(108,8,2,'Savings',62000.00),
(109,9,2,'Current',90000.00),
(110,10,2,'Savings',47000.00),

(111,11,3,'Savings',52000.00),
(112,12,3,'Current',76000.00),
(113,13,3,'Savings',61000.00),
(114,14,3,'Current',83000.00),
(115,15,3,'Savings',45000.00),

(116,16,4,'Savings',71000.00),
(117,17,4,'Current',68000.00),
(118,18,4,'Savings',58000.00),
(119,19,4,'Current',87000.00),
(120,20,4,'Savings',49000.00),

(121,1,5,'Current',91000.00),
(122,2,5,'Savings',62000.00),
(123,3,5,'Current',74000.00),
(124,4,5,'Savings',53000.00),
(125,5,5,'Current',81000.00),
(126,6,5,'Savings',46000.00),
(127,7,5,'Current',67000.00),
(128,8,5,'Savings',59000.00),
(129,9,5,'Current',88000.00),
(130,10,5,'Savings',51000.00);

INSERT INTO Transaction1 VALUES
(1,101,'2026-08-01','Deposit',5000.00),
(2,101,'2026-08-02','Withdrawal',2000.00),
(3,101,'2026-08-05','Deposit',3500.00),
(4,102,'2026-08-03','Deposit',7000.00),
(5,102,'2026-08-06','Withdrawal',2500.00),

(6,103,'2026-08-04','Deposit',4000.00),
(7,103,'2026-08-08','Withdrawal',1500.00),
(8,104,'2026-08-05','Deposit',8000.00),
(9,104,'2026-08-09','Withdrawal',3000.00),
(10,105,'2026-08-06','Deposit',4500.00),

(11,106,'2026-08-07','Deposit',6000.00),
(12,106,'2026-08-10','Withdrawal',2000.00),
(13,107,'2026-08-08','Deposit',5500.00),
(14,107,'2026-08-11','Withdrawal',2500.00),
(15,108,'2026-08-09','Deposit',4200.00),

(16,109,'2026-08-10','Deposit',9000.00),
(17,109,'2026-08-12','Withdrawal',3500.00),
(18,110,'2026-08-11','Deposit',5100.00),
(19,110,'2026-08-14','Withdrawal',1800.00),
(20,111,'2026-08-12','Deposit',6500.00),

(21,112,'2026-08-13','Deposit',7500.00),
(22,112,'2026-08-15','Withdrawal',2800.00),
(23,113,'2026-08-14','Deposit',6200.00),
(24,113,'2026-08-16','Withdrawal',2200.00),
(25,114,'2026-08-15','Deposit',8300.00),

(26,115,'2026-08-16','Deposit',4800.00),
(27,115,'2026-08-18','Withdrawal',1900.00),
(28,116,'2026-08-17','Deposit',7100.00),
(29,117,'2026-08-18','Withdrawal',2600.00),
(30,118,'2026-08-19','Deposit',5400.00),

(31,119,'2026-08-20','Deposit',8700.00),
(32,120,'2026-08-21','Withdrawal',2400.00),
(33,121,'2026-08-22','Deposit',7500.00),
(34,122,'2026-08-23','Withdrawal',2200.00),
(35,123,'2026-08-24','Deposit',6800.00),

(36,124,'2026-08-25','Withdrawal',3000.00),
(37,125,'2026-08-26','Deposit',7200.00),
(38,126,'2026-08-27','Withdrawal',2800.00),
(39,127,'2026-08-28','Deposit',3900.00),
(40,128,'2026-08-29','Withdrawal',2400.00),

(41,129,'2026-08-30','Deposit',6100.00),
(42,130,'2026-08-31','Withdrawal',3500.00),
(43,101,'2026-08-31','Deposit',4500.00),
(44,102,'2026-08-31','Withdrawal',1800.00),
(45,103,'2026-08-31','Deposit',5200.00);
SELECT * FROM ACC;
SELECT * FROM TRANSACTION1;
CREATE INDEX idx_account
ON Transaction1(Account_ID);
CREATE INDEX idx_transaction_date
ON Transaction1(Transaction_Date);
SELECT *
FROM Transaction1
WHERE Account_ID = 101
AND Transaction_Date = '2026-08-10';
EXPLAIN
SELECT *
FROM Transaction1
WHERE Account_ID = 101
AND Transaction_Date = '2026-08-10';

-- MODULE 05
-- Task 41 – Department Salary Analysis using CTE
/*The HR Analytics team wants to calculate the average salary for each department and identify employees earning more than their department average.
To improve readability, the query should use a Common Table Expression (CTE).
Display:
• Department Name
• Employee Name
• Employee Salary
• Department Average Salary
Tables Required
Department
5 Rows
Employee
30 Rows
Additional Requirements
Each department should have employees with different salary values.
Skills Covered
• CTE
• AVG()
• JOIN
• WHERE*/
CREATE TABLE Department1 (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50)
);
INSERT INTO Department1 VALUES
(1, 'Finance'),
(2, 'HR'),
(3, 'IT'),
(4, 'Sales'),
(5, 'Marketing');

CREATE TABLE Employee1 (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (Department_ID)
    REFERENCES Department1(Department_ID)
);

INSERT INTO Employee1 VALUES
(101, 'Aarav',   1, 85000.00),
(102, 'Bhavya',  1, 65000.00),
(103, 'Charan',  1, 72000.00),
(104, 'Deepika', 1, 95000.00),
(105, 'Eshan',   1, 68000.00),
(106, 'Farah',   1, 78000.00),

(107, 'Gokul',   2, 55000.00),
(108, 'Harini',  2, 72000.00),
(109, 'Ishaan',  2, 48000.00),
(110, 'Janani',  2, 65000.00),
(111, 'Karan',   2, 58000.00),
(112, 'Lavanya', 2, 80000.00),

(113, 'Manoj',   3, 95000.00),
(114, 'Nithya',  3, 88000.00),
(115, 'Omkar',   3, 75000.00),
(116, 'Priya',   3, 105000.00),
(117, 'Rahul',   3, 82000.00),
(118, 'Sneha',   3, 92000.00),

(119, 'Tarun',   4, 60000.00),
(120, 'Varun',   4, 72000.00),
(121, 'Ananya',  4, 55000.00),
(122, 'Rohan',   4, 68000.00),
(123, 'Meera',   4, 80000.00),
(124, 'Vikas',   4, 63000.00),

(125, 'Neha',    5, 58000.00),
(126, 'Aditya',  5, 75000.00),
(127, 'Pooja',   5, 62000.00),
(128, 'Kavya',   5, 85000.00),
(129, 'Arjun',   5, 70000.00),
(130, 'Sonia',   5, 65000.00);
WITH Department_Average AS
(
    SELECT
        Department_ID,
        AVG(Salary) AS Department_Average_Salary
    FROM Employee1
    GROUP BY Department_ID
)
SELECT
    d.Department_Name,
    e.Employee_Name,
    e.Salary AS Employee_Salary,
    da.Department_Average_Salary
FROM Employee1 e
JOIN Department1 d
    ON e.Department_ID = d.Department_ID
JOIN Department_Average da
    ON e.Department_ID = da.Department_ID
WHERE e.Salary > da.Department_Average_Salary
ORDER BY d.Department_Name, e.Salary DESC;


-- Task 42 – Top Five Products per Category
CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(50)
);
INSERT INTO Category VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Furniture'),
(4, 'Books'),
(5, 'Sports');

CREATE TABLE Product1 (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category_ID INT,
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);
INSERT INTO Product1 VALUES

(101, 'Laptop', 1),
(102, 'Mobile Phone', 1),
(103, 'Headphones', 1),
(104, 'Smart Watch', 1),
(105, 'Tablet', 1),
(106, 'T-Shirt', 2),
(107, 'Jeans', 2),
(108, 'Jacket', 2),
(109, 'Sneakers', 2),
(110, 'Hoodie', 2),
(111, 'Office Chair', 3),
(112, 'Dining Table', 3),
(113, 'Sofa', 3),
(114, 'Bookshelf', 3),
(115, 'Bed', 3),
(116, 'SQL Basics', 4),
(117, 'Python Guide', 4),
(118, 'Data Science', 4),
(119, 'Machine Learning', 4),
(120, 'Cloud Computing', 4),
(121, 'Football', 5),
(122, 'Cricket Bat', 5),
(123, 'Tennis Racket', 5),
(124, 'Basketball', 5),
(125, 'Running Shoes', 5);

CREATE TABLE Fact_Sales (
    Sales_ID INT PRIMARY KEY,
    Product_ID INT,
    Sales_Amount DECIMAL(12,2),
    FOREIGN KEY (Product_ID) REFERENCES Product1(Product_ID)
);
INSERT INTO Fact_Sales VALUES
(1,101,85000),
(2,101,72000),
(3,102,65000),
(4,102,58000),
(5,103,25000),
(6,104,18000),
(7,105,45000),
(8,103,22000),
(9,104,15000),

(10,106,12000),
(11,106,15000),
(12,107,28000),
(13,108,18000),
(14,109,32000),
(15,110,14000),
(16,107,25000),
(17,109,30000),
(18,108,16000),

(19,111,45000),
(20,112,65000),
(21,113,85000),
(22,114,32000),
(23,115,95000),
(24,111,40000),
(25,112,55000),
(26,113,75000),
(27,115,88000),

(28,116,18000),
(29,117,25000),
(30,118,42000),
(31,119,55000),
(32,120,38000),
(33,116,15000),
(34,118,35000),
(35,119,48000),

(36,121,22000),
(37,122,45000),
(38,123,38000),
(39,124,30000),
(40,125,65000),
(41,121,18000),
(42,122,42000),
(43,123,35000),
(44,124,28000),
(45,125,58000);

WITH Product_Sales AS
(
    SELECT
        c.Category_Name,
        p.Product_Name,
        SUM(fs.Sales_Amount) AS Total_Sales
    FROM Category c
    JOIN Product1 p
        ON c.Category_ID = p.Category_ID
    JOIN Fact_Sales fs
        ON p.Product_ID = fs.Product_ID
    GROUP BY
        c.Category_Name,
        p.Product_Name
),
Product_Ranking AS
(
    SELECT
        Category_Name,
        Product_Name,
        Total_Sales,
        DENSE_RANK() OVER
        (
            PARTITION BY Category_Name
            ORDER BY Total_Sales DESC
        ) AS Product_Rank
    FROM Product_Sales
)
SELECT
    Category_Name,
    Product_Name,
    Total_Sales,
    Product_Rank AS PRank
FROM Product_Ranking
WHERE Product_Rank <= 5
ORDER BY
    Category_Name,
    Product_Rank;
    
-- Task 43 – Temporary Table for Top-Selling Products
    
    SELECT * FROM product2;
    SELECT * FROM fact_sales;
    CREATE TEMPORARY TABLE Top_Selling_Products AS
SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,
    SUM(fs.Sales_Amount) AS Total_Sales
FROM Product2 p
JOIN Fact_Sales fs
    ON p.Product_ID = fs.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category;
    
    SELECT *
FROM Top_Selling_Products
ORDER BY Total_Sales DESC;

SELECT *
FROM Top_Selling_Products
ORDER BY Total_Sales DESC
LIMIT 5;
SELECT
    Category,
    SUM(Total_Sales) AS Category_Total_Sales
FROM Top_Selling_Products
GROUP BY Category
ORDER BY Category_Total_Sales DESC;
DROP TEMPORARY TABLE IF EXISTS Top_Selling_Products;
CREATE TEMPORARY TABLE Top_Selling_Products AS
SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,
    SUM(fs.Sales_Amount) AS Total_Sales
FROM Product2 p
JOIN Fact_Sales fs
    ON p.Product_ID = fs.Product_ID
GROUP BY p.Product_ID, p.Product_Name, p.Category;
SELECT *
FROM Top_Selling_Products
ORDER BY Total_Sales DESC;

-- Task 44 – Stored Procedure for Warehouse Loading
CREATE TABLE Staging_Sales (
    Sales_ID INT,
    Product_ID INT,
    Sales_Amount DECIMAL(12,2),
    Validation_Status VARCHAR(20)
);
INSERT INTO Staging_Sales VALUES
(1,101,85000,'Valid'),
(2,102,45000,'Valid'),
(3,103,25000,'Invalid'),
(4,104,18000,'Valid'),
(5,105,45000,'Valid'),

(6,106,12000,'Invalid'),
(7,107,28000,'Valid'),
(8,108,18000,'Valid'),
(9,109,32000,'Valid'),
(10,110,14000,'Invalid'),

(11,111,45000,'Valid'),
(12,112,65000,'Valid'),
(13,113,85000,'Invalid'),
(14,114,32000,'Valid'),
(15,115,95000,'Valid'),

(16,116,18000,'Valid'),
(17,117,25000,'Invalid'),
(18,118,42000,'Valid'),
(19,119,55000,'Valid'),
(20,120,38000,'Valid'),

(21,121,22000,'Invalid'),
(22,122,45000,'Valid'),
(23,123,38000,'Valid'),
(24,124,30000,'Valid'),
(25,125,65000,'Invalid'),

(26,101,72000,'Valid'),
(27,102,58000,'Valid'),
(28,103,22000,'Invalid'),
(29,104,15000,'Valid'),
(30,105,38000,'Valid'),

(31,106,15000,'Valid'),
(32,107,25000,'Invalid'),
(33,108,16000,'Valid'),
(34,109,30000,'Valid'),
(35,110,14000,'Valid'),

(36,111,40000,'Invalid'),
(37,112,55000,'Valid'),
(38,113,75000,'Valid'),
(39,114,28000,'Valid'),
(40,115,88000,'Invalid'),

(41,116,15000,'Valid'),
(42,117,20000,'Valid'),
(43,118,35000,'Invalid'),
(44,119,48000,'Valid'),
(45,120,38000,'Valid');
SELECT * FROM fact_sales;
SELECT * FROM Staging_Sales;
DELIMITER $$

CREATE PROCEDURE Load_Valid_Sales()
BEGIN

    INSERT INTO Fact_Sales
    (
        Sales_ID,
        Product_ID,
        Sales_Amount
    )
    SELECT
        Sales_ID,
        Product_ID,
        Sales_Amount
    FROM Staging_Sales
    WHERE Validation_Status = 'Valid';

END$$

DELIMITER ;
CALL Load_Valid_Sales();

SELECT COUNT(*) AS Valid_Records -- VALID RECORDS LOADED
FROM Fact_Sales;

SELECT *
FROM Staging_Sales
WHERE Validation_Status = 'Invalid'; -- INVALID RECORDS

INSERT INTO Fact_Sales
(
    Sales_ID,
    Product_ID,
    Sales_Amount
)
SELECT
    Sales_ID,
    Product_ID,
    Sales_Amount
FROM Staging_Sales
WHERE Validation_Status = 'Valid';

-- Task 45 – Fact Table Audit Trigger

CREATE TABLE Fact_Sale (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Sale_Date DATE,
    Quantity INT,
    Amount DECIMAL(10,2)
);
INSERT INTO Fact_Sale
(Sale_ID, Customer_ID, Product_ID, Sale_Date, Quantity, Amount)
VALUES
(1, 101, 201, '2026-01-01', 2, 500.00),
(2, 102, 202, '2026-01-02', 1, 250.00),
(3, 103, 203, '2026-01-03', 3, 750.00),
(4, 104, 204, '2026-01-04', 2, 600.00),
(5, 105, 205, '2026-01-05', 1, 150.00),
(6, 106, 206, '2026-01-06', 4, 1200.00),
(7, 107, 207, '2026-01-07', 2, 450.00),
(8, 108, 208, '2026-01-08', 1, 300.00),
(9, 109, 209, '2026-01-09', 3, 900.00),
(10, 110, 210, '2026-01-10', 2, 700.00),

(11, 111, 201, '2026-01-11', 1, 250.00),
(12, 112, 202, '2026-01-12', 2, 500.00),
(13, 113, 203, '2026-01-13', 4, 1000.00),
(14, 114, 204, '2026-01-14', 1, 300.00),
(15, 115, 205, '2026-01-15', 3, 450.00),
(16, 116, 206, '2026-01-16', 2, 600.00),
(17, 117, 207, '2026-01-17', 1, 225.00),
(18, 118, 208, '2026-01-18', 3, 900.00),
(19, 119, 209, '2026-01-19', 2, 600.00),
(20, 120, 210, '2026-01-20', 1, 350.00),

(21, 121, 201, '2026-01-21', 2, 500.00),
(22, 122, 202, '2026-01-22', 3, 750.00),
(23, 123, 203, '2026-01-23', 1, 250.00),
(24, 124, 204, '2026-01-24', 2, 600.00),
(25, 125, 205, '2026-01-25', 4, 600.00),
(26, 126, 206, '2026-01-26', 1, 300.00),
(27, 127, 207, '2026-01-27', 2, 450.00),
(28, 128, 208, '2026-01-28', 3, 900.00),
(29, 129, 209, '2026-01-29', 1, 300.00),
(30, 130, 210, '2026-01-30', 2, 700.00),

(31, 131, 201, '2026-02-01', 3, 750.00),
(32, 132, 202, '2026-02-02', 1, 250.00),
(33, 133, 203, '2026-02-03', 2, 500.00),
(34, 134, 204, '2026-02-04', 3, 900.00),
(35, 135, 205, '2026-02-05', 2, 300.00),
(36, 136, 206, '2026-02-06', 4, 1200.00),
(37, 137, 207, '2026-02-07', 1, 225.00),
(38, 138, 208, '2026-02-08', 2, 600.00),
(39, 139, 209, '2026-02-09', 3, 900.00),
(40, 140, 210, '2026-02-10', 1, 350.00),

(41, 141, 201, '2026-02-11', 2, 500.00),
(42, 142, 202, '2026-02-12', 1, 250.00),
(43, 143, 203, '2026-02-13', 3, 750.00),
(44, 144, 204, '2026-02-14', 2, 600.00),
(45, 145, 205, '2026-02-15', 1, 150.00);

CREATE TABLE Fact_Sales_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Sale_ID INT,
    Action_Type VARCHAR(20),
    Action_Date DATETIME
);

-- Create AFTER INSERT Trigger
DELIMITER //

CREATE TRIGGER trg_fact_sales_after_insert
AFTER INSERT ON Fact_Sale
FOR EACH ROW
BEGIN
    INSERT INTO Fact_Sales_Audit
    (Sale_ID, Action_Type, Action_Date)
    VALUES
    (NEW.Sale_ID, 'INSERT', NOW());
END //
DELIMITER ;

INSERT INTO Fact_Sale
VALUES (46, 146, 206, '2026-02-16', 2, 500.00);

-- Create AFTER UPDATE Trigger
DELIMITER //

CREATE TRIGGER trg_fact_sales_after_update
AFTER UPDATE ON Fact_Sale
FOR EACH ROW
BEGIN
    INSERT INTO Fact_Sales_Audit
    (Sale_ID, Action_Type, Action_Date)
    VALUES
    (NEW.Sale_ID, 'UPDATE', NOW());
END //

DELIMITER ;

-- Create AFTER DELETE Trigger
DELIMITER //

CREATE TRIGGER trg_fact_sales_after_delete
AFTER DELETE ON Fact_Sale
FOR EACH ROW
BEGIN
    INSERT INTO Fact_Sales_Audit
    (Sale_ID, Action_Type, Action_Date)
    VALUES
    (OLD.Sale_ID, 'DELETE', NOW());
END //

DELIMITER ;

INSERT INTO Fact_Sale
(Sale_ID, Customer_ID, Product_ID, Sale_Date, Quantity, Amount)
VALUES
(47, 146, 206, '2026-02-16', 2, 500.00);

SELECT *
FROM Fact_Sales_Audit;

-- Task 46 – Business Reporting View
/*Business users require a consolidated report that combines customer, order, and sales information.*/

select * from customer;
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
INSERT INTO Orders
(Order_ID, Customer_ID, Order_Date)
VALUES
(1001, 1, '2026-01-01'),
(1002, 2, '2026-01-02'),
(1003, 3, '2026-01-03'),
(1004, 4, '2026-01-04'),
(1005, 5, '2026-01-05'),
(1006, 6, '2026-01-06'),
(1007, 7, '2026-01-07'),
(1008, 8, '2026-01-08'),
(1009, 9, '2026-01-09'),
(1010, 10, '2026-01-10'),
(1011, 11, '2026-01-11'),
(1012, 12, '2026-01-12'),
(1013, 13, '2026-01-13'),
(1014, 14, '2026-01-14'),
(1015, 15, '2026-01-15'),
(1016, 16, '2026-01-16'),
(1017, 17, '2026-01-17'),
(1018, 18, '2026-01-18'),
(1019, 19, '2026-01-19'),
(1020, 20, '2026-01-20'),

(1021, 1, '2026-01-21'),
(1022, 2, '2026-01-22'),
(1023, 3, '2026-01-23'),
(1024, 4, '2026-01-24'),
(1025, 5, '2026-01-25'),
(1026, 6, '2026-01-26'),
(1027, 7, '2026-01-27'),
(1028, 8, '2026-01-28'),
(1029, 9, '2026-01-29'),
(1030, 10, '2026-01-30');
CREATE TABLE Fact_Sales1 (
    Sale_ID INT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    Sales_Amount DECIMAL(10,2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);
INSERT INTO Fact_Sales1
(Sale_ID, Order_ID, Product_ID, Quantity, Sales_Amount)
VALUES
(1, 1001, 201, 2, 500.00),
(2, 1001, 202, 1, 250.00),
(3, 1002, 203, 3, 750.00),
(4, 1002, 204, 1, 300.00),
(5, 1003, 205, 2, 400.00),

(6, 1004, 206, 1, 600.00),
(7, 1004, 207, 2, 450.00),
(8, 1005, 208, 3, 900.00),
(9, 1005, 209, 1, 350.00),
(10, 1006, 210, 2, 700.00),

(11, 1007, 201, 1, 250.00),
(12, 1007, 202, 2, 500.00),
(13, 1008, 203, 4, 1000.00),
(14, 1008, 204, 1, 300.00),
(15, 1009, 205, 3, 600.00),

(16, 1009, 206, 2, 1200.00),
(17, 1010, 207, 1, 225.00),
(18, 1010, 208, 2, 600.00),
(19, 1011, 209, 3, 900.00),
(20, 1012, 210, 1, 350.00),

(21, 1013, 201, 2, 500.00),
(22, 1013, 202, 3, 750.00),
(23, 1014, 203, 1, 250.00),
(24, 1014, 204, 2, 600.00),
(25, 1015, 205, 4, 800.00),

(26, 1015, 206, 1, 600.00),
(27, 1016, 207, 2, 450.00),
(28, 1016, 208, 3, 900.00),
(29, 1017, 209, 1, 300.00),
(30, 1018, 210, 2, 700.00),

(31, 1019, 201, 3, 750.00),
(32, 1020, 202, 1, 250.00),
(33, 1021, 203, 2, 500.00),
(34, 1022, 204, 3, 900.00),
(35, 1023, 205, 2, 400.00),

(36, 1024, 206, 1, 600.00),
(37, 1025, 207, 2, 450.00),
(38, 1026, 208, 3, 900.00),
(39, 1027, 209, 1, 300.00),
(40, 1028, 210, 2, 700.00),

(41, 1029, 201, 2, 500.00),
(42, 1030, 202, 1, 250.00),
(43, 1003, 203, 2, 500.00),
(44, 1006, 204, 1, 300.00),
(45, 1011, 205, 3, 600.00);

SELECT COUNT(*) AS Total_Customers
FROM Customer;
SELECT COUNT(*) AS Total_Orders
FROM Orders;
SELECT COUNT(*) AS Total_Sales
FROM Fact_Sales1;
CREATE VIEW Business_Sales_Report AS
SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    f.Product_ID,
    f.Quantity,
    f.Sales_Amount
FROM Customer c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
INNER JOIN Fact_Sales1 f
    ON o.Order_ID = f.Order_ID;
    
    SELECT *
FROM Business_Sales_Report
ORDER BY Order_Date;

-- Task 47 – Index Recommendation
select * from customer;
select * from orders ;
select * from product2;

CREATE TABLE Fact_Sales2 (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_ID INT,
    Product_ID INT,
    Batch_ID INT,
    Quantity INT,
    Sales_Amount DECIMAL(10,2)
);

INSERT INTO Fact_Sales2
(Sale_ID, Customer_ID, Order_ID, Product_ID, Batch_ID, Quantity, Sales_Amount)
VALUES
(1, 1, 1001, 201, 101, 2, 500.00),
(2, 1, 1001, 202, 101, 1, 250.00),
(3, 2, 1002, 203, 101, 3, 750.00),
(4, 2, 1002, 204, 101, 1, 300.00),
(5, 3, 1003, 205, 101, 2, 400.00),

(6, 4, 1004, 206, 102, 1, 600.00),
(7, 4, 1004, 207, 102, 2, 450.00),
(8, 5, 1005, 208, 102, 3, 900.00),
(9, 5, 1005, 209, 102, 1, 350.00),
(10, 6, 1006, 210, 102, 2, 700.00),

(11, 7, 1007, 201, 103, 1, 250.00),
(12, 7, 1007, 202, 103, 2, 500.00),
(13, 8, 1008, 203, 103, 4, 1000.00),
(14, 8, 1008, 204, 103, 1, 300.00),
(15, 9, 1009, 205, 103, 3, 600.00),

(16, 9, 1009, 206, 104, 2, 1200.00),
(17, 10, 1010, 207, 104, 1, 225.00),
(18, 10, 1010, 208, 104, 2, 600.00),
(19, 11, 1011, 209, 104, 3, 900.00),
(20, 12, 1012, 210, 104, 1, 350.00),

(21, 13, 1013, 211, 105, 2, 500.00),
(22, 13, 1013, 212, 105, 3, 750.00),
(23, 14, 1014, 213, 105, 1, 250.00),
(24, 14, 1014, 214, 105, 2, 600.00),
(25, 15, 1015, 215, 105, 4, 800.00),

(26, 15, 1015, 216, 106, 1, 600.00),
(27, 16, 1016, 217, 106, 2, 450.00),
(28, 16, 1016, 218, 106, 3, 900.00),
(29, 17, 1017, 219, 106, 1, 300.00),
(30, 18, 1018, 220, 106, 2, 700.00),

(31, 19, 1019, 221, 107, 3, 750.00),
(32, 20, 1020, 222, 107, 1, 250.00),
(33, 1, 1021, 223, 107, 2, 500.00),
(34, 2, 1022, 224, 107, 3, 900.00),
(35, 3, 1023, 225, 107, 2, 400.00),

(36, 4, 1024, 201, 108, 1, 600.00),
(37, 5, 1025, 202, 108, 2, 450.00),
(38, 6, 1026, 203, 108, 3, 900.00),
(39, 7, 1027, 204, 108, 1, 300.00),
(40, 8, 1028, 205, 108, 2, 700.00),

(41, 9, 1029, 206, 109, 2, 500.00),
(42, 10, 1030, 207, 109, 1, 250.00),
(43, 11, 1001, 208, 109, 2, 500.00),
(44, 12, 1006, 209, 109, 1, 300.00),
(45, 13, 1011, 210, 109, 3, 600.00);

CREATE INDEX idx_orders_customer_id
ON Orders(Customer_ID);

CREATE INDEX idx_fact_sales_order_id
ON Fact_Sales2(Order_ID);

CREATE INDEX idx_fact_sales_product_id
ON Fact_Sales2(Product_ID);

CREATE INDEX idx_fact_sales_batch_id
ON Fact_Sales2(Batch_ID);

CREATE INDEX idx_fact_sales_customer_product
ON Fact_Sales2(Customer_ID, Product_ID);

SHOW INDEX FROM Fact_Sales;
SELECT COUNT(*) AS Total_Rows
FROM Fact_Sales2;
SELECT *
FROM Fact_Sales2;

-- Task 48 – Batch-wise ETL Reconciliation Repor
CREATE TABLE ETL_Batch (
    Batch_ID INT PRIMARY KEY,
    Source_Record_Count INT,
    Staging_Record_Count INT,
    Warehouse_Record_Count INT
);

INSERT INTO ETL_Batch
(Batch_ID, Source_Record_Count, Staging_Record_Count, Warehouse_Record_Count)
VALUES
(101, 1000, 1000, 1000),
(102, 1200, 1200, 1180),
(103, 1500, 1480, 1480),
(104, 2000, 1980, 1950),
(105, 2500, 2500, 2500);

SELECT
    Batch_ID,
    Source_Record_Count,
    Staging_Record_Count,
    Warehouse_Record_Count,
    
    Source_Record_Count - Warehouse_Record_Count AS Difference,

    CASE
        WHEN Source_Record_Count = Warehouse_Record_Count
        THEN 'Successful'
        ELSE 'Partially Successful'
    END AS Load_Status

FROM ETL_Batch
ORDER BY Batch_ID;

-- Task 49 – Slowly Changing Dimension (SCD) Validation

CREATE TABLE Employee_History (
    History_ID INT PRIMARY KEY,
    Employee_ID INT,
    Employee_Name VARCHAR(100),
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    Effective_Date DATE
);
INSERT INTO Employee_History
(History_ID, Employee_ID, Employee_Name, Salary, Department, Effective_Date)
VALUES
(1, 1, 'Arun Kumar', 50000, 'IT', '2026-01-01'),
(2, 2, 'Priya Sharma', 60000, 'HR', '2026-01-01'),
(3, 3, 'Rahul Verma', 58000, 'Finance', '2026-01-01'),
(4, 4, 'Sneha Reddy', 65000, 'IT', '2026-01-01'),
(5, 5, 'Karthik Rao', 65000, 'Sales', '2026-01-01'),
(6, 6, 'Anjali Singh', 70000, 'HR', '2026-01-01'),
(7, 7, 'Vijay Kumar', 60000, 'Finance', '2026-01-01'),
(8, 8, 'Divya Nair', 64000, 'IT', '2026-01-01'),
(9, 9, 'Rohit Sharma', 70000, 'Sales', '2026-01-01'),
(10, 10, 'Meena Das', 56000, 'Finance', '2026-01-01'),

(11, 11, 'Suresh Babu', 59000, 'IT', '2026-01-01'),
(12, 12, 'Pooja Patel', 60000, 'HR', '2026-01-01'),
(13, 13, 'Naveen Raj', 68000, 'Finance', '2026-01-01'),
(14, 14, 'Lakshmi Devi', 67000, 'IT', '2026-01-01'),
(15, 15, 'Manoj Kumar', 61000, 'Sales', '2026-01-01'),
(16, 16, 'Asha Thomas', 70000, 'HR', '2026-01-01'),
(17, 17, 'Ravi Shankar', 69000, 'Finance', '2026-01-01'),
(18, 18, 'Neha Gupta', 64000, 'IT', '2026-01-01'),
(19, 19, 'Ganesh Iyer', 72000, 'Sales', '2026-01-01'),
(20, 20, 'Swathi Rao', 57000, 'Finance', '2026-01-01'),

(21, 1, 'Arun Kumar', 52000, 'IT', '2026-06-01'),
(22, 2, 'Priya Sharma', 62000, 'HR', '2026-06-01'),
(23, 4, 'Sneha Reddy', 68000, 'IT', '2026-06-01'),
(24, 6, 'Anjali Singh', 72000, 'HR', '2026-06-01'),
(25, 8, 'Divya Nair', 66000, 'IT', '2026-06-01'),
(26, 9, 'Rohit Sharma', 73000, 'Sales', '2026-06-01'),
(27, 12, 'Pooja Patel', 61000, 'HR', '2026-06-01'),
(28, 13, 'Naveen Raj', 70000, 'Finance', '2026-06-01'),
(29, 16, 'Asha Thomas', 71000, 'HR', '2026-06-01'),
(30, 19, 'Ganesh Iyer', 75000, 'Sales', '2026-06-01'),

(31, 21, 'Ajay Menon', 58000, 'IT', '2026-01-01'),
(32, 22, 'Deepa Nair', 66000, 'HR', '2026-01-01'),
(33, 23, 'Vimal Kumar', 70000, 'Finance', '2026-01-01'),
(34, 24, 'Kavya Reddy', 68000, 'IT', '2026-01-01'),
(35, 25, 'Hari Prasad', 62000, 'Sales', '2026-01-01'),
(36, 26, 'Nisha Singh', 68000, 'HR', '2026-01-01'),
(37, 27, 'Mohan Das', 59000, 'Finance', '2026-01-01'),
(38, 28, 'Rekha Sharma', 65000, 'IT', '2026-01-01'),
(39, 29, 'Sanjay Rao', 74000, 'Sales', '2026-01-01'),
(40, 30, 'Divya Kumar', 60000, 'Finance', '2026-01-01');
select * from emp;
select * from Employee_History;
WITH Latest_History AS
(
    SELECT
        Employee_ID,
        Employee_Name,
        Salary,
        Department,
        Effective_Date,
        ROW_NUMBER() OVER (
            PARTITION BY Employee_ID
            ORDER BY Effective_Date DESC
        ) AS rn
    FROM Employee_History
)

SELECT
    e.Emp_ID,
    e.Emp_Name,
    h.Salary AS Old_Salary,
    e.Salary AS New_Salary,
    h.Department AS Old_Department,
    e.Department AS New_Department
FROM Emp e
JOIN Latest_History h
    ON e.Emp_ID = h.Employee_ID
WHERE h.rn = 1
  AND (
        h.Salary <> e.Salary
        OR h.Department <> e.Department
      );
      
      
 -- Task 50 – End-to-End Data Warehouse Validation Project     
 
 CREATE TABLE Customer2 (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(50),
    Email VARCHAR(100)
);

INSERT INTO Customer2
(Customer_ID, Customer_Name, City, Email)
VALUES
(1,'Arun Kumar','Chennai','arun@gmail.com'),
(2,'Priya Sharma','Bangalore','priya@gmail.com'),
(3,'Rahul Verma','Hyderabad','rahul@gmail.com'),
(4,'Sneha Reddy','Chennai','sneha@gmail.com'),
(5,'Karthik Rao','Mumbai','karthik@gmail.com'),
(6,'Anjali Singh','Delhi','anjali@gmail.com'),
(7,'Vijay Kumar','Pune','vijay@gmail.com'),
(8,'Divya Nair','Kochi','divya@gmail.com'),
(9,'Rohit Sharma','Chennai','rohit@gmail.com'),
(10,'Meena Das','Kolkata','meena@gmail.com'),
(11,'Suresh Babu','Bangalore','suresh@gmail.com'),
(12,'Pooja Patel','Ahmedabad','pooja@gmail.com'),
(13,'Naveen Raj','Hyderabad','naveen@gmail.com'),
(14,'Lakshmi Devi','Chennai','lakshmi@gmail.com'),
(15,'Manoj Kumar','Pune','manoj@gmail.com'),
(16,'Asha Thomas','Kochi','asha@gmail.com'),
(17,'Ravi Shankar','Mumbai','ravi@gmail.com'),
(18,'Neha Gupta','Delhi','neha@gmail.com'),
(19,'Ganesh Iyer','Bangalore','ganesh@gmail.com'),
(20,'Swathi Rao','Chennai','swathi@gmail.com');

CREATE TABLE Staging_Sales2 (
    Sale_ID INT,
    Customer_ID INT,
    Order_ID INT,
    Product_ID INT,
    Batch_ID INT,
    Quantity INT,
    Sales_Amount DECIMAL(10,2)
);
INSERT INTO Staging_Sales2
(Sale_ID, Customer_ID, Order_ID, Product_ID, Batch_ID, Quantity, Sales_Amount)
VALUES
(1,1,1001,201,101,2,100000),
(2,1,1001,202,101,3,1500),
(3,2,1002,203,101,2,2000),
(4,2,1002,204,101,1,15000),
(5,3,1003,205,101,2,5000),
(6,4,1004,206,102,1,12000),
(7,4,1004,207,102,2,50000),
(8,5,1005,208,102,1,30000),
(9,5,1005,209,102,2,16000),
(10,6,1006,210,102,1,45000),
(11,7,1007,211,103,2,14000),
(12,7,1007,212,103,1,10000),
(13,8,1008,213,103,2,12000),
(14,8,1008,214,103,3,4500),
(15,9,1009,215,103,1,30000),
(16,9,1009,216,104,2,24000),
(17,10,1010,217,104,1,35000),
(18,10,1010,218,104,4,3200),
(19,11,1011,219,104,2,3000),
(20,12,1012,220,104,3,7500),
(21,13,1013,221,105,2,4000),
(22,13,1013,222,105,1,1200),
(23,14,1014,223,105,2,1800),
(24,14,1014,224,105,1,5000),
(25,15,1015,225,105,2,7000),
(26,15,1015,201,106,1,50000),
(27,16,1016,202,106,2,1000),
(28,16,1016,203,106,3,3000),
(29,17,1017,204,106,1,15000),
(30,18,1018,205,106,2,5000),
(31,19,1019,206,107,1,12000),
(32,20,1020,207,107,1,25000),
(33,1,1021,208,107,2,60000),
(34,2,1022,209,107,1,8000),
(35,3,1023,210,107,1,45000),
(36,4,1024,211,108,2,14000),
(37,5,1025,212,108,1,10000),
(38,6,1026,213,108,2,12000),
(39,7,1027,214,108,1,1500),
(40,8,1028,215,108,1,30000),
(41,9,1029,216,109,1,12000),
(42,10,1030,217,109,1,35000),
(43,11,1001,218,109,2,1600),
(44,12,1006,219,109,1,1500),

-- Intentional duplicate
(44,12,1006,219,109,1,1500);

select * from product2;
select * from orders;
select * from fact_sales2;
select * from Staging_Sales2;
select * from etl_batch;

-- 1. Source-to-Warehouse Record Count Verification
SELECT
    (SELECT COUNT(*) FROM Staging_Sales) AS Staging_Count,
    (SELECT COUNT(*) FROM Fact_Sales) AS Warehouse_Count,
    (SELECT COUNT(*) FROM Staging_Sales)
      - (SELECT COUNT(*) FROM Fact_Sales) AS Difference;
      
-- 2. Duplicate Record Detection
SELECT
    Sale_ID,
    COUNT(*) AS Duplicate_Count
FROM Staging_Sales2
GROUP BY Sale_ID
HAVING COUNT(*) > 1;      

-- 3. NULL Value Validation
SELECT *
FROM Fact_Sales2
WHERE Customer_ID IS NULL
   OR Order_ID IS NULL
   OR Product_ID IS NULL
   OR Batch_ID IS NULL
   OR Quantity IS NULL
   OR Sales_Amount IS NULL;
   
   SELECT
    e.Batch_ID,
    e.Source_Record_Count,
    e.Staging_Record_Count,
    e.Warehouse_Record_Count,

    e.Source_Record_Count - e.Warehouse_Record_Count
        AS Difference,

    CASE
        WHEN e.Source_Record_Count = e.Staging_Record_Count
         AND e.Staging_Record_Count = e.Warehouse_Record_Count
        THEN 'Successful'
        ELSE 'Mismatch'
    END AS Batch_Status

FROM ETL_Batch e
ORDER BY e.Batch_ID;
-- If you mean the main query for overall data validation
SELECT
    f.Sale_ID,
    f.Customer_ID,
    f.Order_ID,
    f.Product_ID,
    f.Batch_ID,
    f.Quantity,
    f.Sales_Amount,

    CASE
        WHEN f.Customer_ID IS NULL THEN 'Invalid Customer'
        WHEN f.Product_ID IS NULL THEN 'Invalid Product'
        WHEN f.Quantity <= 0 THEN 'Invalid Quantity'
        WHEN f.Sales_Amount < 0 THEN 'Invalid Amount'
        ELSE 'Valid'
    END AS Validation_Status

FROM Fact_Sales2 f
ORDER BY f.Sale_ID;

