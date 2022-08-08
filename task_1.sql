-- Creating a common table expression
WITH cte_avg_co2_monthly AS (
SELECT 
t.account_id, 
t.transaction_category,
date_trunc('month',t.transaction_date) AS month, 
SUM(transaction_amount) AS transaction_volume, -- aggregate of trx volume over 1 month for given id
SUM(t.aggregate_co2_footprint), -- aggregate of CO2 footprint volume over 1 month for given id
-- Let us assume there were two prop questions asked to each account holder: 
t.flight_count,
t.train_count,
t.flight_count/t.train_count AS flight_train_ratio,
a.answer_1, -- answer to prop question 1 
a.answer_2 -- answer to prop question 1 

FROM transactions t
LEFT JOIN answers a ON t.account_id = a.account_id