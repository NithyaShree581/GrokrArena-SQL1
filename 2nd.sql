-- 1. Create table
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    salary INT
);

-- 2. Insert records
INSERT INTO Employees (id, salary)
VALUES
    (1, 100),
    (2, 200),
    (3, 300);

-- 3. Create function
CREATE FUNCTION getNthHighestSalary(N INT)
RETURNS INT
DETERMINISTIC
RETURN (
    SELECT DISTINCT salary
    FROM Employees
    ORDER BY salary DESC
    LIMIT 1 OFFSET N - 1
);

-- 4. Execute function
SELECT getNthHighestSalary(2);
SELECT getNthHighestSalary(4);