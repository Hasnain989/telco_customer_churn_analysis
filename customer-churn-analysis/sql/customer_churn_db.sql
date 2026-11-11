
CREATE TABLE customers (
    customerid VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    seniorcitizen SMALLINT,
    partner VARCHAR(5),
    dependents VARCHAR(5),
    tenure INTEGER,
    phoneservice VARCHAR(5),
    multiplelines VARCHAR(25),
    internetservice VARCHAR(15),
    onlinesecurity VARCHAR(25),
    onlinebackup VARCHAR(25),
    deviceprotection VARCHAR(25),
    techsupport VARCHAR(25),
    streamingtv VARCHAR(25),
    streamingmovies VARCHAR(25),
    contract VARCHAR(20),
    paperlessbilling VARCHAR(5),
    paymentmethod VARCHAR(35),
    monthlycharges NUMERIC(10,2),
    totalcharges NUMERIC(10,2),
    churn SMALLINT
);


SELECT COUNT(*)
FROM customers;

SELECT *
FROM customers
LIMIT 10;

SELECT customerid, COUNT(*)
FROM customers
GROUP BY customerid HAVING COUNT (*) >1;

SELECT
    churn,
    COUNT(*) AS total_customers
FROM customers
GROUP BY churn;

-- Q1 How many customers have stayed and how many have left?

SELECT  
CASE
    WHEN churn = 1 THEN 'Churned'
    ELSE 'Stayed'
END AS churn,
COUNT(*) AS total_customers
FROM customers

GROUP BY churn;


-- Q2 What's the overall churn rate?


SELECT SUM(churn)*100.0 / COUNT(*) AS churn_rate
FROM customers;

-- Q3 Subscription revenue analysis.

SELECT COUNT(*) AS total_customers,
SUM(monthlycharges) AS total_monthly_revenue,
ROUND(AVG(monthlycharges),2) AS avg_monthly_charge
FROM customers;

-- Q4 Which contract category has the highest customer churn rate?









