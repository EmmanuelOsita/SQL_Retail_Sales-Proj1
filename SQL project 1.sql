-- Creating a Database for the Project
Create database sql_project1;

-- Creating a Table
Create Table retails_sale (
transaction_id int, 
sale_date date,	
sale_time	time,
customer_id	int,
gender varchar(25),
age	int,
category	varchar(25),
quantiy	int,
price_per_unit	int,
cogs float,
total_sale int
);

select * from retails_sale
limit 10;

Select count(*) from sql_projectp1.retails_sale;

-- Data Cleaning 
-- Checking for Null values
--
select * from retails_sale
where transaction_id is null;

select * from retails_sale
where sale_date is null;

select * from retails_sale
where sale_time is null;

select * from retails_sale
where customer_id is null;

select * from retails_sale
where gender is null;

select * from retails_sale
where age is null;

select * from retails_sale
where category is null;

select * from retails_sale
where price_per_unit is null;

select * from retails_sale
where cogs is null;

select * from retails_sale
where total_sale is null;
--
-- Data Exploration
-- How many sales we have
select count(*) as total_sales from retails_sale; 

-- How many unique customers we have
select count(*) as transaction_id from retails_sale;

-- How many unique category we have
select count(*) as category from retails_sale;

-- Data Analysis and Business key Problems

-- q.1 Write a SQL query to retrive all columns for sales made on '2022-11-05'

Select * from retails_sale
where sale_date = '2022-11-05';

-- q.2 Write a SQL query to retrive all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT *
FROM retails_sale
WHERE category = 'clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantiy > 10;

-- q.3 write SQL queries to calculate the total sales (total_sales) for each category

select category,
sum(total_sale) as total_sale
from retails_sale
group by category;

-- q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty category'

SELECT AVG(age) AS average_age
FROM retails_sale
WHERE category = 'Beauty';

-- q.5 Write a SQL query to find all transactions where the total sale is greater than 1000
select * from retails_sale
where total_sale > 1000;

-- q.6 Write a SQL query to find the total numbr of transactions (transaction_id) made by each gender in each category 
SELECT
    category,
    gender,
    COUNT(transaction_id) AS transaction_count
FROM
    retails_sale
GROUP BY
    category,
    gender;

-- q.7 Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year
SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS month,
    AVG(total_sale) AS average_sales
FROM
    retails_sale
GROUP BY
    DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY
    month;

-- Identifyinng the Best-Selling Month in Each Year:
SELECT
    year,
    month,
    total_sales
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(total_sale) AS total_sales,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(total_sale) DESC) AS sales_rank
    FROM
        retails_sale
    GROUP BY
        YEAR(sale_date),
        MONTH(sale_date)
) AS monthly_sales
WHERE
    sales_rank = 1;

-- q.8 Write a SQL query to find the top five customers based on the highest total sales
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM
    retails_sale
GROUP BY
    customer_id
ORDER BY
    total_sales DESC
LIMIT 5;

-- q.10 Write an SQL query to create each shift aand number of orders (example morning <=12, afternoon between 12 & 17, Evening>17)

SELECT
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS order_count
FROM retails_sale
GROUP BY shift;

-- End of Project