
USE hr_analytics;
-- ─────────────────────────
-- TABLE 1: employees
-- ─────────────────────────
CREATE TABLE employees (
    employee_id          INT PRIMARY KEY,
    age                  INT,
    gender               VARCHAR(10),
    marital_status       VARCHAR(20),
    education            INT,
    education_field      VARCHAR(50),
    distance_from_home   INT,
    num_companies_worked INT,
    total_working_years  INT,
    attrition            VARCHAR(5)
);

-- ─────────────────────────
-- TABLE 2: salaries
-- ─────────────────────────
CREATE TABLE salaries (
    employee_id          INT PRIMARY KEY,
    monthly_income       INT,
    daily_rate           INT,
    hourly_rate          INT,
    monthly_rate         INT,
    percent_salary_hike  INT,
    stock_option_level   INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- ─────────────────────────
-- TABLE 3: job_details
-- ─────────────────────────
CREATE TABLE job_details (
    employee_id              INT PRIMARY KEY,
    department               VARCHAR(50),
    job_role                 VARCHAR(50),
    job_level                INT,
    job_involvement          INT,
    overtime                 VARCHAR(5),
    years_at_company         INT,
    years_in_current_role    INT,
    years_since_promotion    INT,
    years_with_curr_manager  INT,
    training_times_last_year INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- ─────────────────────────
-- TABLE 4: satisfaction
-- ─────────────────────────
CREATE TABLE satisfaction (
    employee_id               INT PRIMARY KEY,
    job_satisfaction          INT,
    environment_satisfaction  INT,
    relationship_satisfaction INT,
    work_life_balance         INT,
    performance_rating        INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
USE hr_analytics;
SHOW TABLES;
USE hr_analytics;
SELECT COUNT(*) FROM employees;    
SELECT COUNT(*) FROM salaries;     
SELECT COUNT(*) FROM job_details;  
SELECT COUNT(*) FROM satisfaction; 