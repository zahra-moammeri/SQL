--  Sales Questions:

--   1. Number of sales made in each time of the day per weekday
--   2. Which of the customer types brings the most revenue?
--   3. Which city has the largest tax percent/ VAT (Value Added Tax)?
--   4. Which customer type pays the most in VAT?


--   1. Number of sales made in each time of the day per weekday
select day_name, time_of_day, month_name, count(total) 
from sales
group by day_name, time_of_day, month_name
order by count(total) desc;


select day_name, time_of_day, count(total)
from sales
group by day_name, time_of_day
order by count(total) desc;
select * 
from sales; 


--   2. Which of the customer types brings the most revenue?
select customer_type, sum(total) revenue 
from sales
group by customer_type
order by revenue desc;


--   3. Which city has the largest tax percent/ VAT (Value Added Tax)?
select  city, MAX(VAT) VAT
from sales
group by city
order by VAT desc;


--   4. Which customer type pays the most in VAT?
select customer_type, AVG(VAT) as VAT
from sales
group by customer_type
order by VAT desc;

