# Telco Customer Churn Analysis

An end-to-end data analytics project investigating customer churn in the telecommunications industry using Python, SQL and Power BI. The project explores customer behaviour, identifies patterns associated with churn, and presents actionable insights through an interactive executive dashboard.

## Project Overview

Customer churn is a major challenge for subscription-based businesses. Understanding why customers leave can help organisations improve retention strategies and protect recurring revenue.

This project analyses the IBM Telco Customer Churn dataset, containing information about 7,043 telecommunications customers across 21 attributes.

The objective is to:
- Understand the characteristics of customers who leave.
- Identify customer segments with higher churn rates.
- Examine relationships between contracts, payment methods, tenure and monthly charges.
- Develop an interactive Power BI dashboard to communicate findings.
- Translate analytical results into potential business recommendations.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Python | Data analysis and cleaning |
| Pandas | Data manipulation and transformation |
| Jupyter Notebook | Exploratory data analysis |
| PostgreSQL | Relational database management |
| SQL | Business queries and customer segmentation |
| Power BI | Interactive dashboard and visualisation |
| Git & GitHub | Version control and project documentation |

## Dataset

**Source:** IBM Telco Customer Churn dataset (Kaggle)

- Total records: 7,043
- Total columns: 21
- Each row represents an individual customer.
- Target variable: `Churn`

The dataset contains information relating to:
- Customer demographics
- Subscription services
- Contract types
- Payment methods
- Customer tenure
- Monthly and total charges
- Churn status

## Project Workflow

### 1. Data Understanding

Initial investigation was performed using Pandas to understand:
- Dataset dimensions and structure.
- Column names and data types.
- Unique customer identifiers.
- Distribution of categorical variables.
- Numerical summaries and initial churn patterns.

Initial findings:
- 7,043 unique customers.
- 1,869 customers had churned.
- 5,174 customers remained.
- Overall churn rate: **26.53%**.

### 2. Data Cleaning – Python

The dataset was inspected for:
- Missing values.
- Duplicate records.
- Duplicate customer IDs.
- Incorrect data types.
- Invalid numerical values.
- Data consistency.

Key cleaning operations:
- Converted `TotalCharges` from a string column to a numeric column.
- Identified 11 records with blank `TotalCharges` values.
- Investigated these records and found that all had zero tenure.
- Replaced their missing total charges with zero rather than deleting valid customer records.
- Converted the churn variable into a binary representation:
  - `Yes = 1`
  - `No = 0`
- Validated the cleaned dataset.

The cleaned dataset was exported as `customer_churn_clean.csv`.

### 3. Exploratory Data Analysis

Exploratory analysis was conducted to investigate customer churn patterns.

Key areas examined:
- Overall churn distribution.
- Churn rates across contract types.
- Customer payment methods.
- Customer tenure.
- Monthly charges.
- Differences between retained and churned customers.

### 4. SQL Analysis – PostgreSQL

The cleaned dataset was imported into PostgreSQL for structured querying.

SQL techniques used include:
- SELECT and filtering.
- GROUP BY and ORDER BY.
- Aggregate functions.
- CASE statements.
- WHERE and HAVING.
- Conditional aggregation using FILTER.
- JOIN operations.
- Common Table Expressions (CTEs).
- Window functions.

The SQL analysis focused on answering business questions related to customer retention, churn rates, payment methods and subscription behaviour.

### 5. Power BI Dashboard

An interactive, single-page executive dashboard was developed in Power BI.

**Key performance indicators:**
- Total customers.
- Churned customers.
- Overall churn rate.

**Visualisations:**
- Churn rate by contract type.
- Churn rate by payment method.
- Churn rate by customer tenure.
- Churn rate by monthly charge group.

**Interactive filters:**
- Contract type.
- Gender.
- Senior citizen status.

DAX measures were used to calculate customer counts and churn rates dynamically, allowing report users to explore different customer segments.

## Key Findings

### 1. Contract Type and Churn

Contract type showed a substantial relationship with customer churn.

| Contract | Customers | Churned | Churn Rate |
|---|---:|---:|---:|
| Month-to-month | 3,875 | 1,655 | 42.71% |
| One year | 1,473 | 166 | 11.27% |
| Two year | 1,695 | 48 | 2.83% |

Month-to-month customers had considerably higher churn rates than customers on longer-term contracts.

### 2. Payment Method

Electronic check customers had the highest churn rate among the payment methods examined.

This suggests that payment method may be a useful variable when investigating customer retention patterns.

### 3. Monthly Charges

Customers in the highest monthly charge category (above $70) showed the highest churn rate among the three charge groups examined.

This indicates a potential relationship between subscription cost and customer retention.

### 4. Customer Tenure

Customer tenure was divided into four groups to investigate how churn patterns change throughout the customer lifecycle.

This analysis helps identify customer segments that may require additional retention efforts.

## Business Recommendations

Based on the observed patterns, potential business actions include:

1. **Improve month-to-month retention:** Investigate why customers on flexible contracts leave at higher rates and consider targeted retention incentives.
2. **Review electronic check customers:** Investigate whether payment experience, customer demographics or subscription characteristics contribute to their higher churn rate.
3. **Evaluate high-charge subscriptions:** Review pricing, service value and customer satisfaction among customers with higher monthly bills.
4. **Strengthen early customer engagement:** Examine early-tenure churn and consider improving onboarding and customer support.

These are recommendations based on observed associations, not proven causal relationships.

## Repository Structure

```text
customer-churn-analysis/
│
├── data/
│   ├── raw/
│   │   └── telecom_customer_churn_analysis.csv
│   │
│   └── processed/
│       └── customer_churn_clean.csv
│
├── notebooks/
│   ├── telecom_customer_churn.ipynb
│  
├── sql/
│   ├── customer_churn_results.sql
│   
├── dashboard/
│   ├── Customer_Churn_Analysis.pbix
│   ├── dashboard_screenshot.png
|   └── Customer_Churn_Analysis.pdf
│
├── reports/
│   └── business_insights.md
│
└── README.md
```


## How to Reproduce the Project

1. Clone this repository.
2. Install Python and the required libraries.
3. Open the Jupyter notebooks and execute them in sequence.
4. Import the cleaned CSV into PostgreSQL.
5. Execute the SQL scripts to reproduce the business analysis.
6. Open the Power BI `.pbix` file to explore the interactive dashboard.

### Python Dependencies

```bash
pip install pandas numpy matplotlib seaborn jupyter
```

PostgreSQL and Power BI Desktop are required for the corresponding stages.

## Project Objective

This project demonstrates an end-to-end data analytics workflow, from raw data inspection and cleaning to SQL-based analysis, interactive visualisation and business recommendations.

The emphasis is on transforming raw customer data into meaningful insights that can support data-driven business decisions.

---

**Author:** Hasnain989 
**Project:** Telco Customer Churn Analysis  
**Technologies:** Python | Pandas | PostgreSQL | SQL | Power BI
