CREATE DATABASE AMEZON_SALES_ANALYSIS;
USE AMEZON_SALES_ANALYSIS;
SHOW tables;
SELECT * FROM CUSTOMER;
select * from delievry ;
select * from orders ; 
select * from products ;
select * from ratings ;
select * from returns_refund ;
select * from subscription_details;
select * from subscription_plan ;
select * from transactions;

DESC customer;

-- Find duplicat values from tables.

SELECT C_id, COUNT(*)
FROM customer
GROUP BY C_id
HAVING COUNT(*) > 1;

-- DETETE DUPLICATE VALUES FROM CUSTOMER TABLE USING SELF JOIN IN IN THIS CUSTOMER TABLE.
create table temp_customer as select distinct * from customer ;
truncate table customer ;
insert into customer select * from temp_customer ;
drop table temp_customer ;
select * from customer ;

select  
      sum(C_ID IS NULL ) AS ID,sum(C_ID = '') AS EMPTY_C_ID,
      SUM(C_NAME IS NULL ) AS c_NAME, sum(C_NAME = '') AS EMPTY_C_NAME,
      SUM(GENDER IS NULL ) AS  C_GENDER,sum(GENDER  = '') as EMPTY_GENDER,
      SUM(AGE IS NULL ) AS C_AGE,sum(AGE = '')as EMPTY_AGE,
      SUM(City IS NULL ) AS c_CITY,sum(City = '') as EMPTY_CITY,
      SUM(STATE IS NULL) AS C_STATE,sum(STATE = '')as EMPTY_State,
      SUM(`STREET Address` IS NULL ) AS ADDRESS,sum(`STREET Address` = '') as EMPTY_SA,
      SUM(Mobile IS NULL) AS C_NUMBER,sum(Mobile = '') as EMPTY_Moblie
      FROM CUSTOMER;
      
      
  -- Checking is there any null values or not .    
select 
      
      SUM(DP_id = '' OR TRIM(DP_id) = '') AS empty_id,
      SUM(DP_Name = '' OR TRIM(DP_Name) = '') AS empty_Name,
      SUM(DP_Ratings IS NULL) AS real_nulls,
      SUM(DP_Ratings = '' OR TRIM(DP_Ratings) = '') AS empty_values
FROM delievry;

SELECT DP_id , COUNT(*)
FROM delievry 
group by dp_ID
having count(*) > 1;
-- This query represents that thare is 25 duplicate values as of now start deleting duplicate -
create table dp_table as select distinct * from delievry;
truncate table delievry ;
insert into delievry select * from dp_table;
drop table dp_table;
select * from delievry;

-- dilievry table is completely cleaned from duplicat values.

Desc orders;



select 
      sum(or_ID is null) as O_ID, SUM(Or_ID ='') as empty_id,
      sum(C_ID is null) as C_ID, SUM(C_ID = '') as empty_C_ID,
      sum(P_ID is null) as P_ID,SUM(P_ID = '' )as empty_P_ID,
	  SUM(Order_Date is null) as O_DAte,SUM(Order_Date = '') as empty_ORDER_DATE,
      sum(Order_Time is null) as O_Time,SUM(Order_Time='') as empty_Order_time,
	  sum(Qty is null)as O_Qty,sum(Qty = '') as EMPTY_QTY,
      sum(Coupon is null) as O_Coupon,SUM(Coupon = '') empty_Coupon,
      sum(DP_ID is null) as DP_ID , SUM(DP_ID = '')as EMPTY_DP
from  orders;
-- Checking is there any duplicate value present or not.
select or_id, count(*)
from orders
group by or_ID
having count(*) > 1;
-- thre is no duplicated values id order_Id column.

-- In this Orders table  there is 5011 Coupon columns are contain empty/ no date .
-- Now Replacing empty Columns converting with Empty spece TO (NOT APPLICABLE USER).

SET SQL_SAFE_UPDATES = 0;
UPDATE orders SET Coupon = 'NOT APPLICABLE USER' WHERE Coupon = '';
SELECT * FROM ORDERS;


