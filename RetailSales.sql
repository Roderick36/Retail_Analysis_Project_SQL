--CREATE DATABASE
create database RetailSales

--CREATE TABLE

DROP TABLE IF EXISTS RetailSales

create table RetailSales
(

Transactions_ID int primary key,
	Sale_Date date,
	Sale_Time time,
	Customer_ID int,
	Gender varchar(15),
	Age int,
	Category varchar(15),
	Quantity int,
	Price_Per_Unit float,
	Cogs float,
	Total_Sale  float
)

---LIMIT 10
select top 10 * from dbo.RetailSales

-- COUNT ROWS

SELECT COUNT(*) AS TOTAL_ROWS FROM RetailSales

--RENAME COLUMN
EXEC sp_rename 
	'RetailSales.Quantiy',
	'Quantity',
	'Column';
 
SELECT * FROM RetailSales


--IDENTIFY NULL VALUES - checking all columns FOR DATA CLEANING

SELECT * FROM RetailSales
WHERE 
	Transactions_id IS NULL
	OR
	Sale_Date IS NULL
	OR 
	Sale_Time IS NULL
	OR
	Customer_ID IS NULL
	OR
	Gender IS NULL
	OR
	AGE IS NULL
	OR 
	Category IS NULL
	OR 
	Quantity IS NULL
	OR 
	Price_Per_Unit IS NULL
	OR 
	Cogs  IS NULL
	OR 
	Total_Sale IS NULL

-- DELETING NULL VALUES

DELETE FROM RetailSales
WHERE 
	Transactions_id IS NULL
	OR
	Sale_Date IS NULL
	OR 
	Sale_Time IS NULL
	OR
	Customer_ID IS NULL
	OR
	Gender IS NULL
	OR
	AGE IS NULL
	OR 
	Category IS NULL
	OR 
	Quantity IS NULL
	OR 
	Price_Per_Unit IS NULL
	OR 
	Cogs  IS NULL
	OR 
	Total_Sale IS NULL
	
SELECT * FROM RetailSales

--------   DATA EXPLORATION TO HELP SOLVE PROBLEMS  -------------------

-- HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS TOTAL_SALE FROM RetailSales

-- HOW MANY UNIQUE CUSTOMERS WE HAVE ?

SELECT COUNT(DISTINCT Customer_id) as Total_sale from RetailSales

-- HOW MANY CATEGORY WE HAVE?

SELECT COUNT(DISTINCT Category) as TotalCategory from RetailSales

-- WHAT ARE THE CATEGORIES WE HAVE?

SELECT DISTINCT Category from RetailSales

-------------------------------------------------------------------------

--DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS

--MY ANALYSIS & FINDINGS--
--Q1. Write a SQL Query to retrieve all collumns for sales made on '2022-11-05'
--Q2. Write a SQL Query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov - 2022
--Q3. Write a SQL Query to calculate the total sales (total_sale) for each category.
--Q4. Write a SQL Query to find the average of customers who purchased items from the 'Beauty Category'
--Q5. Write a SQL Query to find all transactins where the total_sale is greater than 1000.
--Q6. Write a SQL Query to find the total number of transactions(transaction_id) made by each gender in each category
--Q7. Write a SQL Query to calculate average sale for each month. Find out best selling month in each year.
--Q8. Write a SQL Query to find he top 5 customers based on the highest total sales
--Q9. Write a SQL Query to find the number of unique customers who purchased items from each category.
--Q10. Write a SQL Query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening > 17
-------------------------------------------------------------------------

--Q1. Write a SQL Query to retrieve all collumns for sales made on '2022-11-05'
SELECT * FROM RetailSales
WHERE Sale_Date = '2022-11-05';

SELECT * FROM RetailSales 


--Q2. Write a SQL Query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 2 in the month of Nov - 2022

SELECT * 
FROM RetailSales
	WHERE Category = 'Clothing'
	AND Quantity > 2
	AND Sale_Date >= '2022-11-01'
	AND Sale_Date <'2022-11-30';
-- or this code ---
SELECT * 
FROM RetailSales
	WHERE Category = 'Clothing'
	AND Quantity > 2
	AND Sale_Date between '2022-11-01' and '2022-11-30';

--Q3. Write a SQL Query to calculate the total sales (total_sale) for each category.

SELECT
	Category,
	COUNT(*)Total_Orders,
	FORMAT(Sum(Total_Sale),'N2') as Total_Sale
	FROM RetailSales
	GROUP BY Category


--Q4. Write a SQL Query to find the average age of customers who purchased items from the 'Beauty Category'

Select 
	AVG(Age) as Average
	from RetailSales
	where Category = 'Beauty'

--Q5. Write a SQL Query to find all transactins where the total_sale is greater than 1000.

 

--Q6. Write a SQL Query to find the total number of transactions(transaction_id) made by each gender in each category
SELECT
  Category,
  Gender,
  COUNT(Transactions_id) as Total_Transactions
  from
RetailSales
group by Category,Gender
order by 1


--Q7. Write a SQL Query to calculate average sale for each month. Find out best selling month in each year.

SELECT * FROM RetailSales

SELECT * FROM
(
SELECT
    YEAR(Sale_date) AS sale_year,
    MONTH(Sale_date) AS sale_month,
    AVG(Total_Sale) AS avg_sale,
	RANK() OVER (PARTITION BY YEAR(Sale_Date) order by Avg(Total_Sale) DESC) AS Rnk
FROM RetailSales
GROUP BY YEAR(Sale_date), MONTH(Sale_date)
) AS TL
WHERE RNK = 1



--Q8. Write a SQL Query to find the top 5 customers based on the highest total sales

select  * from RetailSales


SELECT TOP 5
Customer_ID,
SUM(Total_Sale) AS TOTAL
from RetailSales
GROUP BY Customer_ID,Total_Sale
order by Total_Sale DESC

--Q9. Write a SQL Query to find the number of unique customers who purchased items from each category.

select COUNT (DISTINCT customer_id) as Customer,
Category
FROM RetailSales
GROUP BY Category

--Q10. Write a SQL Query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening > 17

WITH Hourly_Sale
AS (
	SELECT
	CASE 
	WHEN DATEPART(HOUR, Sale_time) < 12 THEN 'Morning'
	WHEN DATEPART(HOUR, Sale_time) BETWEEN 12 AND 17  THEN 'Afternoon'
	ELSE 'Evening'
	END AS SHIFT
	FROM RetailSales
	)

SELECT SHIFT,
	   COUNT(*) as Total_Transactions
	   FROM Hourly_Sale
	   GROUP BY SHIFT

-- END OF PROJECT