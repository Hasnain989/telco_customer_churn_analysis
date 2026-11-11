# Business Insights Report
## Telco Customer Churn Analysis

**Project:** Customer Churn Analysis  
**Industry:** Telecommunications  
**Dataset:** IBM Telco Customer Churn  
**Total Customers:** 7,043  
**Analysis Tools:** Python, Pandas, PostgreSQL, SQL, Power BI

---

## 1. Executive Summary

This analysis investigates customer churn patterns within a telecommunications customer base of 7,043 customers.

The primary objective was to identify customer segments associated with higher churn rates and explore how contract type, payment methods, customer tenure and monthly charges relate to customer retention.

The analysis identified an overall churn rate of **26.53%**, meaning approximately one in four customers had discontinued their service.

The strongest observed relationship was between contract type and churn. Customers on month-to-month contracts had a substantially higher churn rate than customers on one-year or two-year contracts.

Other notable patterns included higher churn among electronic-check customers and customers paying $70 or more per month.

These findings provide potential areas for further investigation and targeted customer retention strategies.

## 2. Overall Customer Churn

The dataset contains 7,043 customers, of whom 1,869 had churned and 5,174 remained.

| Customer Status | Number of Customers | Percentage |
|---|---:|---:|
| Churned | 1,869 | 26.53% |
| Retained | 5,174 | 73.47% |
| **Total** | **7,043** | **100%** |

### Business Interpretation

A churn rate of 26.53% represents a substantial proportion of the customer base.

Customer acquisition alone may not be sufficient to sustain long-term growth if a significant number of existing customers discontinue their subscriptions.

Improving customer retention could therefore be an important business priority.

## 3. Contract Type and Customer Churn

Contract type demonstrated a substantial relationship with customer churn.

| Contract Type | Total Customers | Churned Customers | Churn Rate |
|---|---:|---:|---:|
| Month-to-month | 3,875 | 1,655 | 42.71% |
| One year | 1,473 | 166 | 11.27% |
| Two year | 1,695 | 48 | 2.83% |

### Key Observation

Month-to-month customers had a churn rate of 42.71%, compared with just 2.83% among customers on two-year contracts.

This represents a difference of approximately 39.88 percentage points.

Longer-term contracts are associated with substantially lower customer churn in this dataset.

### Business Implications

Customers on flexible, month-to-month contracts may require additional attention because they are not committed to longer subscription periods.

Potential business strategies include:

- Offering incentives for customers to transition to longer-term contracts.
- Introducing loyalty benefits for customers who maintain subscriptions.
- Identifying month-to-month customers showing signs of disengagement.
- Investigating whether pricing, service quality or customer satisfaction influences their decision to leave.

However, the analysis does not establish that longer contracts directly cause lower churn. Differences in customer characteristics may also contribute.

## 4. Payment Method and Customer Churn

The analysis compared churn rates across different payment methods.

### Key Observation

Electronic check customers demonstrated the highest churn rate among the payment methods examined.

### Business Interpretation

This pattern suggests that payment method may be useful when identifying customer segments that warrant further investigation.

Possible explanations to investigate include:

- Differences in customer demographics.
- Payment convenience and user experience.
- Billing-related dissatisfaction.
- Differences in contract types.
- Differences in customer tenure.

### Business Recommendations

The company could investigate whether electronic-check customers experience more billing difficulties or whether this group differs in other characteristics associated with churn.

Improving payment convenience and encouraging alternative payment methods could be tested as potential retention initiatives.

Importantly, the observed relationship does not demonstrate that electronic checks cause customers to leave.

## 5. Customer Tenure and Churn

Customer tenure was divided into four groups:

- 0–12 months
- 13–24 months
- 25–48 months
- 49–72 months

Churn rates were compared across these groups using Power BI.

### Business Interpretation

Segmenting customers by tenure provides a way to investigate how retention patterns change throughout the customer lifecycle.

Early-tenure customers may require particular attention because problems during onboarding or initial service usage could influence their decision to discontinue a subscription.

