/*
PROJECT: Telco Customer Churn Analysis
FILE:    04_business_questions_solved.sql
DB:      customer_churn_db
TABLE:   public.customers

Purpose:
    A portfolio-ready collection of SQL queries answering business questions
    about customer churn, contracts, services, customer segments and charges.

Data assumptions:
    - One row represents one customer.
    - customerid uniquely identifies a customer.
    - churn is encoded as 1 = churned and 0 = retained.
    - monthlycharges and totalcharges are numeric monetary fields.
    - This is a historical, cross-sectional dataset. Do not interpret the
      churn percentage as a monthly or annual churn rate.

Run each query independently in PostgreSQL / pgAdmin.
*/

-- ============================================================
-- 0. DATASET VALIDATION
-- ============================================================

-- Q0.1: How many customer records are in the table?
SELECT COUNT(*) AS total_customers
FROM public.customers;

-- Q0.2: Are customer IDs unique?
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customerid) AS unique_customer_ids,
    COUNT(*) - COUNT(DISTINCT customerid) AS duplicate_id_count
FROM public.customers;

-- Q0.3: Are there missing values in important fields?
SELECT
    COUNT(*) FILTER (WHERE customerid IS NULL) AS missing_customerid,
    COUNT(*) FILTER (WHERE contract IS NULL) AS missing_contract,
    COUNT(*) FILTER (WHERE monthlycharges IS NULL) AS missing_monthlycharges,
    COUNT(*) FILTER (WHERE totalcharges IS NULL) AS missing_totalcharges,
    COUNT(*) FILTER (WHERE churn IS NULL) AS missing_churn
FROM public.customers;

-- Q0.4: Are there unexpected values in the churn field?
SELECT churn, COUNT(*) AS record_count
FROM public.customers
GROUP BY churn
ORDER BY churn;


-- ============================================================
-- 1. EXECUTIVE OVERVIEW / CORE KPIs
-- ============================================================

-- Q1.1: What are the headline customer and subscription metrics?
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    COUNT(*) FILTER (WHERE churn = 0) AS retained_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS overall_churn_rate_pct,
    ROUND(AVG(monthlycharges), 2) AS average_monthly_charge,
    ROUND(SUM(monthlycharges), 2) AS total_monthly_subscription_value
FROM public.customers;

-- Q1.2: What proportion of customers churned versus stayed?
SELECT
    CASE WHEN churn = 1 THEN 'Churned' ELSE 'Retained' END AS customer_status,
    COUNT(*) AS customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS customer_share_pct
FROM public.customers
GROUP BY churn
ORDER BY churn DESC;


-- ============================================================
-- 2. CONTRACT ANALYSIS
-- ============================================================

-- Q2.1: Which contract type has the highest churn rate?
SELECT
    contract,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY contract
ORDER BY churn_rate_pct DESC;

-- Q2.2: What share of all churned customers came from each contract type?
SELECT
    contract,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE churn = 1) * 100.0 /
        NULLIF((SELECT COUNT(*) FROM public.customers WHERE churn = 1), 0),
        2
    ) AS share_of_all_churn_pct
FROM public.customers
GROUP BY contract
ORDER BY churned_customers DESC;

-- Q2.3: Which contract categories have more than 1,000 customers?
SELECT
    contract,
    COUNT(*) AS total_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY contract
HAVING COUNT(*) > 1000
ORDER BY total_customers DESC;


-- ============================================================
-- 3. PAYMENT METHOD ANALYSIS
-- ============================================================

-- Q3.1: How does churn vary by payment method?
SELECT
    paymentmethod,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    COUNT(*) FILTER (WHERE churn = 0) AS retained_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY paymentmethod
ORDER BY churn_rate_pct DESC;

-- Q3.2: Which payment method is most common among retained customers?
SELECT
    paymentmethod,
    COUNT(*) AS retained_customers
FROM public.customers
WHERE churn = 0
GROUP BY paymentmethod
ORDER BY retained_customers DESC;

