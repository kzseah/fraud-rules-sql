DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    transaction_id BIGINT PRIMARY KEY,
    user_id INT,
    `timestamp` DATETIME,
    amount DECIMAL(12,2),
    transaction_type VARCHAR(20),
    device_id VARCHAR(50),
    country VARCHAR(50),
    ip_address VARCHAR(50)
);

INSERT INTO transactions VALUES
(500001, 1001, '2025-08-27 10:32:00', 8500.00, 'transfer', 'dev_3321', 'Malaysia', '172.16.0.1'),
(500002, 1001, '2025-08-27 10:34:00',   50.00, 'payment',  'dev_3321', 'Singapore', '10.0.0.3'),
(500003, 1001, '2025-08-27 10:35:00',   70.00, 'payment',  'dev_9999', 'Singapore', '10.0.0.3'),
(500004, 1002, '2025-08-27 11:10:00',   20.00, 'topup',    'dev_1234', 'Malaysia',  '172.16.0.2'),
(500005, 1003, '2025-08-27 11:15:00', 5500.00, 'transfer', 'dev_8888', 'Singapore', '192.168.1.5');
