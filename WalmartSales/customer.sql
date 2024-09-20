
-- Customer Questions:

--     1. How many unique customer types does the data have?
--     2. How many unique payment methods does the data have?
--     3. What is the most common customer type?
--     4. Which customer type buys the most?
--     5. What is the gender of most of the customers?
--     6. What is the gender distribution per branch?
--     7 .Which time of the day do customers give most ratings?
--     8. Which time of the day do customers give most ratings per branch?
--     9. Which day for the week has the best avg ratings?
--     10. Which day of the week has the best average ratings per branch?




--     1. How many unique customer types does the data have?
select distinct customer_type
from sales;


--     2. How many unique payment methods does the data have?
select distinct payment_method
from sales;


--     3. What is the most common customer type?
select customer_type, count(customer_type) as `COUNT`
from sales
group by customer_type
order by `COUNT` desc;


--     4. Which customer type buys the most?

-- buys the most number 
select customer_type, sum(quantity) num_sales
from sales
group by customer_type
order by num_sales desc;

-- buys the most total
select customer_type, sum(total) total_sales
from sales
group by customer_type
order by total_sales desc;


--     5. What is the gender of most of the customers?
select gender, count(gender) `Count`
from sales
group by gender
order by `Count` desc;


--     6. What is the gender distribution per branch?
select branch, gender, count(gender)
from sales
group by branch, gender
order by branch;

--     7 .Which time of the day do customers give most ratings?
select time_of_day, count(rating) rate
from sales
group by time_of_day
order by rate desc;

--     8. Which time of the day do customers give most ratings per branch?
select branch, time_of_day, count(rating) rate
from sales
group by branch, time_of_day
order by branch, rate desc;

--     9. Which day for the week has the best avg ratings?
select day_name, avg(rating) avg_rate
from sales
group by day_name
order by avg_rate desc;


--     10. Which day of the week has the best average ratings per branch?

select branch, day_name, avg(rating) avg_rate
from sales 
group by branch, day_name
order by avg_rate desc
limit 3;


