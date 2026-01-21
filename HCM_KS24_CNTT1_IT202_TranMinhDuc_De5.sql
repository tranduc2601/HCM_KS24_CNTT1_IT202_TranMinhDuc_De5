-- PHẦN 1: Tạo bảng và chèn dữ liệu mẫu
Drop DATABASE IF EXISTS CompanyManagement;

CREATE DATABASE CompanyManagement;
USE CompanyManagement;

-- Tạo bảng Department
CREATE TABLE Department(
	dept_id varchar(5) PRIMARY KEY,
    dept_name varchar(100) UNIQUE NOT NULL,
    location varchar(100) NOT NULL,
    manager_name varchar(50) NOT NULL
);

-- Tao bảng Employee
CREATE TABLE Employee(
	emp_id INT primary key AUTO_INCREMENT,
	emp_name varchar(50) NOT NULL,
	dob date,
    email varchar(100) unique,
    phone varchar(15) unique,
    dept_id varchar(5),
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);
 -- Tạo bảng Project
CREATE TABLE Project(
    project_id varchar(5) primary key,
    project_name varchar(20) UNIQUE NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    budget DECIMAL(10,2) NOT NULL
);

-- Tạo bảng Assignment
CREATE TABLE Assignment(
    assignment_id INT primary key AUTO_INCREMENT,
    emp_id INT,
    project_id varchar(5),
    role varchar(50) NOT NULL,
    hours_worked INT NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
);

-- Chèn dữ liệu mẫu vào bảng Department
INSERT INTO Department(dept_id, dept_name, location, manager_name) VALUES
('D01', 'IT', 'Floor 5', 'Nguyen Van An'),
('D02', 'HR', 'Floor 2', 'Tran Thi Binh'),
('D03', 'Sales', 'Floor 1', 'Le Van Cuong'),
('D04', 'Marketing', 'Floor 3', 'Pham Thi Duong'),
('D05', 'Finance', 'Floor 4', 'Hoang Van Tu');

-- Chèn dữ liệu mẫu vào bảng Employee

INSERT INTO Employee(emp_name, dob, email, phone, dept_id) VALUES
 ('Nguyen Van Tuan', '1990-01-01', 'tuan@mail.com', '0901234567', 'D01'),
 ('Tran Thi Lan', '1995-05-05', 'lan@mail.com', '0902345678', 'D02'),
 ('Le Minh Khoi', '1992-10-10', 'khoi@mail.com', '0903456789', 'D01'),
 ('Pham Hoang Nam', '1998-12-12', 'nam@mail.com', '0904567890', 'D03'),
 ('Vu Minh Ha', '1996-07-07', 'ha@mail.com', '0905678901', 'D01');

-- Chèn dữ liệu mẫu vào bảng Project
INSERT INTO Project(project_id, project_name, start_date, end_date, budget) VALUES
('P001', 'Website Redesign', '2025-01-01', '2025-06-01', 50000.00),
('P002', 'Mobile App Dev', '2025-02-01', '2025-08-01', 80000.00),
('P003', 'HR System', '2025-03-01', '2025-09-01', 30000.00),
('P004', 'Marketing Campaign', '2025-04-01', '2025-05-01', 10000.00),
('P005', 'AI Research ', '2025-05-01', '2025-12-31', 100000.00);

-- Chèn dữ liệu mẫu vào bảng Assignment
INSERT INTO Assignment(emp_id, project_id, role, hours_worked) VALUES
(1, 'P001', 'Developer', 150),
(3, 'P001', 'Tester', 100),
(1, 'P002', 'Tech Lead', 200),
(5, 'P005', 'Data Scientist', 180),
(4, 'P004', 'Content Creator', 50);

-- PHẦN 2: Truy vấn dữ liệu cơ bản
-- 3. 
Update Department
SET location = 'Floor 10'
WHERE dept_id = 'C001';
-- 4. 
Update Project
SET budget = budget * 1.1, end_date = DATE_SUB(end_date, INTERVAL 1 MONTH)
WHERE project_id = 'P005';
-- 5. 
DELETE FROM Assignment
WHERE hours_worked = 0 OR role = 'Intern';
-- 6.
SELECT emp_id, emp_name, email
FROM Employee
WHERE dept_id = 'D01';
-- 7. 
SELECT project_name, start_date, budget
FROM Project
WHERE project_name LIKE '%System%';
-- 8.  
SELECT project_id, project_name, budget
FROM Project
ORDER BY budget DESC;
-- 9. 
SELECT emp_id, emp_name, dob
FROM Employee
ORDER BY dob ASC
LIMIT 3;
-- 10.
SELECT project_id, project_name
FROM Project
LIMIT 3 OFFSET 1;


-- PHẦN 3: Truy vấn dữ liệu nâng cao
-- 11. 
SELECT Assignment.assignment_id, Employee.emp_name, Project.project_name, Assignment.role
FROM Assignment
JOIN Employee ON Assignment.emp_id = Employee.emp_id
JOIN Project ON Assignment.project_id = Project.project_id
WHERE Assignment.hours_worked > 100;
-- 12. 
SELECT Department.dept_id, Department.dept_name, Employee.emp_name
FROM Department
LEFT JOIN Employee ON Department.dept_id = Employee.dept_id;
-- 13.
SELECT Project.project_name, SUM(Assignment.hours_worked) AS Total_Hours
FROM Project
JOIN Assignment ON Project.project_id = Assignment.project_id
GROUP BY Project.project_name;
-- 14. 
SELECT Department.dept_name, COUNT(Employee.emp_id) AS Employee_Count
FROM Department
LEFT JOIN Employee ON Department.dept_id = Employee.dept_id
GROUP BY Department.dept_name
HAVING COUNT(Employee.emp_id) >= 2;
-- 15. 
SELECT Employee.emp_name, Employee.email
FROM Employee
JOIN Assignment ON Employee.emp_id = Assignment.emp_id
JOIN Project ON Assignment.project_id = Project.project_id
WHERE Project.budget > 50000;
-- 17. 
SELECT Employee.emp_id, Employee.emp_name, Department.dept_name, Project.project_name, Assignment.hours_worked
FROM Employee
JOIN Department ON Employee.dept_id = Department.dept_id
JOIN Assignment ON Employee.emp_id = Assignment.emp_id
JOIN Project ON Assignment.project_id = Project.project_id;





-- 16. em sua lai insert cua assignment vi no khong hien thi dung ten nhan vien, de nguyen mau insert thi code em no bi rong ten nhan vien
SELECT Employee.emp_name, Assignment.role
FROM Employee
JOIN Department ON Employee.dept_id = Department.dept_id
JOIN Assignment ON Employee.emp_id = Assignment.emp_id
JOIN Project ON Assignment.project_id = Project.project_id
WHERE Department.dept_name = 'IT' AND Project.project_name = 'Website Redesign';

