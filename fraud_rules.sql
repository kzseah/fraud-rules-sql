-- fraud_rules.sql
-- Fraud Detection Rules (CTE Version)
-- Rules: HIGH_AMOUNT (> 10,000), NEW_DEVICE, MULTI_COUNTRY (24h), RAPID_TXN (5min)

WITH
high_amount AS (
    SELECT transaction_id, 'HIGH_AMOUNT' AS flag
    FROM transactions
    WHERE amount > 10000
),

new_device AS (
    SELECT t.transaction_id, 'NEW_DEVICE' AS flag
    FROM transactions t
    WHERE NOT EXISTS (
        SELECT 1
        FROM transactions d
        WHERE d.user_id = t.user_id
          AND d.device_id = t.device_id
          AND d.transaction_id < t.transaction_id
    )
),

multi_country AS (
    SELECT DISTINCT t.transaction_id, 'MULTI_COUNTRY' AS flag
    FROM transactions t
    JOIN transactions t2
      ON t.user_id = t2.user_id
     AND t.transaction_id <> t2.transaction_id
     AND t.country <> t2.country
     AND ABS(TIMESTAMPDIFF(HOUR, t.timestamp, t2.timestamp)) < 24
),

rapid_txn AS (
    SELECT DISTINCT t.transaction_id, 'RAPID_TXN' AS flag
    FROM transactions t
    JOIN transactions t2
      ON t.user_id = t2.user_id
     AND t.transaction_id <> t2.transaction_id
     AND ABS(TIMESTAMPDIFF(MINUTE, t.timestamp, t2.timestamp)) < 5
),

all_flags AS (
    SELECT * FROM high_amount
    UNION ALL
    SELECT * FROM new_device
    UNION ALL
    SELECT * FROM multi_country
    UNION ALL
    SELECT * FROM rapid_txn
),

fraud_summary AS (
    SELECT 
        transaction_id,
        GROUP_CONCAT(flag ORDER BY flag SEPARATOR ',') AS fraud_flag
    FROM all_flags
    GROUP BY transaction_id
)

SELECT 
    t.*,
    COALESCE(f.fraud_flag, '') AS fraud_flag
FROM transactions t
LEFT JOIN fraud_summary f
  ON t.transaction_id = f.transaction_id
ORDER BY t.transaction_id;
