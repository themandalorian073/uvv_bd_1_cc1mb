-- SQL SERVER – Introduction to Hierarchical Query using a Recursive CTE – A Primer --

-- basic sintax of CTE 
WITH MyCTE
AS ( SELECT EmpID, FirstName, LastName, ManagerID
FROM Employee
WHERE ManagerID IS NULL )
SELECT *
FROM MyCTE

-- example of recursive CTE
WITH MyCTE
AS ( SELECT EmpID, FirstName, LastName, ManagerID
FROM Employee
WHERE ManagerID IS NULL
UNION ALL
SELECT EmpID, FirstName, LastName, ManagerID
FROM Employee
INNER JOIN MyCTE ON Employee.ManagerID = MyCTE.EmpID
WHERE Employee.ManagerID IS NOT NULL )
SELECT *
FROM MyCTE

-- adding anchor and recursive quary to a CTE
WITH EmployeeList
AS ( SELECT Boss.EmpID, Boss.FirstName, Boss.LastName, Boss.ManagerID
FROM Employee AS Boss
WHERE Boss.ManagerID IS NULL
UNION ALL
SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID
FROM Employee AS Emp
WHERE Employee.ManagerID IS NOT NULL )
SELECT * FROM EmployeeList

-- adding expressions to track hierarchical level
WITH EmployeeList
AS ( SELECT Boss.EmpID, Boss.FirstName, Boss.LastName, Boss.ManagerID
1 as EmpLevel
FROM Employee AS Boss
WHERE Boss.ManagerID IS NULL
UNION ALL
SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID
2 as EmpLevel -- just as a placeholder
FROM Employee AS Emp
WHERE Employee.ManagerID IS NOT NULL )
SELECT * FROM EmployeeList

-- adding a self-referencing INNER JOIN statement
WITH EmployeeList
AS ( SELECT Boss.EmpID, Boss.FirstName, Boss.LastName, Boss.ManagerID
1 as EmpLevel
FROM Employee AS Boss
WHERE Boss.ManagerID IS NULL
UNION ALL
SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID, EL.EmpLevel + 1
FROM Employee AS Emp
INNER JOIN EmployeeList AS EL
ON Emp.ManegerID = EL.EmpID
WHERE Employee.ManagerID IS NOT NULL )
SELECT * FROM EmployeeList



-- SQL Server Recursive CTE --
-- Summary: in this tutorial, you will learn how to use the SQL Server recursive CTE to query hierarchical data. --

-- basic sintax of a recursive CTE
WITH expression_name (column_list)
AS
(
    -- Anchor member
    initial_query  
    UNION ALL
    -- Recursive member that references expression_name.
    recursive_query  
)
-- references expression name
SELECT *
FROM   expression_name

