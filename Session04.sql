DROP DATABASE IF EXISTS OnlineLearning;
CREATE DATABASE OnlineLearning;
USE OnlineLearning;

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);


CREATE TABLE Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    description TEXT,
    total_sessions INT NOT NULL CHECK (total_sessions > 0),
    instructor_id INT NOT NULL,
    
    FOREIGN KEY (instructor_id)
    REFERENCES Instructor(instructor_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date DATE NOT NULL,
    
    UNIQUE (student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES Student(student_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY (course_id)
    REFERENCES Course(course_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Result (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    mid_score FLOAT CHECK (mid_score BETWEEN 0 AND 10),
    final_score FLOAT CHECK (final_score BETWEEN 0 AND 10),
    
    UNIQUE (student_id, course_id),

    FOREIGN KEY (student_id, course_id)
    REFERENCES Enrollment(student_id, course_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- STUDENT
INSERT INTO Student (full_name, dob, email) VALUES
('Nguyen Van A', '2003-01-01', 'a@gmail.com'),
('Tran Thi B', '2003-02-02', 'b@gmail.com'),
('Le Van C', '2003-03-03', 'c@gmail.com'),
('Pham Thi D', '2003-04-04', 'd@gmail.com'),
('Hoang Van E', '2003-05-05', 'e@gmail.com');

-- INSTRUCTOR
INSERT INTO Instructor (full_name, email) VALUES
('Teacher A', 't1@gmail.com'),
('Teacher B', 't2@gmail.com'),
('Teacher C', 't3@gmail.com'),
('Teacher D', 't4@gmail.com'),
('Teacher E', 't5@gmail.com');

-- COURSE
INSERT INTO Course (course_name, description, total_sessions, instructor_id) VALUES
('SQL Basic', 'Learn SQL', 20, 1),
('Python', 'Learn Python', 25, 2),
('Java', 'Learn Java', 30, 3),
('Web Dev', 'Frontend + Backend', 40, 4),
('AI Intro', 'Machine Learning Basics', 35, 5);

-- ENROLLMENT
INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
(1,1,'2025-01-01'),
(1,2,'2025-01-02'),
(2,1,'2025-01-03'),
(3,3,'2025-01-04'),
(4,4,'2025-01-05'),
(5,5,'2025-01-06');

-- RESULT
INSERT INTO Result (student_id, course_id, mid_score, final_score) VALUES
(1,1,7.5,8.0),
(1,2,6.5,7.0),
(2,1,8.0,9.0),
(3,3,5.5,6.0),
(4,4,9.0,9.5),
(5,5,7.0,8.5);



UPDATE Student
SET email = 'new_a@gmail.com'
WHERE student_id = 1;

UPDATE Course
SET description = 'Updated SQL Course'
WHERE course_id = 1;

UPDATE Result
SET final_score = 9.5
WHERE student_id = 1 AND course_id = 1;



-- Xóa enrollment -> auto xóa result (cascade)
DELETE FROM Enrollment
WHERE student_id = 5 AND course_id = 5;



SELECT * FROM Student;
SELECT * FROM Instructor;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Result;



SELECT s.full_name, c.course_name, e.enroll_date
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Course c ON e.course_id = c.course_id;

SELECT s.full_name, c.course_name, r.mid_score, r.final_score
FROM Result r
JOIN Student s ON r.student_id = s.student_id
JOIN Course c ON r.course_id = c.course_id;