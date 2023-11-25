
############## NULL Condition ############
select * from employee where super_ssn is null;

--Select all rows from works_on table where work hours are missing
select * from works_on where hours is null;

--Select all rows from works on table where hours is not null
select * from works_on where hours is not null;

--########### Sorting Data ###################
select * from employee order by salary asc;

select * from employee order by salary desc;

--Select all employees whose salary is greater than 30000 or they are from department 4 or 5 and sort the ouput based on salary;
select *
from employee
where salary>30000 OR dno in (4,5)
order by salary asc; 

--Select pno and hours from work on table where hours is not null and pno is less than 5 and sort data based on hours in increasing order;
select pno,hours
from works_on
where hours is not null and pno<5
order by hours asc;


---##################### Aggregate Functions ###########################

--How many rows are there in employee table
select count(*) as nbrofrows from employee;

--how many rows are there in dependent table?
select count(*) from dependent;

--Count number of distinct departments from employee table;
select count(distinct dno) as nbr_of_departments from employee;
select distinct dno from employee;

--Count the number of employees in the dependent table;
select count(distinct essn) from dependent;

--Give list of the distinct employee from dependent table;
select distinct essn from dependent;

--Get minimum salary from employee table
select min(salary) as minimum_salary from employee;

--Get maximum salary from employee table
select max(salary) from employee;

--Get avg salary from employee table
select avg(salary) as avg_salary, min(salary) as min_salary, max(salary) as max_salary
from employee;

--Get total salary paid by the company to employees
select sum(salary) from employee;


--Get minimum, maximum, avg and total salary for Male employees;
select min(salary) as min_salary, max(salary) as max_salary, avg(salary) as avg_salary, sum(salary) as total_salary
from employee
where sex='M';


---############################ Date Functions #############################
--Select birthdate, year of birth , month of brth for each employee
select ssn as employee_id, bdate as birth_date, year(bdate) as birth_year, month(bdate) as birth_month
from employee;


--Select minimum and maximum birthdate from employee table;
select min(bdate) as min_date, max(bdate) as max_Date 
from employee;


--#################### Concat function ######################
select fname as first_name, lname as last_name, concat(fname, " ", lname) as fullname
from employee;

--###Sub string function
select fname, substr(fname, 2,4)  from employee;

----*****Left and Right function
select fname, left(fname,3) as left_name, right(fname,2) as right_name from employee;


---*****#Exercise******
--#1. What is highest number of hours someone worked on a project
select max(hours) from works_on;

--#2. What is salary range in the company? (Salary range is difference between highest and lowest salary)
select (max(salary) - min(salary)) as salary_range from employee;

--#3. How many distinct department locations are there?
select count(distinct dlocation) as distinct_locations from dept_locations;

--#4. How many distinct employees have "daughter" as dependent?
select count(distinct essn) as nbrofemployees from dependent where relationship='Daughter';

--#5. How many prjects are there under deartment number 5
select count(distinct pnumber) as nbrofprojects from project where dnum=5;

--#6. What is avg salary of the employees who are male and are from department 5?
select avg(salary) from employee where dno=5 and sex='M' ;



select * from employee;


--What is the avg salary of department 4;
select avg(salary) from employee where dno=4;

--What is the avg salary of department 5;
select avg(salary) from employee where dno=5;

--What is te avg salry of deptartment 1;
select avg(salary) from employee where dno=1;

--################################# Group by ##############################
select dno, avg(salary) as avg_salary
from employee
group by dno;

--What is the avg salary by gender;
Select sex, avg(salary) as avg_salary from employee group by sex;

--Find the number of dependents for each employee;
select essn, count(*) as nbrofdependents
from dependent 
group by 1;

--Find total hours spent on each project;
select pno,sum(hours) as total_hours 
from works_on 
group by pno;

--Find the maximum and the avg salary for each department;
select dno, max(salary) as max_salary, avg(salary) as avg_salary
from employee
group by dno;

--Find the avg and maximum salary for male in each department and order the output in desc by department number;
select dno, avg(salary) as avg_salary, max(salary) as max_salary
from employee 
where sex="M"
group by dno
order by dno asc;


---######################## Having Clause #####################
---List all employees with number of dependents;
select essn, count(*) as nbrofdependents
from dependent 
group by 1;

--Find the list of employees who have at least 2 dependents;
select essn, count(*) as nbrofdependents
from dependent
group by 1
having count(*)>=2;

--List all departments which have more than 1 employee;
select dno, count(*) as nbrofemployee
from employee 
group by dno
having count(*)>1;