select 
      sum(P_ID is null) as P_ID,sum(P_ID = '') as EMPTY_P_ID,
      Sum(PName is null) as P_NAME,sum(PName = '') as EMPTY_PName,
      sum(Category is null) as P_category,sum(Category = '') as EMPTY_Category,
      sum(`Specs1`is null) as P_specs,sum(Specs1 = '') as EMPTY_Spece,
      sum(price is null) as P_Price,sum(Trim(Price = '')) as EMPTY_Price
from products;
-- checking is there any duplicates are present or not 
-- there is no dupcate ,, extracting this information from the blow quiry .

select p_id, count(*)
from products 
group by p_id
having count(*) > 1;

-- there are 14 prodct name is not mention in products table 
-- so now we are replacing pname column with 'NOT MENTIONED'
 set sql_safe_updates = 0 ;
update products set pname = 'Not Mentioned' where pname = '' ;
select * from products where pname = 'Not Mentioned';

-- One Query fro extracting the details that how many rows are present in that perticular tables >>> and is there same column and row count.

select 'customer' as table_name ,count(*) from customer
UNION ALL 
SELECT 'DELIEVRY' , COUNT(*) FROM DELIEVRY
UNION ALL 
SELECT 'ORDERS' ,COUNT(*) FROM ORDERS
UNION ALL 
SELECT 'PRODUCTS' , COUNT(*) FROM PRODUCTS
UNION ALL 
SELECT 'RATINGS' , COUNT(*) FROM RATINGS
UNION ALL 
SELECT 'RETURNS_REFUND' , COUNT(*) FROM RETURNS_REFUND
UNION ALL 
SELECT 'subscription_details' , COUNT(*) FROM subscription_details
UNION ALL 
SELECT 'SUBSCRIPTION_PLAN' , COUNT(*) FROM SUBSCRIPTION_PLAN
UNION ALL 
SELECT 'TRANSACTIONS' , COUNT(*) FROM TRANSACTIONS;

select count(*) as affected_orders
from orders as o
join products as p ON  o.P_ID = p.P_ID 
where p.PName is null or 
Trim(p.PName) = '';

select
      sum(R_ID is null) as R_ID,SUM(R_ID = '') AS EMPTY_r_id,
      sum(Or_ID is null) as Or_ID,SUM(Or_ID = '') AS EMPTY_Or_id,
      sum(Prod_Rating is null) as P_Rating,SUM(PROD_RATING = '') AS EMPTY_PROD,
      sum(`Delivery/Service_Rating` is null) as D_Ratings,SUM(`Delivery/Service_Rating` = '') AS EMPTY_ds
from ratings;

-- Check ratings table is there any duplicate value or not. 
select R_ID , count(*)
from ratings
group by R_ID
having count(*) > 1;
-- there is no Duplicate values . 


select 
      sum(RT_ID IS NULL) AS RT_ID,
      SUM(Or_ID IS NULL) AS Or_ID,
      SUM(Reason IS NULL) AS Reason,
      SUM(`Return/Refund` IS NULL) AS RR,
      SUM(`Date` IS NULL) AS `Date`
FROM RETURNS_REFUND;

-- Checking Duplicates from Returns_Refund table..>>
select RT_ID , count(*)
from returns_refund
group by RT_ID
having count(*) > 1;

-- There is no Duplicate value.

select 
      sum(SD_ID IS NULL ) AS SD_ID,sum(SD_ID = '') as EMPTY_SD_ID,
      SUM(C_ID IS NULL) AS C_ID,sum(C_ID = '') as EMPTY_C_ID,
      SUM(Plan_ID IS NULL) AS Plan_ID,sum(Plan_ID = '') as Plan_Id_EMPTY,
      SUM(From_Date is null ) as From_Date,sum(From_Date = '')as Empty_DATE,
      sum(To_Date is null) as To_Date,sum(To_Date = '')as empty_TO_Date
from subscription_details;

-- Now Checking Is there any duplicate value or not.
select SD_ID, count(*)
from subscription_details
group by SD_ID
having count(*) > 1;
 -- There is no Duplicate value

