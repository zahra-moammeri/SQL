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


