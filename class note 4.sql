--Create a new column which indicate bonus for each employee;
--Bonus is calculated based on following logic:
--it is 10 percent if salary is less than 30,000 -- it is 8 percent if salary is between 30,000 and 50,000
--it is 5 percent if salary is more than 50,000

select fname, lname, salary,
case 
when salary<30000 then salary*0.01
when salary between 30000 and 50000 then salary*0.08
when salary>50000 then salary*0.05
end as bonus
from employee;

--How much bonus was paid by the company?
select 
sum(case 
when salary<30000 then salary*0.01
when salary between 30000 and 50000 then salary*0.08
when salary>50000 then salary*0.05
end) as total_bonus
from employee;


--############################### Window Function #################################
--# 1. LAG (Gives us the previous row)
--# 2. LEAD (Gives us the next row)
--# 3. ROW NUMBER (Give number to each row)
--# 4. RANK (Rank all the values)
--# 5. DENSE RANK (Rank all the values)

select ssn as employee_id, fname, lname, salary, dno,
lag(salary) over(order by salary asc) as salary_previous,
lead(salary) over(order by salary asc) as salary_next,
row_number() over(order by salary asc) as row_num,
rank() over(order by salary asc) as rank_salary,
dense_rank() over(order by salary asc) as dense_rank_salary
from employee
order by salary asc ;

--###### Partition in Window functions

select ssn as employee_id, fname, lname, salary, dno,
row_number() over(partition by dno order by salary asc) as row_num,
rank() over(partition by dno order by salary asc) as rank_num
from employee
order by dno, salary asc ;

--##################### OFFSET in Window Functions

select ssn, salary,
lag(salary) over(order by salary asc) as salary_lag,
lag(salary,2) over(order by salary asc) as salary_lag2,
lead(salary) over(order by salary asc) as salary_lead,
lead(salary,2) over(order by salary asc) as salary_lead2
from employee;