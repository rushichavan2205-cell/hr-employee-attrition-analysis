create database company_attrition;
use company_attrition;

SELECT * FROM `hr-employee-attrition` ;

ALTER TABLE `hr-employee-attrition` RENAME TO hr_employee_attrition;

select*from hr_employee_attrition;

SELECT COUNT(*) FROM hr_employee_attrition;

-- 1. Display the first 10 rows from the table
   select*from hr_employee_attrition limit 10;
   
-- 2. Find the total number of employees in the company 
   select count(*) as  total_employees from hr_employee_attrition;

-- 3. List all unique departments.
    select distinct department from hr_employee_attrition;
    
-- 4. Show how many employees have left the company and how many are still working.
     select Attrition,count(*) as emplyoee_count 
     from hr_employee_attrition
     group by Attrition;
     
-- 5. Retrieve the list of employees who work overtime 
      select*from hr_employee_attrition
      where overtime='Yes';
      
-- 6. Find the average monthly income of all employees
     select round(avg(MonthlyIncome),2) as avg_monthly_income from hr_employee_attrition;
     
-- 7. Identify employees whose number of companies worked is missing (NULL).   
      select*from hr_employee_attrition 
      where NumCompaniesWorked IS NULL;
 
-- 8. Find the employee(s) with the maximum monthly income
       select*from hr_employee_attrition
       where MonthlyIncome =( select Max(MonthlyIncome) From hr_employee_attrition);
       
-- 9. Count the number of employees by gender.
     select gender , count(*) as employee_count 
     from  hr_employee_attrition
     group by gender;
     
--  10. List all employees who have just joined (YearsAtCompany = 0)
	  select*from hr_employee_attrition
	   where YearsAtCompany=0;
     
-- 11. Calculate the attrition rate (%) by department.
       select Department,
       ROUND(AVG(Attrition = 'Yes') * 100, 2) as attrition_rate_pct
       from hr_employee_attrition
	   group by Department;
       
 -- 12. List the top 10 employees with the highest total working years.
         select*from hr_employee_attrition
         order by YearsAtCompany desc
         limit 10;
         
  -- 13. Group employees into tenure categories (<1yr, 1–3yr, 4–6yr, 7+yr) and count employees in each.
       select 
          case 
             when YearsAtCompany <1 then '<1yr'
             when YearsAtCompany between 1 and 3 then '1-3yr'
             when YearsAtCompany between 4 and 6 then '4-6yr'
             else '7+yr'
             end  as tenure_category,
             count(*) as employee_count
             from hr_employee_attrition 
             group by tenure_category;
             
 -- 14. Find the average monthly income by job level and attrition status.
    select 
         JobLevel,
         Attrition,
         round(avg(MonthlyIncome),2) as avg_monthly_income
         from hr_employee_attrition
         group by JobLevel,Attrition
         order by JobLevel;
         
 -- 15. Identify the top 5 job roles with the highest number of employees who left.
       select JobRole,count(*) as leavers
       from hr_employee_attrition
       where Attrition = 'Yes'
       group by JobRole
       order by leavers desc
       limit 5;
       
 -- 16. List employees who left the company within their first year.
      select*from hr_employee_attrition
      where Attrition = 'Yes' and YearsAtCompany <=1;
      
-- 17. Calculate each employee’s approximate new monthly compensation after applying their salary hike percentage
       select
           EmployeeNumber,
           MonthlyIncome,
           PercentSalaryHike,
           round(MonthlyIncome*(1+PercentSalaryHike/100.0),2) as new_monthly_income
	   from hr_employee_attrition;
       
-- 18. Count employees grouped by overtime status and attrition
      select OverTime,Attrition,count(*) as employee_count
      from hr_employee_attrition
      group by OverTime,Attrition;
      
-- 19. Display the top 10 employees who attended the most training sessions last year.
      select EmployeeNumber,TrainingTimesLastYear
      from hr_employee_attrition
      order by  TrainingTimesLastYear desc
      limit 10;
      
-- 20. Rank employees by total working years (most experienced = rank 1).
     select 
          EmployeeNumber,
          TotalWorkingYears,
          rank()over (order by TotalWorkingYears desc) as experiance_rank
	 from hr_employee_attrition;	
     
-- 21. For each department, find employees whose monthly income is in the top 25% of that department.
select employeenumber, department, monthlyincome
from (
  select *, ntile(4) over (partition by department order by monthlyincome desc) as q
  from hr_employee_attrition
) t
where q = 1;

-- 22. Divide employees into 10 income deciles and find attrition rate for each decile
select d, count(*) as total, sum(attrition = 'yes') as leavers
from (
  select *, ntile(10) over (order by monthlyincome) as d
  from hr_employee_attrition
) t
group by d;

-- 23. Create a simple risk score based on tenure, performance, overtime, and work-life balance — and list the top 50 high-risk employees
select employeenumber,
       (yearsatcompany < 2) + (performancerating <= 3) + (overtime = 'yes') + (worklifebalance <= 2) as score
from hr_employee_attrition
order by score desc
limit 50;

--  24. Create a summary view showing, for each department and job level: total employees,number of leavers, attrition rate, 
-- and average monthly incom
create view summary as
select department, joblevel,
       count(*) as total,
       sum(attrition = 'yes') as leavers,
       sum(attrition = 'yes') / count(*) * 100 as rate,
       avg(monthlyincome) as avg_income
from hr_employee_attrition
group by department, joblevel;