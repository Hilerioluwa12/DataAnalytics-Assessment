-- Assessment_Q2.sql
WITH monthly_transactions AS (
    SELECT 
        owner_id,
        DATE_TRUNC('month', transaction_date) AS month,
        COUNT(*) AS transactions
    FROM 
        savings_savingsaccount
    GROUP BY 
        owner_id, DATE_TRUNC('month', transaction_date)
SELECT 
    CASE 
        WHEN AVG(transactions) >= 10 THEN 'High Frequency'
        WHEN AVG(transactions) BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(DISTINCT owner_id) AS customer_count,
    ROUND(AVG(transactions), 1) AS avg_transactions_per_month
FROM 
    monthly_transactions
GROUP BY 
    frequency_category;
