-- Financial Performance Analysis
CREATE DATABASE FINANCIAL;
USE FINANCIAL;

-- DEPARTMENT TABLE 
CREATE TABLE DEPARTMENT(
dept_id INT PRIMARY KEY, 	
dept_name VARCHAR(100)	);
INSERT INTO department VALUE 
( 1, "HR"),			( 2, "Sales"),
( 3, "Manager"), 	( 4, "IT"),
( 5, "Marketing"),	( 6, "Customers Sport");
select * FROM DEPARTMENT;

-- FINANCIAL TABLE 
CREATE TABLE financials (
    id INT PRIMARY KEY,
    dept_id INT,
    date DATE,
    revenue INT,
    expense INT,
    budget INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    );
INSERT INTO financials VALUE 
( 101, 1, '2002-01-01', 50000, 30000, 23000),
( 102, 2, '2002-01-24', 67000,20000,15000),
( 103, 3, '2002-02-10', 4500, 3000, 2300),
( 104, 4, '2002-03-21', 6700,2000,1500),
( 105, 5, '2002-03-27', 70000, 20000, 35000),
( 106, 6, '2002-04-20', 40000,10000,15000),
( 107, 7, '2002-05-12', 50000, 30000, 23000),
( 108, 8, '2002-06-02', 67000,20000,15000);
select * from financials;

-- EMPLOYEES TABLE
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    dept_id INT,
    salary INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);
INSERT INTO employees VALUES
(101,1,25000),(102,1,30000),(103,1,28000),
(104,2,22000),(105,2,24000),(106,2,26000),
(107,3,20000),(108,3,21000),
(109,4,30000),(110,4,32000),(111,4,35000);
SELECT * FROM employees;

-- TOTAL (REVENUE/EXPENSE/PROFIT)
SELECT SUM(revenue) as REVENUE FROM financials;
SELECT SUM(expense) as EXPENSE FROM financials;
SELECT SUM(revenue - expense) as PROFIT FROM financials;
select * from financials;
-- 👉 “First, I calculated the overall financial performance of the company.”
-- -- I used SUM(revenue) to get total revenue
-- -- Then SUM(expense) to calculate total cost
-- -- And SUM(revenue - expense) to find overall profit
-- -- 👉 “This gives a high-level view of how the business is performing.”

-- Monthly Analysis
select 
YEAR(`date`) AS YEAR,
MONTH (`date`) AS MONTH,
SUM(REVENUE)AS TOTAL_REVENUE ,
SUM(EXPENSE)AS TOTAL_EXPENSE , 
SUM(REVENUE-EXPENSE)AS TOTAL_PROFIT 
FROM FINANCIALS 
GROUP BY YEAR(`date`),MONTH(`date`); 
select * from financials ;
-- 👉 “Next, I analyzed the data on a monthly level to understand trends.”
-- I extracted year and month from the date column
-- Then grouped the data by year and month
-- After that, I calculated total revenue, expense, and profit for each month
-- 👉 “This helped me identify how performance changes over time.”
 
 -- Department Performance
 select 
 department.dept_name,
 sum(financials.revenue)as revenue, 
 sum(financials.expense)as expense, 
 sum(financials.revenue - financials.expense)as profit 
 from department 
 join 
 financials on department.dept_id = financials.dept_id 
 group by dept_name;
-- 👉 “Then I evaluated performance at the department level.”
-- I joined the financial table with the department table using dept_id
-- This allowed me to map each financial record to its department
-- Then I grouped the data by department name
-- And calculated revenue, expense, and profit for each department
-- 👉 “This shows which departments are contributing more and which are costing more.”

 -- Budget vs Actual
 select 
 department.dept_name, 
 sum(financials.budget) as BUDGET,
 sum(financials.expense) as ACTUAL , 
 sum(financials.budget - financials.expense) as VARIANCE 
 FROM department
 join 
 financials 
 on 
 department.dept_id = financials.dept_id 
 group by dept_name ;
--  👉 “After that, I compared planned budget with actual expenses.”
-- I used budget as planned cost and expense as actual cost
-- Then calculated the difference between them
-- 👉 “This helps identify overspending or cost-saving areas.”
 
 -- Salary Analysis
 select 
 department.dept_name ,
 sum(employees.salary) as TOTAL_SALARY 
 from employees
 join 
 department
 on 
 department.dept_id = employees.dept_id 
 group by dept_name;
-- “I also analyzed employee cost across departments.”
-- I joined employees with departments
-- Then grouped by department
-- And calculated total salary for each department
-- 👉 “This shows how much the company is spending on workforce in each department.”

-- Salary vs Revenue
SELECT 
d.dept_name,
SUM(e.salary) AS salary,
SUM(f.revenue) AS revenue,
(SUM(e.salary) / SUM(f.revenue)) * 100 AS ratio
FROM employees e
JOIN department d ON e.dept_id = d.dept_id
JOIN financials f ON d.dept_id = f.dept_id
GROUP BY d.dept_name;
-- “Finally, I measured cost efficiency by comparing salary with revenue.”
-- I combined employees, departments, and financial data using joins
-- Then calculated total salary and total revenue for each department
-- Finally, I created a ratio of salary to revenue
-- 👉 “This helps understand whether the cost of employees is justified by the revenue they generate.”