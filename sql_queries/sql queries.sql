-- Active: 1744648059844@@127.0.0.1@3306@teaching
-- SELECT from a single table with a WHERE clause, producing a derived attribute
select course_code, rating as most_rate -- Select the most rated courses
	from course
    where rating > 3.5;
    
-- A NATURAL, INNER, or OUTER JOIN between two of your tables
 SELECT  -- select students and instructor that are in the course CSCI 1315
    Student.first_name AS student_first_name,
    Student.last_name AS student_last_name,
    Instructor.first_name AS instructor_first_name,
    Instructor.last_name AS instructor_last_name,
    student_course.course_code
FROM 
    student_has_course student_course
JOIN 
    instructor_has_course instructor_course 
    ON student_course.course_code = instructor_course.course_code
JOIN 
    Student 
    ON student_course.student_id = Student.student_id
JOIN 
    Instructor
    ON instructor_course.instructor_id = Instructor.instructor_id
WHERE student_course.course_code = 'CSCI_1315';

--  A query covering one or more tables that uses a GROUP BY statement on at least one of your variables.
SELECT career_aspiration -- list career aspiration for students with a cgpa greater that 2
FROM Student
WHERE cgpa > 2.00
GROUP BY career_aspiration;

-- A query that makes use of at least one subquery in the FROM clause.
SELECT MAX(rating) AS most_rated -- returns the highest rated course in the faculty of Arts 
FROM (
    SELECT course_code, rating
    FROM Course
    WHERE rating > 2.00 AND faculty = 'arts'
) AS high_rated;
