create database Employee_Payroll_Management_System;
use Employee_Payroll_Management_System;
CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(50),
  location VARCHAR(50)
);
INSERT INTO departments VALUES
(1,'HR','Chennai'),
(2,'Finance','Mumbai'),
(3,'Engineering','Bangalore'),
(4,'Sales','Delhi'),
(5,'Support','Hyderabad');
select * from departments;

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100),
  phone VARCHAR(15),
  hire_date DATE,
  department_id INT,
  salary INT,
  manager_id INT,
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO employees VALUES
(101,'Aarav','Sharma','aarav@company.com','9876500001','2020-01-15',1,55000,101),
(102,'Meena','D','meena@company.com','9876500002','2021-02-21',2,60000,101),
(103,'Rohit','Kumar','rohit@company.com','9876500003','2019-03-10',3,72000,103),
(104,'Priya','Singh','priya@company.com','9876500004','2022-04-05',2,50000,102),
(105,'Karan','Patel','karan@company.com','9876500005','2020-05-18',4,68000,105),
(106,'Divya','Nair','divya@company.com','9876500006','2023-06-11',1,45000,101),
(107,'Arjun','Reddy','arjun@company.com','9876500007','2018-07-23',3,80000,103),
(108,'Sneha','Iyer','sneha@company.com','9876500008','2021-08-30',5,52000,108),
(109,'Vikram','Das','vikram@company.com','9876500009','2019-09-14',4,75000,105),
(110,'Neha','Gupta','neha@company.com','9876500010','2022-10-19',2,47000,102);
select * from employees;

CREATE TABLE payroll (
  payroll_id INT PRIMARY KEY,
  emp_id INT,
  basic_salary INT,
  bonus INT,
  deductions INT,
  net_salary INT,
  pay_date DATE,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
INSERT INTO payroll VALUES
(1,101,55000,5500,2750,57750,'2025-01-31'),
(2,102,60000,6000,3000,63000,'2025-01-31'),
(3,103,72000,7200,3600,75600,'2025-01-31'),
(4,104,50000,5000,2500,52500,'2025-01-31'),
(5,105,68000,6800,3400,71400,'2025-01-31'),
(6,106,45000,4500,2250,47250,'2025-01-31'),
(7,107,80000,8000,4000,84000,'2025-01-31'),
(8,108,52000,5200,2600,54600,'2025-01-31'),
(9,109,75000,7500,3750,78750,'2025-01-31'),
(10,110,47000,4700,2350,49350,'2025-01-31');
select * from payroll;

CREATE TABLE attendance (
  attendance_id INT PRIMARY KEY,
  emp_id INT,
  att_date DATE,
  status VARCHAR(20),
  work_hours INT,
  FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
INSERT INTO attendance VALUES
(1,101,'2025-01-01','Present',8),
(2,102,'2025-01-01','Present',8),
(3,103,'2025-01-01','Absent',0),
(4,104,'2025-01-01','WFH',8),
(5,105,'2025-01-01','Present',8),
(6,101,'2025-01-02','Present',8),
(7,102,'2025-01-02','Absent',0),
(8,103,'2025-01-02','Present',8),
(9,104,'2025-01-02','Present',8),
(10,105,'2025-01-02','WFH',8);
select * from attendance;

select concat(first_name,' ',last_name) as full_name,salary from employees;
select e.emp_id,concat(e.first_name,' ',e.last_name) as full_name,p.net_salary from employees e join payroll p on e.emp_id = p.emp_id where net_salary>50000;
select * from employees where year(hire_date)>=2022;
select distinct(department_id) from departments;
select count(emp_id) as total_employees from employees;
select salary from employees order by salary desc;
select first_name from employees where first_name like 'a%';
select concat(first_name,' ',last_name) as full_name from employees where department_id = 3;
select concat(first_name,' ',last_name) as full_name from employees where salary between 30000 and 60000;
select concat(e.first_name,' ',e.last_name) as full_name, d.department_name from employees e join departments d on e.department_id = d.department_id;
select d.department_name,count(e.emp_id) as total_employees from employees e join departments d on e.department_id = d.department_id group by d.department_name;
select d.department_name,avg(e.salary) from employees e join departments d on e.department_id = d.department_id group by d.department_id;
select d.department_name,max(e.salary) from employees e join departments d on e.department_id = d.department_id group by d.department_id;
select d.department_name from employees e join departments d on e.department_id = d.department_id group by d.department_id,department_name having count(*)>2 ;
select sum(net_salary) from payroll group by pay_date;
select d.department_name,sum(p.net_salary) as total_payroll from payroll p join employees e on e.emp_id = p.emp_id join departments d on d.department_id = e.department_id group by d.department_id, d.department_name order by total_payroll desc; 
select e.emp_id,e.salary , p.net_salary from employees e join payroll p on e.emp_id =  p.emp_id ;
select concat(e.first_name,' ',e.last_name)as full_name,a.att_date,a.status from employees e join attendance a on e.emp_id = a.emp_id order by e.emp_id, a.att_date;
select concat(e.first_name,' ',e.last_name)as full_name, a.status from employees e join attendance a on e.emp_id = a.emp_id where status in ('absent');
select * from employees where salary > (select avg(salary) from employees);
select max(salary) from employees where salary<(select max(salary) from employees);
select salary from employees e where salary >(select avg(salary) from employees where e.department_id = department_id );
select distinct (emp_id) from employees where emp_id not in (select emp_id from attendance);
select salary from employees e where salary =(select max(salary) from employees where e.department_id = department_id );
select emp_id,concat(first_name,' ',last_name)as full_name,department_id,salary,rank() over (partition by department_id order by salary desc) as salary_rank from employees;
select emp_id,concat(first_name,' ',last_name)as full_name,department_id,salary,hire_date,row_number() over(order by hire_date desc) from employees ;
select * from (select emp_id,concat(first_name,' ',last_name)as full_name,department_id,salary,dense_rank() over(partition by department_id order by salary desc) as rank_order from employees) t where rank_order>=2;
DELIMITER &&
create procedure increase_salary (
in p_department_id int, in p_percent decimal(5,2)
)
begin
update employees set salary = salary+(salary*p_percent/100) where department_id = p_department_id;
select * from employees where department_id = p_department_id;

end &&
DELIMITER ;
call increase_salary(3,10);

DELIMITER $$
create procedure calculate_bonus(
in p_emp_id int
)
begin
declare v_salary decimal(10,2);
declare v_days int;
declare v_bonus decimal(10,2);

select salary into v_salary from employees where emp_id = p_emp_id;
select count(*) into v_days from attendance where emp_id = p_emp_id;
if v_days >= 26 then set v_bonus =v_salary *0.10;
elseif v_days >=20 then set v_bonus = v_salary * 0.05;
else set v_bonus = 0;
end if;
select p_emp_id  as emp_id, v_salary as salary, v_days as present_days, v_bonus as bonus;
end $$
DELIMITER ;
call calculate_bonus(101);

create view vw_employee_department_salary as 
select e.emp_id,e.first_name,e.last_name,d.department_name,e.salary from employees e join departments d on e.department_id = d.department_id;
select * from vw_employee_department_salary where salary >=50000;
