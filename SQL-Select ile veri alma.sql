USE [NORTHWND]
GO

INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           ( null,5,getdate(), null, null, 3, 10,
	  'Betul Gemisi',  (select Address from Employees where EmployeeID=5),
	  (select City from Employees where EmployeeID=5), -- '14cvbfcvb'
	  (select Region from Employees where EmployeeID=5), --''
	  (select PostalCode from Employees where EmployeeID=5),-- ''
	  (select Country from Employees where EmployeeID=5) --'London'
	 )
	 --Kendimiz veri girmek yerine select ile sistemdeki veriyi çekiyoruz
GO


