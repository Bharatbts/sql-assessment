CREATE DATABASE try;

USE try;

CREATE TABLE employees
(
employee_id int auto_increment primary key,
name varchar(100),
position varchar(100),
salary decimal(10,2),
hire_date date
);

CREATE TABLE employee_audit
(
audit_id int auto_increment primary key,
employee_id int,
name varchar(100),
position varchar(100),
salary decimal(10,2),
hire_date date,
action_date timestamp default current_timestamp
);

INSERT INTO employees (name, position, salary, hire_date) VALUES
('John Doe', 'Software Engineer', 80000.00, '2022-01-15'),
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

DELIMITER //
CREATE TRIGGER after_employee_insert 
AFTER INSERT ON employees for each row
BEGIN
INSERT INTO employee_audit (employee_id,name,position,salary,hire_date) 
VALUES (NEW.employee_id,NEW.name,NEW.position,NEW.salary,NEW.hire_date);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_employee (
IN emp_name varchar(100),
IN emp_position varchar(100),
IN emp_salary decimal(10,2),
IN emp_hire_date date
)
BEGIN
INSERT INTO employees (name,position,salary,hire_date)
VALUES (emp_name,emp_position,emp_salary,emp_hire_date);
END //
DELIMITER ;

CALL add_employee ('Michael Brown','QA Engineer',60000.00,'2025-02-13');