USE AdventureWorks2019
GO

CREATE VIEW V_Contact_Info AS
SELECT FirstName, MiddleName, LastName
FROM Person.Person
GO

CREATE VIEW V_Employee_Contact AS
SELECT p.FirstName,p.LastName,e.BusinessEntityID,e.HireDate FROM HumanResources.Employee e
JOIN Person.Person As p ON e.BusinessEntityID = p.BusinessEntityID
GO

SELECT * FROM V_Employee_Contact
GO

ALTER VIEW V_Employee_Contact AS
	SELECT p.FirstName,p.LastName,e.BusinessEntityID,e.HireDate,e.BirthDate
	FROM HumanResources.Employee e
	JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
	WHERE p.FirstName LIKE '%B%'
	GO

SELECT * FROM V_Employee_Contact
GO

--Xem dinh nghia khung hinh
EXEC sp_helptext 'V_Employee_Contact'
--Xem cac thanh phan ma khung hinh phu thuoc
EXEC sp_depends 'V_Employee_Contact'
GO

CREATE VIEW OrderRejects
WITH ENCRYPTION
AS
SELECT PurchaseOrderID,ReceivedQty,RejectedQty,RejectedQty/ReceivedQty AS RejectRatio,DueDate
FROM Purchasing.PurchaseOrderDetail  
WHERE RejectedQty/ReceivedQty > 0
AND DueDate > CONVERT(DATETIME,'20010630',101)
GO

--Khong xem duoc dinh nghia khung nhin V_Contact_Info
EXEC sp_helptext 'OrderRejects'
GO

EXEC sp_depends 'OrderRejects'
GO

ALTER VIEW V_Employee_Contact AS
SELECT p.FirstName,p.LastName,e.BusinessEntityID,e.HireDate
FROM HumanResources.Employee e JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE p.FirstName LIKE 'A%'
WITH CHECK OPTION
GO

SELECT * FROM V_Employee_Contact
--Cap nhat duoc khung nhin khi LastName bat dau bang ky tu A
UPDATE V_Employee_Contact SET FirstName='Atest' WHERE LastName='Alberts'
--Khong cap nhat duoc khung nhin khi FirstName bat dau bang ki tu khac A
UPDATE V_Employee_Contact SET FirstName='BCD' WHERE LastName='Atest'
GO

CREATE VIEW V_Contact_Info
WITH SCHEMABINDING AS
SELECT FirstName,MiddleName,LastName
FROM Person.Person
GO

SELECT * FROM V_Contact_Info
GO

DROP VIEW V_Contact_Info
GO

DROP VIEW V_Employee_Contact
GO

DROP VIEW OrderRejects
GO
