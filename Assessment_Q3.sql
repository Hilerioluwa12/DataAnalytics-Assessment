-- Assessment_Q3.sql
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Savings'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    EXTRACT(DAY FROM (CURRENT_DATE - MAX(s.transaction_date))) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.id = s.plan_id
WHERE 
    p.is_active = 1  -- Assuming an 'is_active' flag exists
GROUP BY 
    p.id, p.owner_id, p.is_a_fund
HAVING 
    MAX(s.transaction_date) < CURRENT_DATE - INTERVAL '365 days'
    OR MAX(s.transaction_date) IS NULL;
