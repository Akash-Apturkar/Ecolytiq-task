-- Creating a common table expression
WITH cte_avg_co2_monthly AS (
SELECT 
t.account_id, 
t.transaction_category,
date_trunc('month',t.transaction_date) AS month, 
SUM(transaction_amount) AS transaction_volume_monthly, -- aggregate of trx volume over 1 month for given id
SUM(t.aggregate_co2_footprint) co2_volume_monthly, -- aggregate of CO2 footprint volume over 1 month for given id


FROM transactions t
GROUP BY account_id,transaction_category,date_trunc('month',t.transaction_date)
)

SELECT account_id, 
transaction_category,
month, 
co2_volume_monthly/transaction_volume_monthly AS CO2_per_EUR,

CASE WHEN (co2_volume_monthly/transaction_volume_monthly) <= 1.5 THEN bucket_1
WHEN (co2_volume_monthly/transaction_volume_monthly) BETWEEN 1.6 AND 2.5 THEN bucket_2
WHEN (co2_volume_monthly/transaction_volume_monthly) >= 2.6 THEN bucket_3
END AS cluster


FROM cte_avg_co2_monthly