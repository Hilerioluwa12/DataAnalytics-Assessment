-- Assessment_Q4.sql
SELECT 
    u.id AS customer_id,
    u.name,
    EXTRACT(MONTH FROM (CURRENT_DATE - u.signup_date)) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND((COUNT(s.id) / EXTRACT(MONTH FROM (CURRENT_DATE - u.signup_date))) * 12 * 
          (0.001 * AVG(s.confirmed_amount / 100.0), 2) AS estimated_clv  -- 0.1% profit
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
GROUP BY 
    u.id, u.name, u.signup_date
ORDER BY 
    estimated_clv DESC;
