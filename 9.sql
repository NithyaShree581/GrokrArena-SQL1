CREATE TABLE Transactions (
    id INT PRIMARY KEY,
    country VARCHAR(20),
    state ENUM('approved', 'declined'),
    amount INT,
    trans_date DATE
);

CREATE TABLE Chargebacks (
    trans_id INT,
    trans_date DATE
);

INSERT INTO Transactions VALUES
(101, 'US', 'approved', 1000, '2019-05-18'),
(102, 'US', 'declined', 2000, '2019-05-19'),
(103, 'US', 'approved', 3000, '2019-06-10'),
(104, 'US', 'declined', 4000, '2019-06-13'),
(105, 'US', 'approved', 5000, '2019-06-15');

INSERT INTO Chargebacks VALUES
(102, '2019-05-29'),
(101, '2019-06-30'),
(105, '2019-09-18');

SELECT
    DATE_FORMAT(t.trans_date, '%Y-%m') AS month,
    t.country,
    SUM(t.state = 'approved') AS approved_count,
    SUM(CASE WHEN t.state = 'approved' THEN t.amount ELSE 0 END) AS approved_amount,
    COUNT(c.trans_id) AS chargeback_count,
    COALESCE(SUM(c.amount), 0) AS chargeback_amount
FROM (
    SELECT
        id, country, state, amount, trans_date
    FROM Transactions

    UNION ALL

    SELECT
        t.id, t.country, 'chargeback', t.amount, c.trans_date
    FROM Chargebacks c
    JOIN Transactions t ON c.trans_id = t.id
) t
LEFT JOIN (
    SELECT trans_id, amount
    FROM Chargebacks c
    JOIN Transactions t ON c.trans_id = t.id
) c ON t.id = c.trans_id
    AND t.state = 'chargeback'
GROUP BY month, t.country;