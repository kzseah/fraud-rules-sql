from faker import Faker
import random

fake = Faker()

# config
n = 20  # number of fake transactions

for i in range(1, n+1):
    transaction_id = 600000 + i
    user_id = random.randint(1000, 1010)  # 10 users
    timestamp = fake.date_time_this_month()
    amount = round(random.uniform(5, 20000), 2)
    transaction_type = random.choice(["transfer", "payment", "topup"])
    device_id = "dev_" + str(random.randint(1000, 9999))
    country = random.choice(["Malaysia", "Singapore", "Thailand", "Indonesia"])
    ip_address = fake.ipv4()

    print(f"({transaction_id}, {user_id}, '{timestamp}', {amount}, '{transaction_type}', '{device_id}', '{country}', '{ip_address}'),")