--Give list of all departments where avg salary is more than 35000;
select dno, avg(salary)
from employee
group by dno
having avg(salary)>35000;

--########################## CASE WHEN STATEMENT ##########################

--Create a new column which is ">=35K" if salary is more than 35000 else it is "<35K"
select ssn as employee_id, salary,
case 
when salary>=35000 then '>=35K'
when salary<35000 then '<35K'
end as salary_bucket
from employee;

--Create a new column gender_flag which is 1 if gender is male, 0 if gender is female and 2 if gender is "Others"

select ssn, sex,
case
when sex='M' then 1
when sex='F' then 0
when sex='Others' then 2
end as gender_flag
from employee;

--Create two columns male_salary and female_salary, "male_salary" column should have value of salary only for male employees and similarly
-- "female_salary" column should have salary only for female employees;

select ssn, sex, salary,
case
when sex='M' then salary
end as male_salary,
case 
when sex='F' then salary
end as female_salary
from employee;

--What if we wanted "0" as a default value where ever we are not meeting any condition;

select ssn, sex, salary,
case
when sex='M' then salary
else 0
end as male_salary,
case 
when sex='F' then salary
else 0
end as female_salary
from employee;

--########################## Using CASE WHEN with aggregate functions #########################

--Give avg salary by gender;

select sex, avg(salary) from employee group by sex;

select
avg(case when sex='M' then salary end) as male_avg_salary,
avg(case when sex='F' then salary end) as female_avg_salary
from employee;

--Create a column which classifies a project into big or small based on how many hours employee worked on it
--IF employee worked for more than 20 hours mark then as "Big" else mark it as "Small"

select *,
case
when hours<=20 then 'Small'
when hours>20 then 'Big' end as project_type
from works_on;

--For each employee crate 3 columns "number_of_daughters", "number_of_sons" and "number_of_spouse"

select essn,
count(case when relationship='Daughter' then 1 end) as nbrofdaughters,
count(case when relationship='Son' then 1 end) as nbrofsons,
count(case when relationship='Spouse' then 1 end) as nbrofspouse
from dependent
group by essn;

--########################################### Joins ##############################################

--Bring department name in the employee table

select a.*, b.dname
from employee as a
left join 
department as b 
on a.dno=b.dnumber;

select employee.*, department.dname
from employee
left join 
department
on employee.dno=department.dnumber;

--Bring first name and last name of the employee in works on table
--Need to take join between essn and ssn of works on and employee table;

Select a.*, b.fname, b.lname
from works_on as a
left join 
employee as b 
on a.essn=b.ssn;

--Bring manager employee id in the project table (Take join between department and project table)

select a.*, b.mgr_ssn
from project as a
left join 
department as b 
on a.dnum=b.dnumber;

--Find total work hours for each employee;
select essn, sum(hours) as total_hours
from works_on
group by essn;

--Bring fname and lname to the previous output;

select a.essn, b.fname, b.lname, sum(a.hours) as total_hours
from works_on as a
left join 
employee as b 
on a.essn=b.ssn
group by  a.essn, b.fname, b.lname;


--Give number of dependents for each employee;
select essn, count(*) as nbrofdepenents
from dependent
group by essn;

select a.ssn, count(b.dependent_name) as nbrofdependents
from employee as a
left join 
dependent as b 
on a.ssn=b.essn
group by a.ssn;


--List all the employees and their respective departments name and department manager;
select a.*, b.dname, b.mgr_ssn
from employee as a 
left join 
department as b 
on a.dno=b.dnumber;

--Create another column in previous outpt to flag the employees who are also manager
select a.*, b.dname, b.mgr_ssn,
case 
when a.ssn=b.mgr_ssn then 1
else 0 
end as manager_flag
from employee as a 
left join 
department as b 
on a.dno=b.dnumber;

--Add department avg salary in front of all employees in employee table
select a.*, b.avg_dept_salary
from employee as a
left join 
(select dno, avg(salary) as avg_dept_salary
from employee 
group by dno) as b 
on a.dno=b.dno;

--In above table create a new column which indicates if emplyee's salary is more or less than its dept avg salary;
select a.*, b.avg_dept_salary,
case
when a.salary>b.avg_dept_salary then 'Greater than the avg'
when a.salary<b.avg_dept_salary then 'Lesser than the avg'
when a.salary=b.avg_dept_salary then 'Same as the avg'
end as salary_bucket
from employee as a
left join 
(select dno, avg(salary) as avg_dept_salary
from employee 
group by dno) as b 
on a.dno=b.dno;