-- Checking 

SELECT 
      SUM(Plan_ID IS NULL ) AS PLAN_ID,sum(Plan_ID = '') as EMPTY_PLA_ID,
      SUM(Plan_Name is null ) as plan_name,sum(Plan_Name = '') as Empty_plan_name,
      sum(Features is null ) as Features,sum(Features = '') as Empty_Features
from subscription_plan;

-- now checking is there any duplicate value or not.

select Plan_ID , count(*)
from subscription_plan
group by Plan_ID
having count(*) > 1; 

SELECT 
      SUM(Tr_ID IS NULL) AS Tr_ID,sum(Tr_ID = ' ') as Empty_TR_ID,
      SUM(Or_ID IS NULL) AS Or_ID,sum(OR_ID = ' ') as Empty_OR_ID,
      SUM(Transaction_Mode is null ) AS Transaction_Mode,sum(Transaction_Mode = '') as EMPTY_TM,
      sum(Tran_Status is null) AS Tran_Status, sum(Tran_status = '') as Tran_status
From transactions;

-- Thire is 33 Null values are there . Now extrecting how many transactions are UIP , Cash Or failed .
select * from Transactions where Transaction_Mode = '';
select Transaction_Mode , count(*)  from transactions group by 
transaction_Mode having Transaction_Mode = '' ;

select * from transactions;
-- Need to find how many Uniqwue Transaction Modes are present in Transactions Table .
SELECT DISTINCT Transaction_Mode FROM transactions;
-- There is 5 Unique Transaction Mode 



-- I need to find what type of Transaction _status occers in Empty Transaction_mode . // Two Type Failed & Successfull.
 SELECT  Distinct Transaction_Mode , Tran_Status 
 FROM transactions WHERE Transaction_Mode = '' OR Transaction_Mode IS NULL ;
 
 
-- Now find how many Successful and Failed Transactions Are presents in Tran_Status .
select Tran_Status,Transaction_Mode , count(*) from transactions group by Tran_Status,Transaction_Mode having Transaction_Mode = '';

-- Same Inside With Two different Queries ....
 -- (
 SELECT Tran_status , count(*) FROM transactions
 WHERE Transaction_Mode = '' OR Transaction_Mode IS NULL 
 GROUP BY Tran_Status;
 -- ) Output is there isd 20 Successfull Transaction Which Transaction_Mode is Empty 
 -- 13 Failed Transactions are present in Tran_Status which Contail Empty value in Transaction Mode . 
 
 -- As of now Change Blank / Empty Columns with " Not Mention" .
 SET SQL_SAFE_UPDATES = 0;
 
UPDATE transactions SET Transaction_Mode = " NOT Mention" WHERE transaction_Mode = '';

-- Check there is empty row/columns is present or not in column (Transaction_Mode) in Transactions Table 
select transaction_mode from transactions where Transaction_Mode = '';
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- NOW ALL TABLES HAVE CLEANED DATA -- THAT MEANS THERE IS NO MISSING VALUE / NULL VALUE / EMPTY COLUMN .
-- NOW WE CAN PERFORM DATA ANALYSIS QUERIES WITH THIS CLEANED DATA SET.

-- ORDERS ANALYSIS 
-- ---------------------------------------------------------------------------
SELECT * FROM ORdelievryordersDERS;
-- Total number of orders placed
SELECT  COUNT(*) AS Total_orders from orders;
-- Insight >> Using This Query It Returns 1000 (Orders)  In Orders Table . 

-- Total revenue generated from all orders 
-- Discription >> Contain Two tables Where Product id is present and find total revanue .
SELECT SUM(P.Price * O.Qty) AS Total_Revanue
FROM products as P
join orders as O
On P.P_ID = O.P_ID;
-- Insight >> Total Revanue is = 13987259.770000057 

--  Which product category has the highest number of orders
SELECT P.Category , 
Sum(O.Qty) as Total_order
FROM  Products as p
LEFT JOIN orders as o
ON p.P_Id = o.P_ID
GROUP BY P.Category  Order by Total_order DESC LIMIT 1;
-- This Query Returns Highest number of orders < Electronics (Category)  = 11450 > .