### Business Recommendations

Potential retention initiatives include:

- Improving the onboarding experience for new customers.
- Providing proactive customer support during the first year.
- Monitoring early signs of customer dissatisfaction.
- Investigating the reasons behind churn at different stages of the customer lifecycle.

Further analysis should quantify the exact churn rate for each tenure group before allocating retention resources.

## 6. Monthly Charges and Customer Churn

Customers were divided into three monthly charge categories:

| Category | Monthly Charges |
|---|---|
| Low | Below $35 |
| Medium | $35 to below $70 |
| High | $70 and above |

### Key Observation

Customers in the highest monthly charge category demonstrated the highest churn rate.

### Business Interpretation

This suggests a potential relationship between subscription cost and customer retention.

Customers paying higher monthly charges may have greater expectations regarding service quality, reliability and overall value.

If customers perceive that the service does not justify its cost, they may be more likely to consider alternative providers.

### Business Recommendations

Potential actions include:

- Reviewing pricing structures for higher-cost subscriptions.
- Evaluating whether premium customers receive sufficient value.
- Investigating customer satisfaction across different pricing segments.
- Offering targeted retention incentives where appropriate.

Further analysis should investigate whether high monthly charges overlap with particular contract types or service combinations.

## 7. Overall Business Recommendations

Based on the observed patterns, the following actions could be considered:

### 1. Prioritise Month-to-Month Customers

The month-to-month segment has the highest observed churn rate.

The company should investigate the reasons behind this pattern and test targeted retention offers, loyalty incentives and longer-term subscription options.

### 2. Investigate Electronic Check Customers

Electronic-check customers represent a segment with particularly high churn.

Further investigation into billing experiences, demographics and subscription characteristics may help identify the underlying factors.

### 3. Review High-Priced Subscriptions

Customers paying $70 or more per month demonstrate higher churn rates.

The company should evaluate whether these customers perceive sufficient value from their subscriptions.

### 4. Strengthen Early Customer Engagement

Customer tenure should be incorporated into retention strategies.

Early customer engagement, onboarding support and proactive service assistance may help identify potential retention issues.

### 5. Adopt Data-Driven Retention Strategies

Rather than applying identical retention strategies to the entire customer base, the company could use customer segmentation to identify groups requiring different interventions.

Retention initiatives should be evaluated using measurable outcomes, particularly changes in churn rates and customer lifetime value.

## 8. Limitations of the Analysis

Several limitations should be considered when interpreting these findings.

1. **Observational data:** The analysis identifies relationships between customer characteristics and churn but does not establish causation.

2. **Dataset scope:** The findings are based on a single telecommunications dataset and may not generalise to other businesses or markets.

3. **Limited customer feedback:** The dataset does not provide detailed explanations from customers about why they discontinued their subscriptions.

4. **Potentially overlapping factors:** Contract type, monthly charges, tenure and payment methods may be related. Their individual effects cannot be isolated through simple group comparisons.

5. **No predictive modelling:** This project focuses on descriptive and diagnostic analysis rather than building a machine learning model to predict future churn.

## 9. Suggested Further Analysis

The following analyses could extend this project:

- Multivariate analysis of contract type, payment method and monthly charges.
- Customer segmentation based on service subscriptions.
- Investigation of early-tenure churn.
- Comparison of average monthly charges between retained and churned customers.
- Statistical testing to evaluate differences between customer segments.
- Development of a predictive churn model using machine learning.
- Estimation of potential revenue losses associated with customer churn.

## 10. Conclusion

This project demonstrates how customer data can be transformed into actionable business insights through data cleaning, exploratory analysis, SQL querying and interactive visualisation.

The analysis identified an overall churn rate of 26.53%, with particularly high churn among month-to-month customers, electronic-check customers and customers paying $70 or more per month.

These findings highlight several areas where further investigation and targeted retention strategies may improve customer retention.

The project also demonstrates an end-to-end data analytics workflow, from raw dataset preparation to business-focused reporting and visualisation.

---

**End of Report**