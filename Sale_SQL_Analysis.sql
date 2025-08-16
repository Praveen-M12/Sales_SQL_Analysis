--Load the dataset
Select * from sales;

-- Data Cleaning
SELECT * FROM sales
WHERE transactions_id IS NULL

SELECT * FROM sales
WHERE sale_date IS NULL

SELECT * FROM sales
WHERE sale_time IS NULL

SELECT * FROM sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

--Count the no of rows
SELECT 
    COUNT(*) 
FROM sales;

--Uniquw rows
SELECT DISTINCT COUNT(*)  FROM sales;


-- Retail Sales Analysis Project
-- =======================================

-- Q.1 Retrieve all sales transactions that occurred on '2022-10-06'
SELECT * 
FROM sales
WHERE sale_date = '2022-10-06';


-- Q.2 Retrieve all transactions from the Clothing category 
-- where the quantity sold is greater than or equal to 4 during November 2022
SELECT * 
FROM sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;


-- Q.3 Calculate the total sales amount and total number of orders for each product category
SELECT 
    category, 
    SUM(total_sale) AS total_sale,  
    COUNT(*) AS total_orders
FROM sales
GROUP BY category;


-- Q.4 Find the average age of customers who purchased items from the Beauty category
SELECT  
    AVG(age) AS avg_age   
FROM sales
WHERE category = 'Beauty';


-- Q.5 Retrieve all transactions where the total sales amount is greater than 1000
SELECT * 
FROM sales
WHERE total_sale >= 1000;


-- Q.6 Find the total number of transactions made by each gender in each category
SELECT 
    gender, 
    category, 
    COUNT(*) AS total_sales
FROM sales
GROUP BY gender, category;


-- Q.7 Calculate the average monthly sales and identify the best-selling month in each year
WITH MonthlySales AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT year, month, avg_sale
FROM MonthlySales
WHERE rnk = 1
ORDER BY year;


-- Q.8 Find the top 5 customers based on the highest total sales
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_sales
FROM sales
GROUP BY customer_id
ORDER BY total_sales DESC;


-- Q.9 Find the number of unique customers who purchased items in each product category
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM sales
GROUP BY category
ORDER BY unique_customers DESC;


-- Q.10 Classify transactions into shifts (Morning <12 hrs, Afternoon 12–17 hrs, Evening >17 hrs) 
-- and find the total number of orders per shift
WITH ShiftOrders AS (
    SELECT 
        transactions_id,
        CASE 
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM sales
)
SELECT 
    shift,
    COUNT(transactions_id) AS total_orders
FROM ShiftOrders
GROUP BY shift
ORDER BY total_orders DESC;


-- Q.11 Find the top 3 product categories with the highest total sales amount
SELECT TOP 3
    category,
    SUM(total_sale) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;


-- Q.12 Find the gender-wise average sale amount
SELECT 
    gender,
    AVG(total_sale) AS avg_sale
FROM sales
GROUP BY gender
ORDER BY avg_sale DESC;


Select * from sales;