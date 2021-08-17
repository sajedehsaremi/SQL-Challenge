
--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no,
  employees.last_name,
  employees.first_name,
  employees.sex,
  salaries.salary
FROM employees
RIGHT JOIN salaries ON employees.emp_no=salaries.emp_no;


--2. List first name, last name,and hire date for employees who were hired in 1986.
SELECT employees.hire_date FROM employees
WHERE employees.hire_date>='01/01/1986' AND employees.hire_date<='12/31/1986';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.emp_no,
  dept_manager.dept_no,
  departments.dept_no,
  departments.dept_name,
   employees.first_name,
  employees.last_name
FROM dept_manager
LEFT JOIN departments ON dept_manager.dept_no=departments.dept_no
LEFT JOIN employees ON dept_manager.emp_no=employees.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no,
  employees.last_name,
  employees.first_name,
  dept_emp.emp_no,
  dept_emp.dept_no,
  departments.dept_no,
  departments.dept_name
FROM employees
LEFT JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
LEFT JOIN departments ON dept_emp.dept_no=departments.dept_no;



-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name,
  employees.last_name,
  employees.sex
FROM employees 
WHERE employees.first_name='Hercules' AND employees.last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no,
  employees.last_name,
  employees.first_name,
  dept_emp.dept_no,
  departments.dept_name
FROM employees
LEFT JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
LEFT JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE departments.dept_name='Sales';



-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no,
  employees.last_name,
  employees.first_name,
  dept_emp.dept_no,
  departments.dept_name
FROM employees 
LEFT JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
LEFT JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE departments.dept_name='Sales' OR  departments.dept_name='Development';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.\
SELECT last_name, COUNT(last_name) FROM employees GROUP BY last_name
ORDER BY COUNT(last_name)DESC;



-- Creat Tables
-- 1. create table for employees.csv
CREATE TABLE employees (
  emp_no Integer NOT NULL,
  emp_title_id Varchar(30) NOT NULL,
  birth_date Date NOT NULL,
  first_name Varchar(65) NOT NULL,
  last_name Varchar(65) NOT NULL,
  sex Varchar(1) NOT NULL,
  hire_date Date NOT NULL,
  PRIMARY KEY (emp_no)
);
COPY employees(emp_no,emp_title_id,birth_date,first_name,last_name,sex,hire_date)
FROM '/http://localhost:8894/tree/Desktop/personal-class/gt-atl-data-pt-06-2021-u-c/09-SQL/02-Homework/Instructions/data/employees.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM employees;

--2. create table for departments.csv
CREATE TABLE departments(
  dept_no Varchar(5),
  dept_name Varchar(65),
  PRIMARY KEY (dept_no)
);
COPY departments(dept_no,dept_name)
FROM '/Users/christinebrown/opt/anaconda3/pkgs/conda-4.8.3-py38_0/info/test/tests/data/tar_traversal/dirsym/tmp/09-SQL/sql-challenge/EmployeesSQL/departments.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM departments;

Sajedeh Saremi, [14.08.21 20:19]
--3. create table for dept_manager.csv
CREATE TABLE dept_manager(
  dept_no Varchar(5),
  emp_no Integer NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
COPY dept_manager(dept_no,emp_no)
FROM '/Users/christinebrown/opt/anaconda3/pkgs/conda-4.8.3-py38_0/info/test/tests/data/tar_traversal/dirsym/tmp/09-SQL/sql-challenge/EmployeesSQL/dept_manager.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM dept_manager;

--4. create table for salaries.csv
CREATE TABLE salaries(
  emp_no Integer,
  salary Integer,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
COPY salaries(emp_no,salary)
FROM '/Users/christinebrown/opt/anaconda3/pkgs/conda-4.8.3-py38_0/info/test/tests/data/tar_traversal/dirsym/tmp/09-SQL/sql-challenge/EmployeesSQL/salaries.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM salaries;

--5. create table for titles.csv
CREATE TABLE titles(
  title_id Varchar(30),
  title Varchar(30)
);
COPY titles(title_id,title)
FROM '/Users/christinebrown/opt/anaconda3/pkgs/conda-4.8.3-py38_0/info/test/tests/data/tar_traversal/dirsym/tmp/09-SQL/sql-challenge/EmployeesSQL/titles.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM titles;

--6. create table for dept_emp.csv
CREATE TABLE dept_emp(
  emp_no Integer,
  dept_no Varchar(5),
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);  
COPY dept_emp(emp_no,dept_no)
FROM '/Users/christinebrown/opt/anaconda3/pkgs/conda-4.8.3-py38_0/info/test/tests/data/tar_traversal/dirsym/tmp/09-SQL/sql-challenge/EmployeesSQL/dept_emp.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM dept_emp;
