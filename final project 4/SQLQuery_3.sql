
CREATE TRIGGER EmpSalaryUpdate
ON Employee
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(salary)
    BEGIN
        INSERT INTO EmployeeAudit (Employeeld, SalaryBefore, SalaryAfter, ActionDate)
        SELECT i.Employeeld, d.salary, i.salary, GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.Employeeld = d.Employeeld
    END
END

 

CREATE VIEW NumberOfActPaitentsInZipCode
AS
Select ZipCode, COUNT(DISTINCT p) AS NumberofActivePaitents
FROM Paitents p, Visit v
WHERE v.VisitDate is 2022-01-01
GROUPBY p.ZipCode DESC

CREATE VIEW NumberOfActPatientsInZipCode
AS
SELECT p.ZipCode, COUNT(DISTINCT p.PatientID) AS NumberOfActivePatients
FROM Patient p
INNER JOIN Visit v ON p.PatientID = v.PatientID
WHERE v.VisitDate >= '2022-01-01'
GROUP BY p.ZipCode;

SELECT d.dept_name AS DepartmentName, AVG(e.salary) AS AVGSalary, Description varchar(225)
FROM Employee e
INNER JOIN Department d on d.dept_id= e.dept_id
WHERE AVGSalary < '6000' 
AND AVGSalary > '8000'

SELECT d.dept_name AS 'Department Name', AVG(e.salary) AS 'Average Salary'
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
WHERE d.dept_name LIKE '%data%' 
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) < 6000 OR AVG(e.salary) > 7000 


Create Database Exam
Use Exam

DROP Table Department
CREATE Table Department (dept_id int not null , dept_name varchar(225), CONSTRAINT dept_PK PRIMARY KEY (dept_id)) 

CREATE TABLE Employee (Id Int not null, 
first_name varchar(225), 
last_name varchar(225), 
salary int, 
dept_id int,
CONSTRAINT Dept_FK FOREIGN KEY (dept_ID) REFERENCES Department)


SELECT d.dept_name AS 'Department Name', AVG(e.salary) AS 'Average Salary'
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
WHERE d.dept_name LIKE '%data%' 
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) < 6000 OR AVG(e.salary) > 7000 

Drop table Student

CREATE TABLE Student (id int not null, 
name varchar(225), 
GPA decimal(2,2), 
SectionID int,
CONSTRAINT Student_PK PRIMARY KEY (id))

CREATE TABLE Section (id int not null, name varchar(255))

SELECT Section.name AS Section, Student.name AS Student, Student.GPA AS Grade
From Student, Section
GROUP BY SectionID

insert into Student values(1,'Penny',4,1)
insert into Student values(2,'Leonard',5,2)
insert into Student values(3,'Sheldon',4,2)
insert into Student values(4,'Raj',3.8,1)
insert into Student values(5,'Stuart',4,1)
insert into Student values(6,'Howard',3.8,1)
insert into Student values(7,'Amy',3.0,1)

SELECT *from Student
Truncate table Student

-- insert into Students values(3,'Sheldon',3.6,2)
select *from Section
insert into Section values(1,'Section-1')
insert into Section values(2,'Section-2')


CREATE table Student(
    id int primary key not null,
    [name] varchar(50),
    GPA int,
    id int
    constraint for_fk FOREIGN key(SectionID) REFERENCES Section(SectionID)
)
drop table Student
drop table Section

create table Section(
    id int PRIMARY key not null,
    [name] varchar(50)
)
CREATE PROCEDURE TACandidates (@Section_name VARCHAR(225))
AS
BEGIN
  SELECT s.SectionID, s.Name AS 'Student', s.GPA AS 'Grade'
  FROM (
    SELECT ROW_NUMBER() OVER(PARTITION BY SectionID ORDER BY GPA DESC) AS RowNum, *
    FROM Students
  ) s
  JOIN Section sec ON s.SectionID = sec.id
  WHERE sec.name = @section_name AND s.RowNum <= 2
  ORDER BY s.SectionID ASC, s.GPA DESC
END

CREATE PROCEDURE TACandidates
    (@section_name varchar(50))
AS
BEGIN
    SET NOCOUNT ON;

    SELECT s.Name as Section, st.Name as Student, st.GPA as Grade
    FROM Students st
    INNER JOIN Section s ON st.SectionID = s.ID
    WHERE s.Name = @section_name
    AND st.ID IN (
        SELECT TOP 2 s2.ID
        FROM Students s2
        WHERE s2.SectionID = s.ID
        ORDER BY s2.GPA DESC
    )
    ORDER BY s.Name, st.GPA DESC;
END

ALTER PROCEDURE TACandidates(@section_name VARCHAR(50))
AS
BEGIN
  SELECT s.id AS 'Section', st.Name AS 'Student', st.GPA AS 'Grade'
  FROM Section s
  INNER JOIN Student st ON st.SectionID = s.id
  LEFT OUTER JOIN Student stu ON st.SectionID = stu.SectionID AND st.GPA < stu.GPA
  WHERE s.name = @section_name
    AND stu.id IS NULL
    AND (
      SELECT COUNT(*)
      FROM Student stud
      WHERE stud.SectionID = st.SectionID
        AND stud.GPA > st.GPA
    ) <3
  ORDER BY s.id, st.GPA DESC
END

EXEC TACandidates 'Section-1'

CREATE FUNCTION GetPercentage(@studentId int)
returns decimal(2,2)
AS 
BEGIN
declare @percentage decimal(2,2)

SELECT @percentage= [percentage] from Student where student_id=@studentId


RETURN @percentage
END
GO
CREATE DATABASE EXAM2
USE Exam2
CREATE Table Student (StudentID int, TotalMarks decimal(4,3), NumberOfSubjects int, Percentage decimal(2,2)
)

insert into Student values(4587,3.346,5,0.67)
select * from Student


select dbo.GetPercentage(4587) as 'percentage' from Student


CREATE FUNCTION GetPercentage(@StudentID int)
RETURNS decimal(2,2)
AS
BEGIN
    DECLARE @Percentage decimal(2,2)
    SELECT @Percentage = Percentage FROM Student WHERE StudentID = @StudentID
    RETURN @Percentage
END