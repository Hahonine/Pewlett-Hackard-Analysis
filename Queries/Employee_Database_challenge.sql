DROP TABLE titles;

CREATE TABLE employees(
	emp_no INTEGER NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no)
);

SELECT * FROM titles;

CREATE TABLE departments(
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY(dept_no)
);

CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees,
	FOREIGN KEY(dept_no) REFERENCES departments,
	PRIMARY KEY(emp_no, dept_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	emp_no INTEGER NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,	
	FOREIGN KEY(emp_no) REFERENCES employees,
	FOREIGN KEY(dept_no) REFERENCES departments,
	PRIMARY KEY(emp_no, dept_no)
);

CREATE TABLE salaries(
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees,
	PRIMARY KEY(emp_no)
);

CREATE TABLE titles(
	emp_no INTEGER NOT NULL,
	title VARCHAR(50) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees
);

DROP TABLE employee_titles;

SELECT  DISTINCT t.emp_no,
		t.title,
		t.to_date,
		t.from_date,
		e.first_name,
		e.last_name
INTO employee_titles
FROM employees as e
INNER JOIN titles as t
ON(t.emp_no = e.emp_no);

DROP TABLE retiree_titles;

SELECT  et.emp_no,
		et.first_name,
		et.last_name,
		et.title,
		et.from_date,
		et.to_date
	INTO retiree_titles
	FROM employee_titles AS et
	INNER JOIN employees AS e
	ON(e.emp_no = et.emp_no)
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	ORDER BY emp_no;

SELECT * FROM retiree_titles;
DROP TABLE retirement_titles_clean;
--BEGIN IMPORTED CHALLENGE CODE
SELECT DISTINCT ON (emp_no) *
INTO retirement_titles_clean
FROM retiree_titles
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM retirement_titles_clean;
