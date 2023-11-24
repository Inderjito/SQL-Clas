#creating company database

create database  company_db;
use  company_db;

--create table

create table employee(fname varchar(30),minit char(1),lname varchar(30),ssn char(9),
					  bdate date,address varchar(30),sex char(1),salary numeric(10,2),
					  super_ssn char(9),dno numeric(6),
					  constraint pk_employee PRIMARY KEY (ssn));


create table department(
	dname varchar(30),
	dnumber smallint,
	mgr_ssn char(9),
	mgr_start_date date,
	constraint pk_department PRIMARY KEY (dnumber)
);

create table dept_locations(
	dnumber smallint,
	dlocation varchar(20),
	constraint pk_dept_loc PRIMARY KEY (dnumber,dlocation)
);

create table project(
	pname varchar(30),
	pnumber smallint,
	plocation varchar(30),
	dnum smallint,
	constraint pk_project PRIMARY KEY (pnumber)
);

create table works_on(
	essn char(9),
	pno smallint,
	hours numeric(4,2),
	constraint pk_works_on PRIMARY KEY (essn, pno)
);

create table dependent(
	essn char(9),
	dependent_name varchar(30),
	sex char(1),
	bdate date,
	relationship varchar(20),
	constraint pk_dependent PRIMARY KEY (essn, dependent_name)
);



insert into employee(fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) VALUES
('John','B','Smith','123456789','1965-01-09','731 Fondren, Houston, TX','M',30000,'333445555',5),
('Franklin','T','Wong','333445555','1955-01-09','638 Fondren, Houston, TX','M',40000,'888665555',5),
('Alicia','J','Zelaya','999887777','1968-01-09','3321 Fondren, Houston, TX','F',25000,'987654321',4),
('Jennifer','S','Wallace','987654321','1941-01-09','21 Fondren, Houston, TX','F',43000,'888665555',4),
('Ramesh','K','Narayan','666884444','1962-01-09','975 Fondren, Houston, TX','M',38000,'333445555',5),
('Joyce','A','English','453453453','1972-01-09','5631 Fondren, Houston, TX','F',25000,'333445555',5),
('Ahmad','V','Jabbar','987987987','1969-01-09','980 Fondren, Houston, TX','M',25000,'987654321',4),
('James','E','Borg','888665555','1937-01-09','450 Fondren, Houston, TX','M',55000,NULL,1);

insert into department(dname,dnumber,mgr_ssn,mgr_start_date) VALUES
('Research',5,333445555,'1988-05-22'),
('Administration',4,987654321,'1995-05-22'),
('Headquarters',1,888665555,'1981-05-22');

insert into dept_locations(dnumber,dlocation) values
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

insert into works_on (essn, pno, hours) values
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, NULL);

insert into project(pname,pnumber,plocation,dnum) values
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

insert into dependent(essn,dependent_name,sex,bdate,relationship) values
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-04-05', 'Son'),
('333445555', 'Joy', 'F', '1958-04-05', 'Spouse'),
('987654321', 'Abner', 'M', '1942-04-05', 'Spouse'),
('123456789', 'Michael', 'M', '1988-04-05', 'Son'),
('123456789', 'Alice', 'M', '1988-04-05', 'Daughter'),
('123456789', 'Elizabeth', 'M', '1967-04-05', 'Spouse');




create table student(
	student_id int,
	name varchar(255),
	age int,
	gender char(1),
	address varchar(255),
	phone_number varchar(20),
	created_at date,
	updated_at date
);

insert into student (student_id, name, age, gender, address, phone_number, created_at, updated_at) values
(1, 'John Doe', 25, 'M', '123 Main Street', '123-456-7890', '2023-08-29', '2023-08-29'),
(2, 'Jane Doe', 22, 'F', '456 Elm Street', '456-789-0123', '2023-08-29', '2023-08-29');


---------##########use company_db;###########----

--- #Query to pull all rows and columns from a particular table;
select * from employee;


--.Pull all rows and columns from department table;
select * from department;

----Select department name and department manager id from department table;
select dname, mgr_ssn from department;


--Select first name, employee id and gender from employee table
Select fname, ssn, sex from employee;

---Select department number, project number and project name from project table (in the same order);
Select dnum, pnumber, pname from project;


--Select all the rows and columns from work on table
select * from works_on;

#Select department location from department locaion table
Select dlocation from dept_locations;

----********Rename the columns**********----

---rename fname columne to first_name and lname column to last_name
select fname as first_name, lname as last_name from employee;


---Rename dname to department_name and dnumber to department number in department table
select dname as department_name, dnumber as department_number
from department;

---Select super_ssn as manager_employee_id and bdate as employee birthday from employee table
select super_ssn as manager_employee_id, bdate as employee_birth_date from employee;


---Select essn as employee id, pno as project number and hours as hours_worked_on from works_on table
select essn as employee_id, pno as project_number, hours as hours_worked_on from works_on;

---Selecting distint values from a column

--List all the departments from employee table
select dno from employee;
select distinct dno from employee;


---List all the genders from employee table
select sex from employee;
select distinct sex from employee;


---Try using distinct with gender and dno column
select dno, sex from employee;
select distinct dno, sex from employee;

--Pull 3 sample rows from employee table
select * from employee limit 3;


--Pull two rows from dependent table
Select * from dependent limit 2;


--Select employee id and dependent name from dependent table and pull 3 sample rows
select essn,dependent_name from dependent limit 3;


--select dependent name, employee id, bdate (rename it as birth_date) from employee table and take 5 rows sample
select dependent_name,essn, bdate as birthdate from dependent;


--select 1 sample row from project table
select * from project limit 1;


--select pname (rename it as project_name), dnum (rename it as department number) from project table and sample 3 rows
select pname as project_name, dnum as department_number from project limit 3;


---######## Where Condition ##############
---Select all rows from employee table where dno is 5
select * from employee where dno=5;


---Select all rows from employee table where dno is 5 and gender is male
select * from employee where dno=5 and sex='M';

--select all rows from employee table where either department number is or gender is M
select * from employee where dno=5 OR sex='M';


--Select all employees whose salary is more than 30,000
select * from employee where salary>30000;


--List all the employee whose salary is less than 40,000 and are male
select * from employee where salary<40000 and sex='M';


---List all employee whose first name has letter "a"
Select * from employee where fname like '%a%';


---Give list of all employees whose name start wth letter "a"
Select * from employee where fname like 'a%';

---List all employee whose name doesn't have letter 'a" in it
select * from employee where fname not like '%a%';


---List all employees whose name either has letter "a" or (they are from department 5 and are male)
select * from employee where (fname like '%a%') OR (dno=5 and sex='M');


---List all employees who are not from department 5;
select * from employee where dno<>5;
select * from employee where dno!=5;
select * from employee where NOT dno=5;


---List all employee where gender is not female and salary is less than 45,000
select * from employee where sex<>'F' and salary<=45000;


---List all employees whose salary is more than 30,000 and less than 40,000;
select * from employee where salary>=30000 and salary<=40000;


select * from employee where salary between 30000 and 40000;


---Select all employees who are either from department 1 OR 4;
select * from employee where dno=1 OR dno=4;


---############# IN Operator ######################
---Select all employees who are either from department 1 OR 4;
select * from employee where dno in (1,4);


---Select all employees whose salary is more than 30000 and department is either 1 or 5;
select * from employee where salary>30000 and dno in (1,5);

---Select all employees from works on table where workes hours are more than 10 and p numbr between 3 and 10;
select * from works_on where pno between 3 and 10 and hours>=10;

---Select all department locations where department location name start from "s".
select * from dept_locations where dlocation like 'S%';