-- Find which product category has the  Highest number of orders according to Year.
SELECT P.Category , 
year(o.Order_Date) as Order_year ,
Sum(O.Qty) as Total_order
FROM  Products as p
LEFT JOIN orders as o
ON p.P_Id = o.P_ID
GROUP BY P.Category , Order_year Order by Total_order DESC LIMIT 1;

/* This Query Returns category , order_year and Total_order>>
Electronics -- 2024 -- 6069) So This data represents that in the year of  2024 Electronics  generte 
highst number of total order that is 6069. */


--  Extracting Top 10 Order Year and customers by total order value - 
SELECT  C.C_NAME ,
Year(Order_Date) as Year_Record,
SUM(O.Qty) AS TOTAL_Qty
FROM customer AS C
LEFT JOIN 
orders AS O
ON C.C_ID = O.C_ID 
GROUP BY C.C_NAME , O.Qty , Year_Record
ORDER BY TOTAL_Qty DESC , Year_Record DESC LIMIT 10;
-- INSIGHT-  In this query use Left join with group by for extracting >> "Top 10  customers by total order value" .

-- Orders distribution by customer city/state
select c.city , c.state, 
sum(o.qty) as Total_qty
FROM ORDERS AS O
LEFT JOIN CUSTOMER AS C
ON O.C_ID = C.C_ID 
GROUP BY C.CITY , C.STATE 
ORDER BY Total_qty DESC  ; 
-- INSIGHT >> This query return Total Quantity Orders distribution by customer city and state.


/* This analysis compares total quantity ordered with total returns/refunds 
across different cities and states to understand regional performance */
select c.city , c.state, 
sum(o.qty) as Total_qty,
count(r.`return/refund`)  as Total_return,
sum(o.qty)  - count(r.`return/refund`)  as Net_Quantity
FROM ORDERS AS O
LEFT JOIN CUSTOMER AS C
ON O.C_ID = C.C_ID 
LEFT JOIN `returns_refund` AS R
ON R.Or_ID = O.Or_ID
GROUP BY C.CITY , C.STATE 
ORDER BY Total_qty DESC, Total_return DESC ; 

-- ____________________________________________________________________________________________________________

-- CUSTOMER BEHAVIOR ANALYSIS 

-- ANALYZE CUSTOMER SEGMENTATION BASED ON Customer Customer ID , Customer Gender , Customer Age , Customer City 
-- & State 
-- Start Analysis ->>  Customer ID , Customer Gender , Customer Age , Customer City  & State 
SELECT   State ,GENDER , City , COUNT(distinct C_id) AS Total_Customer ,
CASE 
    WHEN AGE < 18 THEN "Child" 
    WHEN AGE  BETWEEN 18  AND  30 THEN "Adults"
    WHEN AGE  BETWEEN 30 AND  60 THEN "Seniors"
    ELSE "SENIURS CITIZEN"
    END AS AGE_Group
    
 FROM CUSTOMER 
 GROUP BY sTATE , GENDER, City , AGE_Group  
 ORDER BY Total_Customer ASC ,AGE_Group ASC ;
-- INSIGHT ->> This query segments customers based on age group, gender, city, and state to --
-- understand the demographic distribution of customers across regions.


/*SELECT State ,count(GENDER) as Total , City , COUNT(distinct C_id) AS Total_Customer ,  
CASE 
    WHEN AGE < 18 THEN "Child" 
    WHEN AGE  BETWEEN 18  AND  30 THEN "Adults"
    WHEN AGE  BETWEEN 31 AND  60 THEN "Seniors"
    ELSE "SENIURS CITIZEN"
    END AS age_Group
	FROM CUSTOMER 
 GROUP BY sTATE , GENDER, City , age_Group
 ORDER BY Total_Customer DESC ,AGE_Group DESC ;*/
 
 --  New vs repeat customers ratio
 -- ANALYZE NEW VS REPEAT CUSTOMERS
 
 SELECT  
 New_Customer,
 Repeat_Customers,
 Round(New_Customer *1.0 / Repeat_Customers,2) as Total_Ratio
 FROM(
 SELECT
     SUM(CASE WHEN CUSTOMER_COUNTS = 1 THEN 1 ELSE 0 END) AS New_Customer,
     SUM(CASE WHEN CUSTOMER_COUNTS > 1 THEN 1 ELSE 0 END) AS Repeat_Customers
     FROM (
     SELECT  C_ID,  COUNT(*) AS CUSTOMER_COUNTS 
     FROM orders
     group by c_id
     )X
       )Y;
