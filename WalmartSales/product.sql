-- Product Questions:

--     1. How many unique product lines does the data have?
--     2. What is the most common payment method?
--     3. What is the most selling product line?
--     4. What is the total revenue by month?
--     5. What month had the largest COGS?
--     6. What product line had the largest revenue?
--     7. What is the city with the largest revenue?
--     8. What product line had the largest VAT?
--     9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
--     10. Which branch sold more products than average product sold?
--     11. What is the most common product line by gender?
--     12. What is the average rating of each product line?

use `walmart_sales`;

select *
from sales;

-- 1. How many unique product lines does the data have?
select count(distinct product_line) as num_lines
from sales;

select distinct product_line
from sales;


--  2. What is the most common payment method?
select payment_method , count(payment_method) as total_used
from sales
group by payment_method
order by total_used desc;


--  3. What is the most selling product line?
select product_line, count(product_line) as total_sale
from sales
group by product_line
order by total_sale desc;


--  4. What is the total revenue by month?
select month_name as `month` , sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc ;


--  5. What month had the largest COGS?
select month_name as `month`, sum(cogs) as total_cogs
from sales
group by month_name
order by total_cogs desc;


--  6. What product line had the largest revenue?
select product_line, sum(total) as total_income
from sales
group by product_line
order by total_income desc;


--  7. What is the city with the largest revenue?
select city, branch, sum(total) as total_income
from sales
group by city, branch
order by total_income desc;


--  8. What product line had the largest VAT?
-- in average
select product_line, avg(vat) as avg_vat
from sales
group by product_line
order by avg_vat desc;

-- the maximum vat
select product_line, max(vat) as max_vat
from sales
group by product_line
order by max_vat desc;

-- 9. Fetch each product line and add a column to those product line 
-- showing "Good", "Bad". Good if its greater than average sales --> how many

select avg(quantity)
from sales;

select product_line, avg(quantity) as avg_quantity,
	(case
		when avg(quantity) > (select avg(quantity) from sales) then 'good'
        else 'bad'
	end) as state
from sales
group by product_line;


-- 10. Which branch sold more products than average product sold?
select branch, sum(quantity) as `sum`
from sales
group by branch
having sum(quantity) > (select avg(quantity) from sales)
order by `sum` desc
;

select avg(quantity)
from sales;

--  11. What is the most common product line by gender?
select product_line, gender, count(gender) as cnt
from sales
group by product_line, gender
order by cnt desc;


-- 12. What is the average rating of each product line?
select product_line, round(avg(rating), 2) avg_rate
from sales
group by product_line
order by avg_rate desc;

  


