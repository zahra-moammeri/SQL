
-- COLUMNS: 
-- invoice_id : Invoice(bill) of the sales made
-- branch: Branch at which sales were made
-- city: The location of the branch
-- customer type: The type of the customer
-- gender: Gender of the customer making purchase
-- product line: Product line of the product solf
-- unit price: The price of each product
-- quantity:  	The amount of the product sold
-- vat:  The amount of tax on the purchase
-- total:  The total cost of the purchase
-- date:  	The date on which the purchase was made
-- time:  The time at which the purchase was made
-- payment method: the method of paying 
-- cogs: Cost Of Goods sold
-- gross margin percentage:  
-- gross income:  
-- rating: 



create database if not exists `walmart_sales`;


create table if not exists sales(
	invoice_id varchar(30) not null primary key,
    branch varchar(5) not null,
    city varchar(30) not null,
    customer_type varchar(20) not null,
    gender varchar(10) not null,
    product_line varchar(100) not null, 
    unit_price decimal(10, 2) not null,
    quantity int not null,
    vat float(10, 5) not null,
    total decimal(12, 4) not null,
    `date` datetime not null,
    `time` time not null, 
    payment_method varchar(15) not null,
    cogs decimal(10, 2) not null,
    gross_margin_percentage float(11, 9),
    gross_income decimal(12, 4) not null,
    rating float(2, 1) 
);




-- time of day   --> Morning, Afternoon or Evening 

alter table sales add column time_of_day varchar(20);

update sales 
set time_of_day = (
	case
		when `time` between '00:00:00' and '12:00:00' then 'Morning'
		when `time` between '12:01:00' and '16:00:00' then 'Afternoon'
		else 'Evening'
	end
);



-- day name
alter table sales add column day_name varchar(10);

update sales
set day_name =  dayname(`date`) ;


-- Month Name
alter table sales add column month_name varchar(10);

update sales
set month_name = monthname(`date`);
