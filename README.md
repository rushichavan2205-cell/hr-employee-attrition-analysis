# 📊 HR Employee Attrition Analysis   

An end-to-end data analytics project that explores why employees leave a company. The data is explored in **Python**, analysed with **SQL (MySQL)** and presented in an interactive **Power BI** dashboard.

## 🎯 Objective
- Find out how many employees leave and how many stay.
- Identify which departments, job roles and working conditions (overtime, job satisfaction, income) are linked to attrition.
- Give simple recommendations to reduce attrition.

## 🗂️ Dataset
- **HR Employee Attrition** dataset 
- **1,470 employees** and **35 columns**.
- Key columns: Age, Attrition, Department, JobRole, JobLevel, MonthlyIncome, OverTime, JobSatisfaction, WorkLifeBalance, YearsAtCompany, TotalWorkingYears, PerformanceRating, PercentSalaryHike.

## 🛠️ Tools Used
| Tool | Purpose |
|---|---|
| 🐍 Python (Pandas, NumPy, Matplotlib, Seaborn) | Data checking and exploratory data analysis (EDA) |
| 🗄️ SQL (MySQL) | 24 analysis queries on the `hr_employee_attrition` table |
| 📈 Power BI | Interactive HR Analytics dashboard connected to the SQL database |

## 🔄 Project Workflow

### 1️⃣ Data Checking and EDA (Python)
- Loaded the CSV and checked shape, data types and summary statistics.
- Checked for missing values and duplicate rows. 
- **Univariate analysis:** count plots and histograms.
- **Bivariate analysis:** count plots and box plots against Attrition.
- Exported the cleaned dataset to CSV.

### 2️⃣ Data Analysis (SQL)
Created the `company_attrition` database and wrote 24 queries covering:
- **Basic queries:** total employees, departments, attrition count, overtime employees, average income.
- **Aggregations:** attrition rate by department, top 5 job roles with most leavers, overtime vs attrition.
- **Conditional logic:** tenure groups using `CASE`, new salary after hike.
- **Window functions:** `RANK()` and `NTILE()`.
- **Business logic:** attrition risk score and a summary `VIEW`.

### 3️⃣ Dashboard (Power BI)
Connected Power BI to the MySQL database and built the **HR Analytics Dashboard** with:
- **KPI cards:** Total Employees, Attrition Count, Attrition Rate %, Active Employees.
- **Department slicer** to filter the page.
- **Charts:** Attrition by Department, Gender, Overtime, Job Role, Job Satisfaction and Monthly Income.

## 💡 Key Insights
- 👥 Out of **1,470** employees, **237 left** and **1,233 are still working**.
- 📉 The overall attrition rate is **16.12%**.
- 🔬 **Research & Development** and **Sales Executive** roles contribute the most to attrition.

## ✅ Recommendations
- 🎯 Focus retention efforts on **Sales Executive** roles.
- ⏰ Reduce overtime workload, because employees working overtime show higher attrition.
- 😊 Track job satisfaction regularly and act early on low scores.
