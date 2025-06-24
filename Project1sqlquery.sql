--SQL Retail Analysis 

--Create Table 
DROP table IF EXISTS retail_sales

Create table retail_sales
	(
		transactions_id INT PRIMARY KEY,
		 sale_date DATE,
		 sale_time TIME,
		 customer_id INT,
		 gender VARCHAR(15),
		 age INT,
		 category VARCHAR(15),
		 quantiy INT,
		 price_per_unit FLOAT,
		 cogs FLOAT,
		 total_sale FLOAT
	)	

SELECT * from retail_sales

SELECT COUNT(*) from retail_sales

--Dealing wiht NULL values 

SELECT * from retail_sales 
where transactions_id is NULL;


SELECT * from retail_sales 
where sale_date is NULL;


SELECT * from retail_sales 
where sale_time is NULL;


SELECT * from retail_sales 
where customer_id is NULL;


SELECT * from retail_sales 
where gender is NULL;


SELECT * from retail_sales 
where age is NULL;


SELECT * from retail_sales 
where category is NULL;


SELECT * from retail_sales 
where quantiy is NULL;


SELECT * from retail_sales 
where price_per_unit  is NULL;


SELECT * from retail_sales 
where total_sale is NULL;

--SMART WAY TO DEAL WITH NULL VALUES IS USING OR OPERATOR BETWEEN COLUMNS\

--DELETE THE ROWS WITH NULL VALUES 
--DATA CLEANING
DELETE FROM retail_sales
where transactions_id is NULL
	OR 
	sale_date is NULL
	OR
	 sale_time is NULL
	OR
	 customer_id is NULL
	OR
	 gender is NULL
	OR
	age is NULL
	OR
	 category is NULL
	 OR
	 quantiy is NULL
	 OR
	price_per_unit  is NULL
	OR
	 total_sale is NULL;

SELECT COUNT(*) FROM retail_sales

--DATA EXPLORATION

--How many sales we have?(1987)
SELECT COUNT(*) AS total_salecount from retail_sales

--How many unique  customers we have?(155)
SELECT COUNT(DISTINCT customer_id) AS total_salecount from retail_sales

--How many categories we have?(3)
SELECT COUNT(DISTINCT category) AS total_salecount from retail_sales

--How many categories we have names?("Electronics","Clothing","Beauty")
SELECT DISTINCT CATEGORY FROM RETAIL_SALES

--Data Analysis & Business Key Problems  Answers 
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
   select * from retail_sales 
   where sale_date = '2022-11-05'
   
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than >=4 in the month of Nov-2022
    SELECT *
  FROM retail_sales
  WHERE category = 'Clothing'
   AND to_char(sale_date, 'YYYY-MM') = '2022-11'
   AND quantiy >= 4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) and total order for each category.
	select category,sum(total_sale) as Cat_wise_sales,count(*) as total_order 
	from retail_sales
	group by category
	
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select ROUND(avg(age),2) as average_age
from retail_sales 
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
    select * from retail_sales 
	where total_sale>1000
	
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
	select category,gender,count(*) as total_transactions from retail_sales 
	group by (category,gender)
	order by category
	
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT * 
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS years,
        EXTRACT(MONTH FROM sale_date) AS months,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) AS t1
WHERE rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
    select customer_id,sum(total_sale) as total_purchase
	from retail_sales 
	group by customer_id
	order by sum(total_sale) desc
	limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
  select category,count(distinct(customer_id)) as unique_number_cus 
	from retail_sales
	group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
	  select *,
	  case 
	  when extract(hour from sale_time)  then 'Morning'
	  when extract(hour from sale_time) between 12 and 15 then 'Afternoon'
	  else 'Evening'
	  end as Day_of_Day
	  from retail_sales
	 
select* from retail_sales

--END OF PROJECT