--  INSIGHT = THIS ANALYSIS FIND TOTAL 6340 CUSTOMER AND COMPARE TO NEW VS REPEAT CUSTOMER
-- NEW CUSTOMER = 3707
-- REPEAT COSTOMER = 2633
-- TOTAL RETIO OF NEW & REPEAT CUSTOMER IS 1.41    

 
 --  Average spend per customer 
 SELECT avg(p.price) as AVG_PRICE,
 c.c_id ,C_Name,C.CITY ,p.Category, YEAR(O.ORDER_DATE) AS avg_YEAR
 from products as p
 left join orders as o
 ON p.p_id = o.p_id
 join customer as c
 on o.c_id = c.c_id
 group by c_id,C_Name, C.CITY , AVG_YEAR, p.Category
 order by avg(price) desc
 ;  -- USE ASC & desc
 
 /* -- INSIGHT ->> Orders AS PER CUSTOMER THIS ANALYSIS FOUND MAXIMUM AVERAGE IS 499.97 THE CUSTOMER IS 
  Ayush Kannana FROM Mumbai in 2024 &  Nimrat Arya from kanpur in 2023
 --  MINIMUM AVERAGE 10.09 THE CUSTOMER IS AKBAL 
 AGRAWAL FROM BHOPAL IN 2023  AND 2024 THE NAME OF Jagrati Bains FRPM Ahemdabad.*/
 
 
 -- __________________________________________________________________________________________________________________________________
 
 -- PRODUCT PERFORMANCE BASED ANALYSIS 
-- Top 10 best-selling products by revenue 
SELECT PName,
 SUM(P.Price * O.Qty) AS Total_Revanue

FROM products as P
join orders as O
On P.P_ID = O.P_ID
group by p.pName
order by Total_Revanue DESC
 limit 10 ;
 
 -- INSIGHT ->> This query returns that there top 10 selling products whch starts with Its - 54751.94 and end upto Activity -- 37797.81 .
 
 -- Category-wise revenue contribution 
 
 SELECT p.PName, p.Category,
 SUM(P.Price * O.Qty) AS Total_Revanue

FROM products as P
join orders as O
On P.P_ID = O.P_ID
group by p.pName , p.Category
order by Total_Revanue DESC
 limit 10 ;
 -- INSIGHT -->> This query returns that there top 10 selling products AND Category wise whIch starts with Its - 54751.94 and end upto Activity -- 37797.81 .
 
 -- _____________________________________________________________________________________________________________
 
 -- Which payment mode is most frequently used
 
SELECT transaction_MODE , COUNT(*) AS USAGE_CNT
FROM transactions 
group by Transaction_Mode 
order by USAGE_CNT DESC ;

-- INSIGHT ->> THERE IS 6 CATEGOIES 
-- ___________________________________________
/*this analyze found that there are 6 mode use transactions but mostly customere use net banking
usage count is 2024 and minimum customer use*/
-- payment mode is most frequently used is = 2024 by NET BANKING
-- and less frequently used payment mode isd = 33 by NOT mentioned / 1974 by Wallet . 

-- Total count of Each Transaction MOdes 
-- Customer who are using NET bANKING >> 2024 
-- Debit CaRD -- " -- >> 2011 
-- CREDIT CARD -- "-- >> 1980
-- UPI --" -- >> 1978
-- WALLET -- " -- >> 1974 
-- NOT MENTION USERS  --- >> 33.

 -- Payment success vs failure rate 
 select transaction_mode ,Tran_Status,count(*) as status_transaction
 from transactions group by Tran_Status ,transaction_mode 
 order by Transaction_Mode desc , status_transaction desc ;
