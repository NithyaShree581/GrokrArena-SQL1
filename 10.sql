CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50)
);

CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    host_team INT,
    guest_team INT,
    host_goals INT,
    guest_goals INT
);

INSERT INTO Teams VALUES
(10, 'Leetcode FC'),
(20, 'NewYork FC'),
(30, 'Atlanta FC'),
(40, 'Chicago FC'),
(50, 'Toronto FC');

INSERT INTO Matches VALUES
(1, 10, 20, 3, 0),
(2, 30, 10, 2, 2),
(3, 10, 50, 5, 1),
(4, 20, 30, 1, 0),
(5, 50, 30, 1, 0);

SELECT
    t.team_id,
    t.team_name,
    COALESCE(SUM(
        CASE
            WHEN t.team_id = m.host_team AND m.host_goals > m.guest_goals THEN 3
            WHEN t.team_id = m.guest_team AND m.guest_goals > m.host_goals THEN 3
            WHEN m.host_goals = m.guest_goals THEN 1
            ELSE 0
        END
    ), 0) AS num_points
FROM Teams t
LEFT JOIN Matches m
    ON t.team_id = m.host_team
    OR t.team_id = m.guest_team
GROUP BY t.team_id, t.team_name
ORDER BY num_points DESC, t.team_id ASC;