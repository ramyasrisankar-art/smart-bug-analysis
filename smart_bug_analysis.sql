-- ==============================
-- SMART BUG ANALYSIS QUERIES
-- ==============================

-- 1. Total Number of Bugs
SELECT COUNT(*) AS Total_Bugs
FROM bug_data;
-- 2. Project-wise Bug Count
SELECT Project_Name,
       COUNT(*) AS Bug_Count
FROM bug_data
GROUP BY Project_Name;
-- 3. Status-wise Bug Count
SELECT Status,
       COUNT(*) AS Bug_Count
FROM bug_data
GROUP BY Status;
-- 4. Priority-wise Bug Count
SELECT Priority,
       COUNT(*) AS Bug_Count
FROM bug_data
GROUP BY Priority;
-- 5. Average Resolution Days
SELECT ROUND(AVG(Resolution_Days), 2) AS Average_Resolution_Days
FROM bug_data;
-- 6. Open Bugs
SELECT *
FROM bug_data
WHERE Status = 'Open';
-- 7. High Priority Bugs
SELECT *
FROM bug_data
WHERE Priority = 'High';
-- 8. Open + High Priority Bugs
SELECT *
FROM bug_data
WHERE Status = 'Open'
AND Priority = 'High';
-- 9. Project-wise Average Resolution Days
SELECT Project_Name,
       ROUND(AVG(Resolution_Days), 2) AS Average_Resolution_Days
FROM bug_data
GROUP BY Project_Name
ORDER BY Average_Resolution_Days DESC;
-- 10. Check Duplicate Bug IDs
SELECT Bug_ID,
       COUNT(*) AS Duplicate_Count
FROM bug_data
GROUP BY Bug_ID
HAVING COUNT(*) > 1;
-- 11. Assignee-wise Bug Count
SELECT Assigned_To,
       COUNT(*) AS Bug_Count
FROM bug_data
GROUP BY Assigned_To
ORDER BY Bug_Count DESC;
-- 12. Open Bugs by Assignee
SELECT Assigned_To,
       COUNT(*) AS Open_Bugs
FROM bug_data
WHERE Status = 'Open'
GROUP BY Assigned_To
ORDER BY Open_Bugs DESC;
-- 13. Critical Priority Bugs
SELECT Bug_ID,
       Project_Name,
       Bug_Description,
       Status,
       Assigned_To
FROM bug_data
WHERE Priority = 'Critical';
-- 14. Priority and Status Analysis
SELECT Priority,
       Status,
       COUNT(*) AS Bug_Count
FROM bug_data
GROUP BY Priority, Status
ORDER BY Priority, Status;
-- 15. Bug Details with Project Team
SELECT b.Bug_ID,
       b.Project_Name,
       b.Bug_Description,
       p.Team_Type
FROM bug_data b
JOIN project_info p
ON b.Project_Name = p.Project_Name;
-- 16. Resolution Category Analysis
SELECT
    Bug_ID,
    Resolution_Days,
    CASE
        WHEN Resolution_Days IS NULL THEN 'Not Resolved'
        WHEN Resolution_Days <= 2 THEN 'Fast'
        ELSE 'Slow'
    END AS Resolution_Category
FROM bug_data;
-- 17. Resolution Category Count
SELECT
    CASE
        WHEN Resolution_Days IS NULL THEN 'Not Resolved'
        WHEN Resolution_Days <= 2 THEN 'Fast'
        ELSE 'Slow'
    END AS Resolution_Category,
    COUNT(*) AS Bug_Count
FROM bug_data
GROUP BY Resolution_Category;
-- 18. Bugs Above Average Resolution Time
SELECT *
FROM bug_data
WHERE Resolution_Days > (
    SELECT AVG(Resolution_Days)
    FROM bug_data
);
-- 19. Top 3 Longest Resolution Bugs
SELECT Bug_ID,
       Project_Name,
       Bug_Description,
       Resolution_Days
FROM bug_data
WHERE Resolution_Days IS NOT NULL
ORDER BY Resolution_Days DESC
LIMIT 3;
-- 20. Unresolved Bugs
SELECT Bug_ID,
       Project_Name,
       Status,
       Resolution_Days
FROM bug_data
WHERE Resolution_Days IS NULL;