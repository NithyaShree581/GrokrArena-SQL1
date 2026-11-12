USE sql_assignment;
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(10),
    managerId INT
);
INSERT INTO Employee
(id, name, department, managerId)
VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);
SELECT * FROM Employee;
SELECT m.name
FROM Employee e
JOIN Employee m
    ON e.managerId = m.id
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;