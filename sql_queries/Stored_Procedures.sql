-- Active: 1744648059844@@127.0.0.1@3306@teaching
USE teaching;

-- prosedure to set student to incognito. Keep their id but set their other info to NUll
DELIMITER $$ -- set new delimiterto  '$$'
DROP PROCEDURE IF EXISTS incognito_student $$
CREATE PROCEDURE incognito_student(IN given_cgpa DECIMAL(3,2)) -- given cgpa as input
BEGIN
    IF EXISTS (SELECT 1 FROM Student WHERE cgpa = given_cgpa) THEN -- check if there are any with that cgpa 
        UPDATE Student
        SET -- if there are any, set all their informations to null except their id
            first_name = NULL,
            last_name = NULL,
            gender = NULL,
            admission_date = NULL,
            email = NULL,
            extra_curricular_activities = NULL,
            part_time_job = NULL,
            weekly_self_study_hours = NULL,
            career_aspiration = NULL
        WHERE cgpa = given_cgpa;
    ELSE 
        SELECT 'No student has that CGPA' AS Message; -- if not print a message
    END IF;
END $$ -- end of the stored procedur
DELIMITER ; -- set delimiter back to ';'

CALL incognito_student(2.00);



-- Procedure that update a student's names and email given their id
DELIMITER $$
DROP PROCEDURE IF EXISTS update_student_info $$
CREATE PROCEDURE update_student_info(
    IN firstName VARCHAR(100), -- new first_name
    IN lastName VARCHAR(100), -- new last_name
    IN emailAddr VARCHAR(100), -- new email
    IN studentId INT -- actual student_id
)
BEGIN
    IF EXISTS (SELECT 1 FROM Student WHERE student_id = studentId) THEN -- check if the given id exists
        UPDATE Student -- then update student's info
        SET 
            email = emailAddr, -- change first_name
            first_name = firstName, -- change last_name
            last_name = lastName -- change email
        WHERE student_id = studentId; -- for the given id only
    ELSE 
        SELECT 'There is no student with that ID' AS Message; -- print a message if id not found
    END IF;
END $$
DELIMITER ;


call update_student_info('Danick', 'Ditchou', 'dn303068@dal.ca', 102);