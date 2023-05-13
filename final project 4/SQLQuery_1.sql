select dept_no AS 'FANCYDEPTNO', dept_name from department
select project_no + budget AS 'Profit' from project
select emp_fname + ' ' + emp_lname AS 'FullName' from employee

select * from Customer
select DISTINCT CustomerState from Customer
select AVG(TotalWasteDisposed) AS AverageofWasteDisposed from DisposalCenter
select count(*) from Customer
select * from Customer
select count(CustomerID) from Customer

select count(CustomerID) from Customer where Customerstate='TX'
select * from Bin
select AVG(Capacity) from BIN where capacity<100
select Count(*) from BIN where capacity<100

select BinID,LastEmptiedDate from BIN where capacity<150 and customerID<16
select * from BIN where LastEmptiedDate BETWEEN '2019-11-15' and '2022-12-30'
select * from WorkOrder where WorkOrderStatus='Completed' OR WorkOrderStatus='Active'
Select * from WorkOrder where WorkOrderStatus IN ('Completed', 'Active')
select * from Customer where CustomerFirstName LIKE 'J%'
select * from Customer where CustomerFirstName LIKE '_O%'
select * from Customer where CustomerFirstName LIKE '%N'
select * from WorkOrder where PaymentDate IS NULL
select * from WorkOrder ORDER BY Amount DESC 
select * from WorkOrder ORDER BY WorkOrderStatus DESC 
select * from WorkOrder ORDER BY WorkOrderStartDate DESC 
select * from Customer Order by CustomerState DESC, CustomerCity ASC
Create Table Texas AS (SELECT * from Customer where CustomerState='TX');
Create Table Student(StudentID int not null, Fullname varchar(255) not null, GPA decimal)
Update Customer set CustomerCity='TX' where CustomerID=1

Create Database Hireracy;
Use Hireracy
Create Table Parent(ParentID int not null, ParentName varchar(225), NoOfChildern int,
Constraint Parent_PK Primary Key (ParentID))

Insert into Parent values(1,'Sakshi',3);
select * from Parent


Create Table Childern(ChildernID int not null, ChildName varchar(225), ParentID int, ParentName varchar(225)
CONSTRAINT Childern_PK Primary Key (ChildernID),
CONSTRAINT Parent_FK FOREIGN Key (ParentID) REFERENCES Parent(ParentID))

Insert into Childern values (3, 'Amisha', 1, 'Sakshi')
select * from Childern
Insert into Childern values (4, 'Savidhan', 1, 'Sakshi')
Insert into Childern values (7, 'Ashlesha', 1, 'SakshiK')
Insert into Childern values (8, 'Ashlesha', 2, 'SakshiK')

Alter table Childern add CONSTRAINT Parent_FK FOREIGN Key (ParentID) REFERENCES Parent(ParentID) On DELETE CASCADE;

select * from Waste
select * from RecyclingCenter
select * from SegCenter
Use WM
select * from SegCenter S INNER JOIN RecyclingCenter R
ON S.CenterID = R.CenterID

select * from RecyclingCenter R INNER JOIN SegCenter S
ON R.CenterID = S.CenterID

select * from RecyclingCenter R RIGHT JOIN SegCenter S
ON R.CenterID = S.CenterID

Create View Complaints_By_Customers AS
Select CustomerFirstName, CustomerLastName
from Customer
Select * from Complaints_By_Customers

SHOW INDEX from Customers;

USE HW9
select * from employee
Select * from Project
Select * from works_on
Select * from department
select * from departmentAudit

select upper(emp_fname), lower(emp_lname)
from employee


select e.emp_fname, e.emp_lname, d.location
from employee e INNER JOIN department d 
ON e.dept_no = d.dept_no 

select e.emp_fname, e.emp_lname, w.job
from employee e Left JOIN works_on w 
ON e.emp_no = w.emp_no; 

select e.emp_fname, e.emp_lname, p.project_name, p.budget
from employee e, works_on w INNER JOIN project p
ON e.emp_no = p.project_no 
WHERE p.budget>140000

select e.emp_fname, e.emp_lname, p.budget,
       (Select AVG(budget)from project) AS 'Avg Budget' 
from employee e, project p


select e.emp_fname, e.emp_lname, p.budget  
from employee e, project p where budget > (Select AVG(budget)from project)

select e.emp_fname, e.emp_lname, p.budget  
from employee e, project p where emp_no NOT IN (SELECT emp_no from employee where emp_no IS NOT NULL)


select e.emp_fname, e.emp_lname, p.budget  
from employee e, project p where project_no NOT IN (SELECT project_no from project where project_no IS NOT NULL)

select e.emp_fname, e.emp_lname, p.budget  
from employee e, project p where EXISTS (SELECT o.Job from works_on o where e.emp_no = o.emp_no)


select emp_fname, emp_lname from 
(select DISTINCT project_no from works_on)
employee ;



Select e.emp_fname, e.emp_lname from employee e where e.emp_no IN
(select DISTINCT project_no from works_on)

SELECT e.emp_fname, e.emp_lname
FROM employee e 
where e.emp_no IN
( select w.emp_no
FROM works_on w 
)

SELECT e.emp_fname, e.emp_lname
FROM employee e 
where e.emp_no IN
( select w.emp_no
FROM works_on w 
group by emp_no
having count(*)>1
)