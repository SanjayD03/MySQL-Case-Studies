/*----------------------------- Database Creation------------------------------------------------*/
CREATE DATABASE credit_card_transactions;

/*----------------------------- Use a Specific Database------------------------------------------*/
USE credit_card_transactions;

/*------------------------ To fetch all the data stored in the Tables---------------------------*/

-- Tables
SELECT * FROM transactions;

/*-------------------------------------Questions-------------------------------------------------------*/

-- 1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends
WITH cte AS (
    SELECT 
        card_type,
        DATEPART(year, transaction_date) AS year,
        DATENAME(month, transaction_date) AS Month_name,
        SUM(amount) AS total_expenses
    FROM 
        transactions 
    GROUP BY 
        card_type,
        DATEPART(year, transaction_date),
        DATENAME(month, transaction_date)
)
SELECT 
    card_type,
    year,
    Month_name,
    total_expenses 
FROM
    (SELECT 
         *, 
         RANK() OVER (PARTITION BY card_type ORDER BY total_expenses DESC) AS rnk
     FROM 
         cte) a 
WHERE 
    rnk = 1;


-- 2- write a query to print highest spend month and amount spent in that month for each card type
WITH cte AS (
    SELECT 
        card_type,
        DATEPART(year, transaction_date) AS year,
        DATENAME(month, transaction_date) AS Month_name,
        SUM(amount) AS total_expenses
    FROM 
        transactions 
    GROUP BY 
        card_type,
        DATEPART(year, transaction_date),
        DATENAME(month, transaction_date)
)
SELECT 
    card_type,
    year,
    Month_name,
    total_expenses 
FROM
    (SELECT 
         *, 
         RANK() OVER (PARTITION BY card_type ORDER BY total_expenses DESC) AS rnk
     FROM 
         cte) a 
WHERE 
    rnk = 1;


-- 3- write a query to print the transaction details(all columns from the table) for each card type when it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)
WITH cumulative_sums AS (
    SELECT 
        *,
        SUM(amount) OVER (PARTITION BY card_type ORDER BY transaction_date, transaction_id) AS cum_sum
    FROM 
        transactions
)
, ranked_cumulative_sums AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY card_type ORDER BY cum_sum ASC) AS rn
    FROM 
        cumulative_sums
    WHERE 
        cum_sum >= 1000000
)
SELECT 
    *
FROM 
    ranked_cumulative_sums
WHERE 
    rn = 1;


-- 4- write a query to find city which had lowest percentage spend for gold card type
SELECT 
	TOP 1
    city,
    SUM(amount) AS total_spend,
    SUM(CASE WHEN card_type='Gold' THEN amount ELSE 0 END) AS gold_spend,
    CONCAT(FORMAT((SUM(CASE WHEN card_type='Gold' THEN amount ELSE 0 END) * 100.0 / SUM(amount)), 'N2'), '%') AS gold_contribution_percentage
FROM 
    transactions
GROUP BY 
    city
HAVING 
    SUM(CASE WHEN card_type='Gold' THEN amount ELSE 0 END) > 0
ORDER BY 
    gold_contribution_percentage;

-- 5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
WITH cte AS (
    SELECT 
        city,
        exp_type,
        SUM(amount) AS total_spend
    FROM 
        transactions
    GROUP BY 
        city,
        exp_type
),
cte2 AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY city ORDER BY total_spend DESC) AS Highest_rnk,
        RANK() OVER (PARTITION BY city ORDER BY total_spend) AS Lowest_rank
    FROM 
        cte
)
SELECT 
    city,
    MAX(CASE WHEN Highest_rnk = 1 THEN exp_type END) AS highest_expense_type,
    MAX(CASE WHEN Lowest_rank = 1 THEN exp_type END) AS lowest_expense_type
FROM 
    cte2
WHERE 
    Highest_rnk = 1 OR Lowest_rank = 1
GROUP BY 
    city;


-- 6- write a query to find percentage contribution of spends by females for each expense type
SELECT 
    exp_type,
    SUM(amount) AS total_spend,
    SUM(CASE WHEN gender='F' THEN amount ELSE 0 END) AS female_spend,
    CONCAT(ROUND(SUM(CASE WHEN gender='F' THEN amount ELSE 0 END) * 100.0 / SUM(amount), 2), '%') AS female_contribution
FROM 
    transactions
GROUP BY 
    exp_type
ORDER BY 
    female_contribution;

-- 7- which card and expense type combination saw highest month over month growth in Jan-2014
select * from transactions;
WITH cte AS (
   SELECT 
       card_type,
       exp_type,
       DATEPART(year, transaction_date) AS Year,
       DATEPART(month, transaction_date) AS Month,
       SUM(amount) AS total_spend
   FROM 
       transactions
   GROUP BY 
       card_type,
       exp_type,
       DATEPART(year, transaction_date),
       DATEPART(month, transaction_date)
)
SELECT  
   TOP 1 *, 
   (total_spend - prev_month_spend) AS MOM_growth
FROM 
   (
       SELECT 
           *,
           LAG(total_spend, 1) OVER(PARTITION BY card_type, exp_type ORDER BY Year, Month) AS prev_month_spend
       FROM 
           cte
   ) A
WHERE 
   prev_month_spend IS NOT NULL 
   AND Year = 2014 
   AND Month = 1
ORDER BY 
   mom_growth DESC;


-- 8- during weekends which city has highest total spend to total no of transcations ratio 
SELECT 
    city,
    SUM(amount)*1.0/ COUNT(*) AS ratio 
FROM 
    transactions
WHERE 
    DATEPART(weekday, transaction_date) IN (1, 7) -- 1 = Sunday and 7 = Saturday
GROUP BY 
    city
ORDER BY 
    ratio DESC;

-- 9- which city took least number of days to reach its 500th transaction after the first transaction in that city
WITH ranked_transactions AS (
    SELECT 
        city,
        transaction_date,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY transaction_date) AS transaction_rank
    FROM 
        transactions
),
first_transaction_dates AS (
    SELECT 
        city,
        MIN(transaction_date) AS first_transaction_date
    FROM 
        ranked_transactions
    WHERE 
        transaction_rank = 1
    GROUP BY 
        city
)
SELECT TOP 1
    ft.city,
    DATEDIFF(day, ft.first_transaction_date, rt.transaction_date) AS days_to_500th_transaction
FROM 
    ranked_transactions rt
JOIN 
    first_transaction_dates ft ON rt.city = ft.city
WHERE 
    rt.transaction_rank = 500
ORDER BY 
    days_to_500th_transaction ASC;