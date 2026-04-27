USE hr_analytics;

-- ─────────────────────────────────────────
-- QUERY 1: Overall Attrition Rate
-- ─────────────────────────────────────────
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees;


-- ─────────────────────────────────────────
-- QUERY 2: Attrition by Department
-- ─────────────────────────────────────────
SELECT 
    j.department,
    COUNT(*) AS total,
    SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees e
JOIN job_details j ON e.employee_id = j.employee_id
GROUP BY j.department
ORDER BY attrition_rate DESC;


-- ─────────────────────────────────────────
-- QUERY 3: Attrition by Job Role
-- ─────────────────────────────────────────
SELECT 
    j.job_role,
    COUNT(*) AS total,
    SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees e
JOIN job_details j ON e.employee_id = j.employee_id
GROUP BY j.job_role
ORDER BY attrition_rate DESC;


-- ─────────────────────────────────────────
-- QUERY 4: Salary vs Attrition (Income Bands)
-- ─────────────────────────────────────────
SELECT 
    CASE 
        WHEN s.monthly_income < 3000  THEN 'Low (< 3K)'
        WHEN s.monthly_income < 6000  THEN 'Mid (3K-6K)'
        WHEN s.monthly_income < 10000 THEN 'Upper-Mid (6K-10K)'
        ELSE 'High (10K+)'
    END AS income_band,
    COUNT(*) AS total,
    SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
GROUP BY income_band
ORDER BY attrition_rate DESC;


-- ─────────────────────────────────────────
-- QUERY 5: Overtime Impact on Attrition
-- ─────────────────────────────────────────
SELECT 
    j.overtime,
    COUNT(*) AS total,
    SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees e
JOIN job_details j ON e.employee_id = j.employee_id
GROUP BY j.overtime;


-- ─────────────────────────────────────────
-- QUERY 6: Job Satisfaction vs Attrition
-- ─────────────────────────────────────────
SELECT 
    sa.job_satisfaction,
    COUNT(*) AS total,
    SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees e
JOIN satisfaction sa ON e.employee_id = sa.employee_id
GROUP BY sa.job_satisfaction
ORDER BY sa.job_satisfaction;


-- ─────────────────────────────────────────
-- QUERY 7: Tenure Analysis (Years at Company)
-- ─────────────────────────────────────────
SELECT 
    CASE 
        WHEN j.years_at_company <= 2  THEN '0-2 Years'
        WHEN j.years_at_company <= 5  THEN '3-5 Years'
        WHEN j.years_at_company <= 10 THEN '6-10 Years'
        ELSE '10+ Years'
    END AS tenure_band,
    COUNT(*) AS total,
    SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN e.attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees e
JOIN job_details j ON e.employee_id = j.employee_id
GROUP BY tenure_band
ORDER BY attrition_rate DESC;


-- ─────────────────────────────────────────
-- QUERY 8: Age Group vs Attrition
-- ─────────────────────────────────────────
SELECT 
    CASE 
        WHEN age < 25 THEN 'Under 25'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        ELSE '45+'
    END AS age_group,
    COUNT(*) AS total,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY age_group
ORDER BY attrition_rate DESC;


-- ─────────────────────────────────────────
-- QUERY 9: Multi-factor Risk Profile (CTE)
-- Window Functions + CTE combined
-- ─────────────────────────────────────────
WITH risk_profile AS (
    SELECT 
        e.employee_id,
        e.age,
        e.attrition,
        j.department,
        j.job_role,
        j.overtime,
        j.years_at_company,
        s.monthly_income,
        sa.job_satisfaction,
        sa.work_life_balance,
        -- Risk Score calculation
        (CASE WHEN j.overtime = 'Yes' THEN 2 ELSE 0 END +
         CASE WHEN sa.job_satisfaction <= 2 THEN 2 ELSE 0 END +
         CASE WHEN s.monthly_income < 3000 THEN 2 ELSE 0 END +
         CASE WHEN j.years_at_company <= 2 THEN 1 ELSE 0 END +
         CASE WHEN sa.work_life_balance <= 2 THEN 1 ELSE 0 END) AS risk_score
    FROM employees e
    JOIN job_details j   ON e.employee_id = j.employee_id
    JOIN salaries s      ON e.employee_id = s.employee_id
    JOIN satisfaction sa ON e.employee_id = sa.employee_id
)
SELECT *,
    CASE 
        WHEN risk_score >= 6 THEN 'High Risk'
        WHEN risk_score >= 3 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM risk_profile
ORDER BY risk_score DESC;


-- ─────────────────────────────────────────
-- QUERY 10: Department-wise Avg Salary + Satisfaction
-- ─────────────────────────────────────────
SELECT 
    j.department,
    ROUND(AVG(s.monthly_income), 2)       AS avg_salary,
    ROUND(AVG(sa.job_satisfaction), 2)    AS avg_job_satisfaction,
    ROUND(AVG(sa.work_life_balance), 2)   AS avg_wlb,
    ROUND(AVG(j.years_at_company), 2)     AS avg_tenure
FROM job_details j
JOIN salaries s      ON j.employee_id = s.employee_id
JOIN satisfaction sa ON j.employee_id = sa.employee_id
GROUP BY j.department;