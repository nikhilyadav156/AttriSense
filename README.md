# 🏢 HR Employee Attrition Analytics

## 📌 Problem Statement
A company is losing employees without understanding why or who will leave next.
This project analyzes HR data to find attrition patterns and predict which
employees are at high risk of leaving.

## 🛠️ Tech Stack
| Tool | Purpose |
|------|---------|
| MySQL | Database design & SQL analysis |
| Python | EDA, data processing & ML model |
| Scikit-learn | Random Forest, Logistic Regression |
| Power BI | Interactive dashboard |
| Pandas/NumPy | Data manipulation |

## 📊 Dashboard Preview
(https://github.com/nikhilyadav156/AttriSense/blob/main/Images/Screenshot%202026-04-27%20191552.png)

## 🔍 Key Insights
- Overall attrition rate is **16.1%**
- Employees working overtime are **3x more likely** to leave
- **Sales Representatives** have the highest attrition (40%)
- Employees earning **under $3K/month** are at highest risk
- **0-2 year tenure** employees leave the most

## 🤖 ML Model Results
| Model | Accuracy | ROC-AUC |
|-------|----------|---------|
| Logistic Regression | 82% | 0.89 |
| Random Forest | 86% | 0.93 |
| Gradient Boosting | 85% | 0.92 |

✅ Best Model: **Random Forest** with 86% accuracy

## 📁 Project Structure
hr-attrition-analytics/
├── data/         → Raw and processed datasets
├── sql/          → Schema and analysis queries
├── notebooks/    → EDA and ML model notebooks
├── powerbi/      → Power BI dashboard file
├── images/       → Charts and screenshots
└── README.md
## 🚀 How to Run
1. Import CSV into MySQL using `python load_data.py`
2. Run SQL queries from `sql/analysis_queries.sql`
3. Run `notebooks/model.ipynb` to generate predictions
4. Open `powerbi/HR_Attrition_Dashboard.pbix` in Power BI Desktop

## 👨‍💻 Author
**Nikhil Yadav**