;
 
-- INSIGHT ->> TAKE SCREENSHOT FOR PPT IT SHOWS ALL TRANSACTION HISTORY .

 SELECT T.transaction_MODE,
 T.TRAN_STATUS, COUNT(*) AS TOTAL_STATUS,
 SUM(P.PRICE) AS TOTAL_PRICE
 FROM transactions AS T
JOIN orders AS O
 ON T.Or_ID = O.Or_ID
JOIN products AS P 
 on P.P_ID = O.P_ID 
 group by T.transaction_MODE, 
 T.TRAN_STATUS
 order by Transaction_Mode ;
 
 -- INSIGHT ->>  NOT Mention	Failed	13	2926.7
/*NOT Mention	Successful	    20	    6091.419999999999
Credit Card	    Failed	            991	    264131.4700000001
Credit Card	    Successful	        989	    249719.49
Debit Card	    Failed          	996	    247861.86000000022
Debit Card	    Successful	        1015	271253.5900000006
Net Banking	    Failed	            1019	259272.9299999999
Net Banking	    Successful	        1005	255853.96000000022
UPI	            Failed	            1002	    245903.82999999996
UPI	            Successful	        976	    246140.62999999986
Wallet	         Failed	            1003	     252322.869999999948 */

 
-- RATINGS & CUSTOMER SATISFACTION 
-- _________________________________________

-- Average rating per product category
 SELECT P.CATEGORY , 
 AVG(PROD_RATING) AS AVG_RATING 
 FROM orders AS O
 JOIN products AS P
 ON O.P_ID = P.P_ID
 JOIN ratings AS R 
 ON O.Or_ID = R.Or_ID
 group by P.Category 
 ORDER BY AVG_RATING DESC;
 
-- INSIGHT :-  - This analysis found that maximum avg rating  is 3.01 from  electronics and 
-- minimum avg rating is 2.96 from fashion .

-- Relationship between ratings and sales volume  
SELECT P.P_ID,
P.PNAME ,P.CATEGORY ,
SUM(O.QTY) AS QUANTITY,
AVG(PROD_RATING) AS AVG_RATING 
FROM orders AS O 
JOIN products AS P 
ON O.P_ID = P.P_ID
LEFT JOIN ratings AS R
ON O.Or_ID = R.Or_ID
group by P.P_ID,
P.PNAME ,P.CATEGORY order by QUANTITY DESC , AVG_RATING DESC ;
-- INSIGHT : - This analysis found that Low rating but high sales indicates strong demand but poor customer experience.
-- analyze Customer giving lowest ratings - Repeat or one time
SELECT C.C_ID,C.C_NAME , MIN(R.PROD_RATING) AS LOWEST_RATING,
 COUNT(*) AS RATING_FREQUENCY 
 FROM orders AS O 
JOIN customer AS C ON O.C_ID = C.C_ID
 JOIN ratings AS R 
 ON O.Or_ID = R.Or_ID
 group by C.C_ID,C.C_NAME , R.PROD_RATING
 having RATING_FREQUENCY >2
 order by lOWEST_RATING ASC , C.C_NAME  ASC;
 
-- INSIGHT : -
 /*Customers who give the lowest ratings (1–2 stars) are not limited to one-time buyers.
A significant portion are repeat customers, indicating that dissatisfaction is persistent, not accidental. */

-- ___________________________________________________________________________________________________________

-- RETURNS & REFUNDS 
--  Overall return rate (%)
SELECT(sum(case when `return/refund` = "return" then 1 else 0 end)* 100)/ count(*)as return_rate_persent
 from returns_refund ;
 -- this analysis found that overall return rate is 48.45 %
 
-- analyze which CATEGORY are return  most freqenTLY.
select   p.category ,
SUM(case when R.`return/refund` = "return" then 1 else 0 end)*100.0/COUNT(*) AS TOTAL_RETURNS
FROM returns_refund AS R 
JOIN orders AS O
ON R.Or_ID = O.Or_ID
JOIN products AS P
ON P.P_ID = O.P_ID
GROUP BY  p.category 
ORDER BY tOTAL_RETURNS DESC

