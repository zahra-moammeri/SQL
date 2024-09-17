-- Exploratory Data Analysis

select * 
from layoffs_staging_2;


select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging_2;

select *
from layoffs_staging_2
where percentage_laid_off = 1
order by total_laid_off desc;


select *
from layoffs_staging_2
where percentage_laid_off = 1
order by funds_raised_millions desc;



-- WHEN  --> 2020/03/11  -  2023/03/06
select min(`date`), max(`date`)
from layoffs_staging_2;


-- Which companies has the most laid off and how many  --> 1. Amazon, 18150 - 2.Google, 12000  - 3.Meta, 11000
select company, sum(total_laid_off)
from layoffs_staging_2
group by company
order by 2 desc;

-- which industries has the most laid off and how many  --> 1. Consumer, 45182 - 2. Retail, 43613
select industry, sum(total_laid_off)
from layoffs_staging_2
group by industry
order by 2 desc;


-- Which countries has the most laid off and how many  --> 1. United States, 256559  - 2. India , 35993 
select country, sum(total_laid_off)
from layoffs_staging_2
group by country
order by 2 desc;


-- When there has been the most laid off and how many  --> In Janury of 2023 , 16171
select `date` , sum(total_laid_off)
from layoffs_staging_2
group by `date`
order by 2 desc;


-- How many laid off has been occured during each year  
-- It seems that 2022 had the most laid off with 160661 people, 
-- but 2023 had 125677 laid off in just 3 months so it's going to be the most laid off year
select year(`date`) , sum(total_laid_off)
from layoffs_staging_2
group by year(`date`)
order by 2 desc;


-- Which stages of companies has the most laid off --> Post-IPO which are the big companies like Amazon 
select stage, sum(total_laid_off)
from layoffs_staging_2
group by stage
order by 2 desc
;


-- What is the average percentage of lay off in each company
select company, avg(percentage_laid_off)
from layoffs_staging_2
group by company
order by 2 desc;



-- Total lay off based on each month in each year   
select substring(`date`, 1, 7) as `month` , sum(total_laid_off)
from layoffs_staging_2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc
;


-- How lays off has increased by each month -->  
-- In 2020, 80998 people have laid off while by the end of 2021 96821 have laid off in total, which means it was the best year among other years. 
-- Also at the end of 2022 257482 have laid off which was the year in Corona Virus. in the third month of 2023 the total lay off reaches 383159.
with rolling_total as 
(
select substring(`date`, 1, 7) as `month` , sum(total_laid_off) as total_off
from layoffs_staging_2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off, sum(total_off) over(order by `month`) as total
from rolling_total
;


-- The company that had the highest laid off and rank them
-- 2020 -> Uber, 2021 -> Bytedance, 2022 -> Meta, 2023 -> Google --> the biggest lay off

with company_year (company, years, sum_total_laid_off)
as 
(
select company, Year(`date`) ,sum(total_laid_off) 
from layoffs_staging_2
group by company,  Year(`date`)
)
select * , dense_rank() over(partition by years order by sum_total_laid_off desc) as ranking
from company_year
where years is not null
order by ranking asc;


-- top five ranking companies
with company_year (company, years, sum_total_laid_off)
as 
(
select company, Year(`date`) ,sum(total_laid_off) 
from layoffs_staging_2
group by company,  Year(`date`)
), 
company_year_rank as
(
select * , dense_rank() over(partition by years order by sum_total_laid_off desc) as ranking
from company_year
where years is not null
)
select * 
from company_year_rank 
where ranking <= 5
;


select * 
from layoffs_staging_2;

