-- Create a database named 'school'
CREATE DATABASE school;

-- Use the database,
USE school;

-- Create a table named "students'
CREATE TABLE students (
student_id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
grade VARCHAR (10)
);

-- Insert a single record into the "students" table
INSERT INTO students (student_id, name, age, grade)
VALUES (1, 'Sandhya', 27, 'A');

-- Insert into multiple records
INSERT INTO students (student_id, name, age, grade) VALUES
(2, 'Smriti', 30, 'B'),
(3, 'Ashmita', 28, 'C'),
(4, 'Rijju', 29, 'D');

-- Fetch all the records from the table 
SELECT * FROM students;

-- Fetch only the "name" and "grade" columns
SELECT name, grade FROM students;

-- Fetch students with grade 'A'
SELECT * FROM students WHERE grade = 'A';

-- Fetch all records sorted by name in ascending order
SELECT * FROM students ORDER BY name ASC;

-- Fetch all records sorted by name in descending order
SELECT * FROM students ORDER BY name DESC;

-- Update Sandhya's grade to 'A+'
UPDATE students
SET grade = 'A+'
WHERE student_id = 1;

-- DELETE the record where student_id is 3
DELETE FROM students
WHERE student_id = 3;

-- Count the total number of students
SELECT COUNT(*) AS total_students FROM students;

-- Find the average age of students
SELECT AVG(age) AS average_age FROM students;

-- Count the number of students in each grade
SELECT grade, COUNT(*) AS student_count
FROM students
Group by grade;

-- Add a column named "teacher" to the "students table
ALTER TABLE students
ADD teachers VARCHAR(50);

-- Update teacher names for each student
UPDATE students 
SET teachers = 'Dr. Gundersen'
WHERE student_id = 1;

UPDATE students
SET teachers = 'Dr. Noel'
WHERE student_id = 2;

UPDATE students
SET teachers = 'Ryan'
WHERE student_id = 4; 

-- Insert a new student with the teacher column
INSERT INTO students (student_id, name, age, grade, teachers)
VALUES (3, 'Daisy', 22, 'A', 'Lee');

INSERT INTO students (student_id, name, age, grade, teachers)
VALUES (5, 'Daisy', 22, 'A', 'Lee');

-- Fetch all the students along with their assigned teacher
SELECT * FROM students;

-- Fetch students taught by a specific teacher
SELECT name, grade
FROM students
WHERE teachers = 'Dr. Gundersen';

SELECT 
name AS Student_Name,
grade AS Grade,
teachers AS teacher_name
FROM students
ORDER BY teachers ASC;

-- Add the "teacher_id" column to the "students" table
ALTER TABLE students
ADD teacher_id INT;

-- Uodate the "teacher_id" with placeholder values for existing records
UPDATE students
SET teacher_id = 1
WHERE student_id = 1;

UPDATE students
SET teacher_id = 2
WHERE student_id = 2;

UPDATE students
SET teacher_id = 4
WHERE student_id = 4;

UPDATE students
SET teacher_id = 5
WHERE student_id = 5;

CREATE TABLE teachers (
teacher_id INT PRIMARY KEY, -- Unique ID for each teacher
name VARCHAR(50),          -- Teacher's name
subject_id INT             -- Links to the "subjects" table
);

INSERT INTO teachers (teacher_id, name, subject_id)
VALUES 
(1, 'Dr. Gundersen', 101),
(2, 'Dr. Noel', 102),
(4, 'Ryan', 104),
(5, 'Lee', 105);

DELETE FROM teachers WHERE teacher_id IN (1, 2, 3);

INSERT INTO teachers (teacher_id, name, subject_id)
VALUES 
(1, 'Dr. Gundersen', 101),
(2, 'Dr. Noel', 102),
(4, 'Ryan', 104),
(5, 'Lee', 105);

DELETE FROM teachers WHERE teacher_id IN (4,5);

INSERT INTO teachers (teacher_id, name, subject_id)
VALUES 
(1, 'Dr. Gundersen', 101),
(2, 'Dr. Noel', 102),
(4, 'Ryan', 104),
(5, 'Lee', 105);

CREATE TABLE subjects (
subject_id INT PRIMARY KEY, -- Unique ID for each subject
subject_name VARCHAR(50),  -- Name of the subject
credit_hours INT           -- Credit hours for the subject
);

INSERT INTO subjects (subject_id, subject_name, credit_hours)
VALUES 
(101, 'Mathematics', 6),
(102, 'History', 9),
(104, 'Science', 3),
(105, 'Economics', 3);

-- Fetch students with their teachers and subjects
SELECT 
s.name AS Student_Name,
t.name AS Teacher_Name,
sub.subject_name AS Subject,
sub.credit_hours AS Credit_Hours
FROM students s
JOIN teachers t ON s.teacher_id = t.teacher_id
JOIN subjects sub ON t.subject_id = sub.subject_id
ORDER BY s.name;

-- Counts students taught by each teacher
SELECT 
    t.name AS Teacher_Name,
    COUNT(s.student_id) AS Total_Students
FROM teachers t
LEFT JOIN students s ON t.teacher_id = s.teacher_id
GROUP BY t.name
ORDER BY Total_Students DESC;

-- Find subjects more than 4 credit hours 
SELECT 
    sub.subject_name AS Subject,
    COUNT(t.teacher_id) AS Total_Teachers
FROM subjects sub
JOIN teachers t ON sub.subject_id = t.subject_id
WHERE sub.credit_hours > 4
GROUP BY sub.subject_name;

-- Advanced filtering with Nested Queries
SELECT 
    s.name AS Student_Name,
    t.name AS Teacher_Name,
    sub.subject_name AS Subject
FROM students s
JOIN teachers t ON s.teacher_id = t.teacher_id
JOIN subjects sub ON t.subject_id = sub.subject_id
WHERE sub.credit_hours > 3;

