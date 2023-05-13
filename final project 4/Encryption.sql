
 
/* TDE Column Level encryption in SQL Server
Similar to other Database vendors */
 
-- MASTER KEY
-- CERTIFICATE
-- ENCRYPTION KEYS (SYMMETRIC/ASYMEMETRIC)
use WasteManagement1
go
--Modify the employee table by adding two columns username and Password columns
-- alter table employee add Username varchar(50), [Password] varbinary(400)
/* variable binary allow use of characters set outside your current character set
data will be in hexadecimal format
real security comes from the encryption algorithm used*/
-- go
--Create a master key for the database.
create MASTER KEY
ENCRYPTION BY PASSWORD = 'Waste@123';
-- drop master key
-- very that master key exists
SELECT name KeyName,
symmetric_key_id KeyID,
key_length KeyLength,
algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;
go
--Create a self signed certificate and name it EmpPass
CREATE CERTIFICATE EmpPass
WITH SUBJECT = 'Employee Password';
GO
-- drop CERTIFICATE EmpPass
--Create a symmetric key with AES 256 algorithm using the certificate
-- as encryption/decryption method
CREATE SYMMETRIC KEY EmpPass_SM
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE EmpPass;
GO
--drop SYMMETRIC KEY EmpPass_SM
--Now we are ready to encrypt the password and also decrypt
-- Open the symmetric key with which to encrypt the data.
OPEN SYMMETRIC KEY EmpPass_SM
DECRYPTION BY CERTIFICATE EmpPass;
-- Encrypt the value in column Password with symmetric key, and default everyone with
-- a password of Pass1234
UPDATE dbo.Employee set [Username] = EmployeeLastName
, [Password] = EncryptByKey(Key_GUID('EmpPass_SM'), convert(varbinary,'Pass123') )
GO
-- First open the symmetric key with which to decrypt the data.
OPEN SYMMETRIC KEY EmpPass_SM
DECRYPTION BY CERTIFICATE EmpPass;
SELECT *,
CONVERT(varchar, DecryptByKey([Password]))
AS 'Decrypted password'
FROM dbo.Employee;
GO

SELECT * from Employee


insert into Employee (EmployeeFirstName, EmployeeLastName, Username, Password, CompanyID) values ('Amisha', 'Husset', 'ghusset0', 'Amisha123', 6);
