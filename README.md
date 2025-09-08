# Fraud Detection SQL Rules

This repo demonstrates fraud detection rules implemented in SQL using **CTEs**.

## Rules Implemented
1. **HIGH_AMOUNT** – Transaction amount > 10,000  
2. **NEW_DEVICE** – First time a user uses a new device  
3. **MULTI_COUNTRY** – Same user transacts in different countries within 24 hours  
4. **RAPID_TXN** – Multiple transactions by same user within 5 minutes  

## Files
- `fraud_rules.sql` → SQL script with CTE-based rules.  
- `sample_data.sql` → Creates the `transactions` table and inserts 5 sample rows.  
- `generate_fake_data.py` → Script to generate synthetic data using [Faker](https://faker.readthedocs.io/).  

## Usage
Load sample data and run rules in MySQL:

```bash
mysql -u youruser -p yourdb < sample_data.sql
mysql -u youruser -p yourdb < fraud_rules.sql
