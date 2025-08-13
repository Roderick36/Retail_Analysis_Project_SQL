## Project Overview

Project Title: Retail Sales Analysis  
Level: Beginner  
Database: RetailSales  

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

 1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
 2. **Data Cleaning**: Identify and remove any records with missing or null values.
 3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
 4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.
    
## Project Structure

## 1. Database Setup

 1. **Database Creation**: The project starts by creating a database named RetailSales.

 2. **Table Creation**: A table named RetailSales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
##
```sql
create database RetailSales
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
);
```

## 2. Data Exploration & Cleaning
1. **Record Count**:Determine the total number of records in the dataset.
```sql
SELECT COUNT(*) AS TOTAL_ROWS 
FROM RetailSales
```
2. **Customer Count**: Find out how many unique customers are in the dataset. 
```sql
SELECT COUNT(DISTINCT customer_id) 
FROM retail_sales;
```
3. **Category Count**: Identify all unique product categories in the dataset.  
```sql
SELECT DISTINCT category 
FROM retail_sales;
```

4. **Null Value Check**: Check for any null values in the dataset and delete records with missing data.  
```sql
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL 
    OR sale_time IS NULL 
    OR customer_id IS NULL 
    OR gender IS NULL 
    OR age IS NULL 
    OR category IS NULL 
    OR quantity IS NULL 
    OR price_per_unit IS NULL 
    OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL 
    OR sale_time IS NULL 
    OR customer_id IS NULL 
    OR gender IS NULL 
    OR age IS NULL 
    OR category IS NULL 
    OR quantity IS NULL 
    OR price_per_unit IS NULL 
    OR cogs IS NULL;
    
```
  
## 3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM RetailSales
WHERE Sale_Date = '2022-11-05';
```
2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022**:
```sql
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
```
3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT
	Category,
	COUNT(*)Total_Orders,
	FORMAT(Sum(Total_Sale),'N2') as Total_Sale
	FROM RetailSales
	GROUP BY Category
```
4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
	ROUND(AVG(Age),2) as Average
	from RetailSales
	where Category = 'Beauty'
```
5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
 SELECT * FROM RetailSales
 WHERE Total_Sale > 1000
```
6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT
  Category,
  Gender,
  COUNT(Transactions_id) as Total_Transactions
  from
RetailSales
group by Category,Gender
order by Category
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```
8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT TOP 5
Customer_ID,
SUM(Total_Sale) AS TOTAL
from RetailSales
GROUP BY Customer_ID,Total_Sale
order by Total_Sale DESC
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT
COUNT (DISTINCT customer_id) as Customer,
Category
FROM RetailSales
GROUP BY Category
```
10. **Write a SQL Query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening > 17**:
```sql
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
```

## Findings
- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.
## Reports
- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.
## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
