-- Data Cleaning

select * 
from layoffs;


-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove any Columns or Rows



-- First of all we have to create a copy of this table in order to keep row data and avoiding any mistakes to miss our data
create table layoffs_staging
like layoffs;  -- copy all columns of layoffs exactly like it

select * 
from layoffs_staging;

insert layoffs_staging 
select *
from layoffs;   -- copy all data of layoffs table into layoffs_staging table




-- 1. Removing duplicate
select * 
from layoffs_staging;


select * ,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;


with duplicate_cte as 
(
select * ,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * 
from duplicate_cte 
where row_num > 1
;

select * 
from layoffs_staging 
where company = 'Casper';

-- we cannot update on cte, so we have to create another tabel and add a new column called row_num and calculate duplicates

CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




select * 
from layoffs_staging_2 ; 

insert into layoffs_staging_2
select * ,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select * 
from layoffs_staging_2
where row_num > 1 ; 

delete 
from layoffs_staging_2
where row_num > 1 ; 


select * 
from layoffs_staging_2
where row_num > 1 ; 

select * 
from layoffs_staging_2;


-- Standardizing Data

-- Company Column
select company, trim(company)
from layoffs_staging_2;

update layoffs_staging_2
set company = trim(company);

-- industry Column
select distinct industry
from layoffs_staging_2
order by 1;


select * 
from layoffs_staging_2
where industry like 'crypto%';


update layoffs_staging_2
set industry = 'Crypto'
where industry like 'Crypto%';


select distinct industry
from layoffs_staging_2;

-- Location Column

select distinct location
from layoffs_staging_2
order by 1;


-- Country Column
select distinct country
from layoffs_staging_2
order by 1;


select * 
from layoffs_staging_2
where country like 'United States%';


update layoffs_staging_2
set country = 'United States'
where country like 'United States%';

-- OR:
select distinct country, trim(trailing '.' from country)
from layoffs_staging_2
order by 1;

update layoffs_staging_2
set country = trim(trailing '.' from country)
where country like 'United States%';


select * 
from layoffs_staging_2;


-- Date Column 
select  `date`
from layoffs_staging_2;

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging_2;


update layoffs_staging_2
set `date`= str_to_date(`date`, '%m/%d/%Y')
;
-- but still the format of 'date' is string format not date so we have to convert the `date` column into date format

alter table layoffs_staging_2    -- statement to change the structure of table
modify column `date` date;    -- now the column `date` converted to date format


select * 
from layoffs_staging_2;


-- NULLS

select *
from layoffs_staging_2
where industry is null
or industry = '' ;


select *
from layoffs_staging_2
where company = 'Airbnb';


update layoffs_staging_2
set industry = Null
where industry= '';


select t1.industry, t2.industry
from layoffs_staging_2 as t1
join layoffs_staging_2 as t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null 
;


update layoffs_staging_2 as t1
join layoffs_staging_2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null)
and t2.industry is not null ;




select *
from layoffs_staging_2
where industry is null;



select *
from layoffs_staging_2
where company like 'Bally%';

-- total_laid_off and percentage_laid_off
select *
from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;


delete 
from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;


select * 
from layoffs_staging_2;

alter table layoffs_staging_2
drop column row_num;






