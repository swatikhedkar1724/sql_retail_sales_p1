drop table if exists retail_sales;
create table retail_sales(
transactions_id int primary key,
sale_date date, 
sale_time time,
customer_id int,
gender varchar(10),
age int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

select * from retail_sales;

--To find the null value
select * from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or category is null
or quantiy  is null
or price_per_unit is null
or cogs is null
or total_sale is null;

--To delete the null rows
delete from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or category is null
or quantiy  is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- Data Exploration
-- How many sales we have
select count(*) from retail_sales;

-- how many customers we have
select count(customer_id) from retail_sales;

-- How many unique customers we have
select count(distinct customer_id) from retail_sales;

-- name of all category
select distinct category from retail_sales order by 1;

-- retrive all columns for sales made on 2022-11-05
select * from retail_sales where sale_date='2022-11-05';

-- retrive all transactions where category is clothing and the quantity sold is more than 3 in the month of Nov-22
select * from retail_sales
where category='Clothing'
and To_CHAR(sale_date,'yyyy-mm')='2022-11'
and quantiy>3
-- and sale_date between '2022-11-01' and '2022-11-30';

--calculate the total sales for each category
select category,
count(*) as total_sale_count,
sum(total_sale) as net_sales
from retail_sales
group by 1 order by 1;

-- find the avg age of customers who purchased items from the 'Beauty' category
select round(avg(age),2) as avg_age from retail_sales
where category='Beauty';

-- find all transactions where the total_sale is greater than 1000
select * from retail_sales where total_sale>1000; 

-- find total number of transaction made by each gender in each category
select category, gender, count(*) from retail_sales group by 1,2;

-- calculate avg sale for each month. Find out best selling month in each year
select year, month, avg_sale from (
select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank 
from retail_sales group by year, month) as t1 where rank=1

-- calculate the top5 customers based on the highest total sale
select customer_id, sum(total_sale) as highest_Sale from retail_sales 
group by customer_id
order by highest_sale desc limit 5;

-- find the number of unique customers who purchased items from each category
select category, count(distinct customer_id) from retail_sales group by category;

-- create each shift and number of orders(ex. morning<12, afternoon between 12 to 17, evening>17)

with hourly_sale as
(select *,
  case 
      when extract(hour from sale_time)< 12 then'Morning'
      when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
      else 'Evening' 
 end as shift from retail_sales  ) 
 select shift, count(*) as total_order from hourly_sale group by shift































































































































































































         