-- Q3.3: Which payment method accounts for the largest number of churned customers?
SELECT
    paymentmethod,
    COUNT(*) AS churned_customers
FROM public.customers
WHERE churn = 1
GROUP BY paymentmethod
ORDER BY churned_customers DESC;


-- ============================================================
-- 4. CUSTOMER TENURE ANALYSIS
-- ============================================================

-- Q4.1: What is the average tenure of churned versus retained customers?
SELECT
    CASE WHEN churn = 1 THEN 'Churned' ELSE 'Retained' END AS customer_status,
    COUNT(*) AS customers,
    ROUND(AVG(tenure), 2) AS average_tenure_months,
    ROUND(MIN(tenure), 2) AS minimum_tenure_months,
    ROUND(MAX(tenure), 2) AS maximum_tenure_months
FROM public.customers
GROUP BY churn
ORDER BY churn DESC;

-- Q4.2: How does churn vary across tenure bands?
WITH tenure_segments AS (
    SELECT
        customerid,
        churn,
        CASE
            WHEN tenure BETWEEN 0 AND 12 THEN '0-12 months'
            WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
            WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
            ELSE '49+ months'
        END AS tenure_band
    FROM public.customers
)
SELECT
    tenure_band,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM tenure_segments
GROUP BY tenure_band
ORDER BY MIN(
    CASE tenure_band
        WHEN '0-12 months' THEN 1
        WHEN '13-24 months' THEN 2
        WHEN '25-48 months' THEN 3
        ELSE 4
    END
);

-- Q4.3: How many customers have zero tenure, and what is their churn status?
SELECT
    churn,
    COUNT(*) AS customers_with_zero_tenure
FROM public.customers
WHERE tenure = 0
GROUP BY churn
ORDER BY churn;


-- ============================================================
-- 5. CHARGES AND REVENUE ANALYSIS
-- ============================================================

-- Q5.1: Do average monthly charges differ between churned and retained customers?
SELECT
    CASE WHEN churn = 1 THEN 'Churned' ELSE 'Retained' END AS customer_status,
    COUNT(*) AS customers,
    ROUND(AVG(monthlycharges), 2) AS average_monthly_charge,
    ROUND(AVG(totalcharges), 2) AS average_total_charges
FROM public.customers
GROUP BY churn
ORDER BY churn DESC;

-- Q5.2: How does churn vary across monthly charge bands?
WITH charge_segments AS (
    SELECT
        customerid,
        churn,
        CASE
            WHEN monthlycharges < 35 THEN 'Under $35'
            WHEN monthlycharges < 65 THEN '$35-$64.99'
            WHEN monthlycharges < 90 THEN '$65-$89.99'
            ELSE '$90 and above'
        END AS monthly_charge_band
    FROM public.customers
)
SELECT
    monthly_charge_band,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM charge_segments
GROUP BY monthly_charge_band
ORDER BY MIN(
    CASE monthly_charge_band
        WHEN 'Under $35' THEN 1
        WHEN '$35-$64.99' THEN 2
        WHEN '$65-$89.99' THEN 3
        ELSE 4
    END
);

-- Q5.3: Which customer records have the highest total charges?
SELECT
    customerid,
    tenure,
    contract,
    monthlycharges,
    totalcharges,
    churn
FROM public.customers
ORDER BY totalcharges DESC
LIMIT 20;


-- ============================================================
-- 6. CUSTOMER DEMOGRAPHIC SEGMENTATION
-- ============================================================

-- Q6.1: Does churn differ by senior-citizen status?
SELECT
    CASE WHEN seniorcitizen = 1 THEN 'Senior citizen' ELSE 'Not senior citizen' END AS age_segment,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY seniorcitizen
ORDER BY seniorcitizen DESC;

-- Q6.2: Does churn differ by partner status?
SELECT
    partner,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY partner
ORDER BY churn_rate_pct DESC;

-- Q6.3: Does churn differ by dependent status?
SELECT
    dependents,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY dependents
ORDER BY churn_rate_pct DESC;

-- Q6.4: Does churn differ by gender?
SELECT
    gender,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY gender
