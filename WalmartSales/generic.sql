-- As we specified NOT NULL in defining our table there is no null value in here.

use `walmart_sales`;

select * 
from sales
;


-- ***************************************************************************
-- **************************** Feature Engeneering **************************
-- ***************************************************************************

-- time of day   --> Morning, Afternoon or Evening 

select `time`,
(case
	when `time` between '00:00:00' and '12:00:00' then 'Morning'
    when `time` between '12:01:00' and '16:00:00' then 'Afternoon'
    else 'Evening'
end) as time_of_day
from sales;
 

-- day name 
select `date`, dayname(`date`) as day_name
from sales;

-- Month name
select `date`, monthname(`date`)
from sales;



-- Generic Questions:
		--  1. How many unique cities does the data have?
		--  2. In which city is each branch?
        

use `walmart_sales`;

select * 
from sales;

--  1. How many unique cities does the data have?
select distinct city
from sales;

--  2. In which city is each branch?
select distinct branch , city 
from sales;