;
-- INSIGHT - THIS QUERY FOUND THAT HOME APPLIANCE  products are return  most freqenTLY .
-- Refund amount as % of total revenue

    



SELECT
    (SUM(CASE WHEN r.`return/refund` = 'Refund' THEN o.qty * p.price ELSE 0 END)
        /
        SUM(o.qty * p.price) * 100
    ) AS refund_percentage_of_total_revenue
FROM returns_refund r
JOIN orders o
    ON r.Or_ID = o.Or_ID
JOIN products p
    ON p.P_ID = o.P_ID;


-- Do low-rated products have higher return rates
SELECT P.CATEGORY ,
AVG(R.PROD_RATING) AS AVGERAGE_RATING,
(SUM(CASE WHEN RR .`RETURN/REFUND` = 'RETURN' THEN O.QTY ELSE 0 END) *1.0 / SUM(O.QTY)) AS  RETURN_RATE 
FROM ORDERS AS O 
LEFT JOIN PRODUCTS AS P
ON O.P_ID = P.P_ID 
LEFT JOIN RATINGS AS R
ON R.Or_ID = O.OR_ID 
LEFT JOIN returns_refund AS RR
ON O.Or_ID = RR.OR_ID 
GROUP BY P.CATEGORY;

-- DELIVERY PERFORMANCE 

select * from orders;
-- How many orders has each delivery partner handled across different cities and states .
select d.dp_name ,
count(dp_name) as DP_partner,
c.city , c.state 
from orders as o 
join delievry as d
ON o.dp_id = d.dp_id
join customer as c 
on o.c_id = c.c_id 
group by DP_Name , c.city , c.state order by DP_partner desc  ;

-- INSIGHT - The analysis shows city-wise order distribution for each delivery partner, -
-- - highlighting regional concentration and delivery partner dominance across different states

select * from ratings;
-- Highest ratings of delivery partner in delivery .
select * from delievry order by DP_Ratings desc;
-- INSIGHT - THIS QUERY RETURNS THAT THERE IS 300 DELIVERY PARTNERS .
-- ANALISE PERFORMENCE OF DELIVERY PERTNER RATINGS.
SELECT DP_NAME ,DP_rATINGS  FROM DELIEVRY  WHERE DP_RATINGS BETWEEN 4 AND 5 ;
-- THIS ANALYSIS  FOUNDS THAT MAXIMUM DP RATINGS ARE 154  AND 20 DELIVERY PARTENES HAS NO RATINGS .>> 
-- ANALISE PERFORMENCE OF DELIVERY PERTNER RATINGS .
SELECT DP_NAME , DP_RATINGS FROM delievry WHERE DP_Ratings = 0 ;
-- INSIGHT - THERE IS 20 PEOPLE WHERE DP_RATINGS IS EQUEVELENT TO 0 ;



SELECT * FROM subscription_details;
-- _________________________________________________________________________________________________________________________________

SELECT * FROM ORDERS;

-- analyze how many customers use these 3 plans.
select s.plan_name , s.Features  ,
count(case when s.Plan_Name = 'prime base' then c.C_ID
		   when s.Plan_Name = 'Prime Standard ' then c.C_ID
		   when s.Plan_Name = 'Prime Premium ' then c.C_ID else 0 end) as total_customer 
from  subscription_plan as s join subscription_details as ss 
on s.Plan_ID = ss.Plan_ID
join customer as c on c.C_ID = ss.c_id 
group by s.plan_name ,  s.Features ;
 -- SAME RESULT WITH DIFFERENT QUERY 
select s.plan_name , s.features  ,count(*) as Total_count 
from subscription_plan as s
join subscription_details as ss
ON s.plan_id = ss.Plan_ID group by s.plan_name , s.features order by Total_count  ;
-- This analysis found that there are 3393 customers use prime base subscription plan ,	
/* and there are 3360 customers are using prime basic subscription and 
3283 users/ customers are using Prime Premium  .*/