ORDER BY churn_rate_pct DESC;


-- ============================================================
-- 7. SERVICE AND PRODUCT ANALYSIS
-- ============================================================

-- Q7.1: How does churn vary by internet service type?
SELECT
    internetservice,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY internetservice
ORDER BY churn_rate_pct DESC;

-- Q7.2: Is having online security associated with a different churn rate?
SELECT
    onlinesecurity,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY onlinesecurity
ORDER BY churn_rate_pct DESC;

-- Q7.3: Is having tech support associated with a different churn rate?
SELECT
    techsupport,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY techsupport
ORDER BY churn_rate_pct DESC;

-- Q7.4: How does churn vary by phone-service status?
SELECT
    phoneservice,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY phoneservice
ORDER BY churn_rate_pct DESC;

-- Q7.5: How does churn vary by paperless-billing status?
SELECT
    paperlessbilling,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY paperlessbilling
ORDER BY churn_rate_pct DESC;


-- ============================================================
-- 8. CUSTOMER PRIORITISATION / ACTIONABLE SEGMENTS
-- ============================================================

-- Q8.1: Which retained customers have high monthly charges?
-- This is a possible retention/opportunity list, not a prediction of churn.
SELECT
    customerid,
    contract,
    tenure,
    monthlycharges,
    totalcharges
FROM public.customers
WHERE churn = 0
  AND monthlycharges >= 90
ORDER BY monthlycharges DESC
LIMIT 50;

-- Q8.2: How many churned customers are on month-to-month contracts
-- and also pay at least $65 per month?
SELECT
    COUNT(*) AS high_charge_month_to_month_churned_customers,
    ROUND(SUM(monthlycharges), 2) AS their_former_monthly_subscription_value
FROM public.customers
WHERE churn = 1
  AND contract = 'Month-to-month'
  AND monthlycharges >= 65;

-- Q8.3: Which combinations of contract and internet service have the highest churn?
SELECT
    contract,
    internetservice,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
FROM public.customers
GROUP BY contract, internetservice
HAVING COUNT(*) >= 50
ORDER BY churn_rate_pct DESC;


-- ============================================================
-- 9. WINDOW FUNCTION EXAMPLES
-- ============================================================

-- Q9.1: Rank contract types by churn rate.
WITH contract_churn AS (
    SELECT
        contract,
        COUNT(*) AS total_customers,
        ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
    FROM public.customers
    GROUP BY contract
)
SELECT
    contract,
    total_customers,
    churn_rate_pct,
    RANK() OVER (ORDER BY churn_rate_pct DESC) AS churn_rate_rank
FROM contract_churn
ORDER BY churn_rate_rank;

-- Q9.2: Compare each payment method's churn rate with the overall churn rate.
WITH payment_churn AS (
    SELECT
        paymentmethod,
        COUNT(*) AS total_customers,
        ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_pct
    FROM public.customers
    GROUP BY paymentmethod
), overall AS (
    SELECT AVG(churn::numeric) * 100 AS overall_churn_rate_pct
    FROM public.customers
)
SELECT
    p.paymentmethod,
    p.total_customers,
    p.churn_rate_pct,
    ROUND(o.overall_churn_rate_pct, 2) AS overall_churn_rate_pct,
    ROUND(p.churn_rate_pct - o.overall_churn_rate_pct, 2) AS percentage_point_difference
FROM payment_churn p
CROSS JOIN overall o
ORDER BY percentage_point_difference DESC;


-- ============================================================
-- 10. ANALYTICAL CAVEATS
-- ============================================================
-- 1. These are descriptive associations, not proof of causation.
-- 2. The dataset is a snapshot; do not label the overall churn percentage
--    as a monthly or annual churn rate.
-- 3. SUM(monthlycharges) is the monthly subscription value represented by
--    the customer records, not necessarily recognised accounting revenue.
-- 4. Customer segments can overlap. Do not add segment counts together
--    unless the groups are mutually exclusive.
-- 5. Any recommendation should consider customer counts as well as rates;
--    a high churn rate in a very small group may affect few customers.
