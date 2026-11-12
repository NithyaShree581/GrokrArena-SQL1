
CREATE TABLE Traffic (
    user_id INT,
    activity ENUM(
        'login',
        'logout',
        'jobs',
        'groups',
        'homepage'
    ),
    activity_date DATE
);

INSERT INTO Traffic VALUES
(1, 'login', '2019-05-01'),
(1, 'homepage', '2019-05-01'),
(1, 'logout', '2019-05-01'),
(2, 'login', '2019-06-21'),
(2, 'logout', '2019-06-21'),
(3, 'login', '2019-01-01'),
(3, 'jobs', '2019-01-01'),
(3, 'logout', '2019-01-01'),
(4, 'login', '2019-06-21'),
(4, 'groups', '2019-06-21'),
(4, 'logout', '2019-06-21'),
(5, 'login', '2019-03-01'),
(5, 'logout', '2019-03-01'),
(5, 'login', '2019-06-21'),
(5, 'logout', '2019-06-21');

SELECT
    first_login AS login_date,
    COUNT(*) AS user_count
FROM (
    SELECT
        user_id,
        MIN(activity_date) AS first_login
    FROM Traffic
    WHERE activity = 'login'
    GROUP BY user_id
) AS first_logins
WHERE first_login BETWEEN '2019-04-02' AND '2019-06-30'
GROUP BY first_login;
