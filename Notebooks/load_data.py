import pandas as pd
from sqlalchemy import create_engine

# ── Load CSV ──
df = pd.read_csv(r'D:\notes\6th sem\AttriSense\WA_Fn-UseC_-HR-Employee-Attrition.csv')

# ── Rename EmployeeNumber to employee_id ──
df.rename(columns={'EmployeeNumber': 'employee_id'}, inplace=True)

# ── Connect to MySQL ──
# Replace root123 with your actual MySQL password
engine = create_engine('mysql+mysqlconnector://root:nikhilroot7@localhost/hr_analytics')

# ── Split into 4 tables ──

# Table 1: employees
employees = df[['employee_id','Age','Gender','MaritalStatus',
                'Education','EducationField','DistanceFromHome',
                'NumCompaniesWorked','TotalWorkingYears','Attrition']].copy()
employees.columns = ['employee_id','age','gender','marital_status',
                     'education','education_field','distance_from_home',
                     'num_companies_worked','total_working_years','attrition']

# Table 2: salaries
salaries = df[['employee_id','MonthlyIncome','DailyRate','HourlyRate',
               'MonthlyRate','PercentSalaryHike','StockOptionLevel']].copy()
salaries.columns = ['employee_id','monthly_income','daily_rate',
                    'hourly_rate','monthly_rate',
                    'percent_salary_hike','stock_option_level']

# Table 3: job_details
job_details = df[['employee_id','Department','JobRole','JobLevel',
                  'JobInvolvement','OverTime','YearsAtCompany',
                  'YearsInCurrentRole','YearsSinceLastPromotion',
                  'YearsWithCurrManager','TrainingTimesLastYear']].copy()
job_details.columns = ['employee_id','department','job_role','job_level',
                       'job_involvement','overtime','years_at_company',
                       'years_in_current_role','years_since_promotion',
                       'years_with_curr_manager','training_times_last_year']

# Table 4: satisfaction
satisfaction = df[['employee_id','JobSatisfaction','EnvironmentSatisfaction',
                   'RelationshipSatisfaction','WorkLifeBalance',
                   'PerformanceRating']].copy()
satisfaction.columns = ['employee_id','job_satisfaction',
                        'environment_satisfaction',
                        'relationship_satisfaction',
                        'work_life_balance','performance_rating']

# ── Load into MySQL ──
print("Loading employees...")
employees.to_sql('employees', engine, if_exists='append', index=False)

print("Loading salaries...")
salaries.to_sql('salaries', engine, if_exists='append', index=False)

print("Loading job_details...")
job_details.to_sql('job_details', engine, if_exists='append', index=False)

print("Loading satisfaction...")
satisfaction.to_sql('satisfaction', engine, if_exists='append', index=False)

print("✅ All 4 tables loaded successfully!")