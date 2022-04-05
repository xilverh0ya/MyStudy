-- mywork database 생성
-- CREATE database mywork;
CREATE database IF NOT EXISTS mywork;
-- DROP database IF EXISTS mywork;

USE mywork;
CREATE TABLE IF NOT EXISTS highschool_students (
	student_no varchar(20) NOT NULL PRIMARY KEY,
	student_name varchar(100) NOT NULL,
	grade tinyint,
	class varchar(20),
	gemder varchar(20),
	age smallint,
	enter_date date
);

DESC highschool_students;
-- DROP TABLE if exists highschool_students;

ALTER TABLE highschool_students
DROP PRIMARY KEY;

DESC highschool_students;

ALTER TABLE highschool_students
ADD PRIMARY KEY (student_no);
DESC highschool_students;

DROP DATABASE myworkbox_office