SELECT C_ID , COUNT(*) AS tOTAL_COUNT 
FROM subscription_details 
group by C_ID 
HAVING COUNT(*) > 1 ORDER BY TOTAL_COUNT DESC; 

SELECT SD_ID ,
AVG(datediff(TO_DATE , FROM_DATE)) AS AVG_SUBSCRIPTION_DATE
FROM SUBSCRIPTION_DETAILS
GROUP  BY SD_ID ;

SELECT 
      YEAR(FROM_DATE) AS yEAR,
      MONTHNAME(FROM_DATE) AS MONTH ,
      COUNT(*) AS Subscriptions_started 
from subscription_details
group by year , month
;

select * from dp_formate;

-- DELIVERY PERFORMANCE 

select * from orders;
-- How many orders has each delivery partner handled across different cities and states .
select d.dp_name ,
count(dp_name) as DP_partner,
c.city , c.state 
from orders as o 
join delievry as d
ON o.dp_id = d.dp_id
join customer as c 
on o.c_id = c.c_id 
group by DP_Name , c.city , c.state order by DP_partner desc  ;

-- INSIGHT - The analysis shows city-wise order distribution for each delivery partner, -
-- - highlighting regional concentration and delivery partner dominance across different states

select * from ratings;
-- Highest ratings of delivery partner in delivery .
select * from delievry order by DP_Ratings desc;
-- INSIGHT - THIS QUERY RETURNS THAT THERE IS 300 DELIVERY PARTNERS .
-- ANALISE PERFORMENCE OF DELIVERY PERTNER RATINGS.
SELECT DP_NAME ,DP_rATINGS  FROM DELIEVRY  WHERE DP_RATINGS BETWEEN 4 AND 5 ;
-- THIS ANALYSIS  FOUNDS THAT MAXIMUM DP RATINGS ARE 154  AND 20 DELIVERY PARTENES HAS NO RATINGS .>> 
-- ANALISE PERFORMENCE OF DELIVERY PERTNER RATINGS .
SELECT DP_NAME , DP_RATINGS FROM delievry WHERE DP_Ratings = 0 ;
-- INSIGHT - THERE IS 20 PEOPLE WHERE DP_RATINGS IS EQUEVELENT TO 0 ;
SELECT * FROM subscription_details;
SELECT * FROM ORDERS;

-- analyze how many customers use these 3 plans.
select s.plan_name , s.Features  ,
count(case when s.Plan_Name = 'prime base' then c.C_name 
		   when s.Plan_Name = 'Prime Standard ' then c.C_name 
		   when s.Plan_Name = 'Prime Premium ' then c.C_name else 0 end) as total_customer 
from  subscription_plan as s join subscription_details as ss 
on s.Plan_ID = ss.Plan_ID
join customer as c on c.C_ID = ss.c_id 
group by s.plan_name ,  s.Features ;
 -- SAME RESULT WITH DIFFERENT QUERY 
select s.plan_name , s.features  ,count(*) as Total_count 
from subscription_plan as s
join subscription_details as ss
ON s.plan_id = ss.Plan_ID group by s.plan_name , s.features order by Total_count  ;
-- This analysis found that there are 3393 customers use prime base subscription plan ,	
/* and there are 3360 customers are using prime basic subscription and 
3283 users/ customers are using Prime Premium  .*/

SELECT C_ID , COUNT(*) AS tOTAL_COUNT 
FROM subscription_details 
group by C_ID 
HAVING COUNT(*) > 1 ORDER BY TOTAL_COUNT DESC; 

SELECT SD_ID ,
AVG(datediff(TO_DATE , FROM_DATE)) AS AVG_SUBSCRIPTION_DATE
FROM SUBSCRIPTION_DETAILS
GROUP  BY SD_ID ;

SELECT 
      YEAR(FROM_DATE) AS yEAR,
      MONTHNAME(FROM_DATE) AS MONTH ,
      COUNT(*) AS Subscriptions_started 
from subscription_details
group by year , month
;










