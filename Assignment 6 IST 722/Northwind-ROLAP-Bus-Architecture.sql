

-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA northwind
GO

/* Drop table northwind.FactSales */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.FactSales') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.FactSales 
;

/* Create table northwind.FactSales */
CREATE TABLE northwind.FactSales (
   [ProductKey]  int   NOT NULL
,  [OrderID]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [EmployeeKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [ShippedDateKey]  int   NOT NULL
,  [Quantity]  smallint   NOT NULL
,  [ExtendedPriceAmount]  decimal(25,4)   NOT NULL
,  [DiscountAmount]  decimal(25,4)  DEFAULT 0 NOT NULL
,  [SoldAmount]  decimal(25,4)   NOT NULL
,  [OrderToShippedLagInDays]  smallint   NULL
, CONSTRAINT [PK_northwind.FactSales] PRIMARY KEY NONCLUSTERED 
( [ProductKey], [OrderID] )
) ON [PRIMARY]
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[northwind].[Sales]'))
DROP VIEW [northwind].[Sales]
GO
CREATE VIEW [northwind].[Sales] AS 
SELECT [ProductKey] AS [ProductKey]
, [OrderID] AS [OrderID]
, [CustomerKey] AS [CustomerKey]
, [EmployeeKey] AS [EmployeeKey]
, [OrderDateKey] AS [OrderDateKey]
, [ShippedDateKey] AS [ShippedDateKey]
, [Quantity] AS [Quantity]
, [ExtendedPriceAmount] AS [ExtendedPriceAmount]
, [DiscountAmount] AS [DiscountAmount]
, [SoldAmount] AS [SoldAmount]
, [OrderToShippedLagInDays] AS [OrderToShippedLagInDays]
FROM northwind.FactSales
GO

/* Drop table northwind.FactInventoryDailySnapshot */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.FactInventoryDailySnapshot') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.FactInventoryDailySnapshot 
;

/* Create table northwind.FactInventoryDailySnapshot */
CREATE TABLE northwind.FactInventoryDailySnapshot (
   [ProductKey]  int   NOT NULL
,  [SupplierKey]  int   NOT NULL
,  [DateKey]  int   NOT NULL
,  [UnitsInStock  ]  int   NOT NULL
,  [UnitsOnOrder ]  int   NOT NULL
, CONSTRAINT [PK_northwind.FactInventoryDailySnapshot] PRIMARY KEY NONCLUSTERED 
( [ProductKey], [DateKey] )
) ON [PRIMARY]
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[northwind].[InventoryDailySnapshot]'))
DROP VIEW [northwind].[InventoryDailySnapshot]
GO
CREATE VIEW [northwind].[InventoryDailySnapshot] AS 
SELECT [ProductKey] AS [ProductKey]
, [SupplierKey] AS [SupplierKey]
, [DateKey] AS [DateKey]
, [UnitsInStock  ] AS [UnitsInStock  ]
, [UnitsOnOrder ] AS [UnitsOnOrder ]
FROM northwind.FactInventoryDailySnapshot
GO

/* Drop table northwind.DimEmployee */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimEmployee') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimEmployee 
;

/* Create table northwind.DimEmployee */
CREATE TABLE northwind.DimEmployee (
   [EmployeeKey]  int IDENTITY  NOT NULL
,  [EmployeeID]  int   NOT NULL
,  [EmployeeName]  nvarchar(40)   NOT NULL
,  [EmployeeTitle]  nvarchar(30)   NOT NULL
,  [HireDateKey]  int   NOT NULL
,  [SupervisorID]  int   NULL
,  [SupervisorName]  nvarchar(40)   NULL
,  [SupervisorTitle]  nvarchar(30)   NULL
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_northwind.DimEmployee] PRIMARY KEY CLUSTERED 
( [EmployeeKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT northwind.DimEmployee ON
;
INSERT INTO northwind.DimEmployee (EmployeeKey, EmployeeID, EmployeeName, EmployeeTitle, HireDateKey, SupervisorID, SupervisorName, SupervisorTitle, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown', 'Unknown', -1, -1, 'Unknown', 'Unknown', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT northwind.DimEmployee OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[northwind].[Employee]'))
DROP VIEW [northwind].[Employee]
GO
CREATE VIEW [northwind].[Employee] AS 
SELECT [EmployeeKey] AS [EmployeeKey]
, [EmployeeID] AS [EmployeeID]
, [EmployeeName] AS [EmployeeName]
, [EmployeeTitle] AS [EmployeeTitle]
, [HireDateKey] AS [HireDateKey]
, [SupervisorID] AS [SupervisorID]
, [SupervisorName] AS [SupervisorName]
, [SupervisorTitle] AS [SupervisorTitle]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM northwind.DimEmployee
GO

/* Drop table northwind.DimCustomer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimCustomer 
;

/* Create table northwind.DimCustomer */
CREATE TABLE northwind.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  nvarchar(5)   NOT NULL
,  [CompanyName]  nvarchar(40)   NOT NULL
,  [ContactName]  nvarchar(30)   NOT NULL
,  [ContactTitle]  nvarchar(30)   NOT NULL
,  [CustomerCountry]  nvarchar(15)   NOT NULL
,  [CustomerRegion]  nvarchar(15)  DEFAULT 'N/A' NOT NULL
,  [CustomerCity]  nvarchar(15)   NOT NULL
,  [CustomerPostalCode]  nvarchar(10)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_northwind.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT northwind.DimCustomer ON
;
INSERT INTO northwind.DimCustomer (CustomerKey, CustomerID, CompanyName, ContactName, ContactTitle, CustomerCountry, CustomerRegion, CustomerCity, CustomerPostalCode, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, 'UNK-1', 'Unknown Company', 'Unknown Contact', 'Unknown Title', 'None', 'None', 'None', 'None', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT northwind.DimCustomer OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[northwind].[Customer]'))
DROP VIEW [northwind].[Customer]
GO
CREATE VIEW [northwind].[Customer] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [CustomerID] AS [CustomerID]
, [CompanyName] AS [CompanyName]
, [ContactName] AS [ContactName]
, [ContactTitle] AS [ContactTitle]
, [CustomerCountry] AS [CustomerCountry]
, [CustomerRegion] AS [CustomerRegion]
, [CustomerCity] AS [CustomerCity]
, [CustomerPostalCode] AS [CustomerPostalCode]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM northwind.DimCustomer
GO

/* Drop table northwind.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimProduct 
;

/* Create table northwind.DimProduct */
CREATE TABLE northwind.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  int   NOT NULL
,  [ProductName]  nvarchar(40)   NOT NULL
,  [Discontinued]  nchar(1)  DEFAULT 'N' NOT NULL
,  [SupplierName]  nvarchar(40)   NOT NULL
,  [CategoryName]  nvarchar(15)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_northwind.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Product', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'northwind', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimProduct
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Products on an order (with supplier and category info)', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimProduct
;

SET IDENTITY_INSERT northwind.DimProduct ON
;
INSERT INTO northwind.DimProduct (ProductKey, ProductID, ProductName, Discontinued, SupplierName, CategoryName, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown', '?', 'Unknown', 'Unknown', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT northwind.DimProduct OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[northwind].[Product]'))
DROP VIEW [northwind].[Product]
GO
CREATE VIEW [northwind].[Product] AS 
SELECT [ProductKey] AS [ProductKey]
, [ProductID] AS [ProductID]
, [ProductName] AS [ProductName]
, [Discontinued] AS [Discontinued]
, [SupplierName] AS [SupplierName]
, [CategoryName] AS [CategoryName]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM northwind.DimProduct
GO

/* Drop table northwind.DimSupplier */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimSupplier') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimSupplier 
;

/* Create table northwind.DimSupplier */
CREATE TABLE northwind.DimSupplier (
   [SupplierKey]  int IDENTITY  NOT NULL
,  [SupplierID]  int   NOT NULL
,  [CompanyName]  nvarchar(40)   NOT NULL
,  [ContactName]  nvarchar(30)   NOT NULL
,  [ContactTitle]  nvarchar(30)   NOT NULL
,  [City ]  nvarchar(15)   NOT NULL
,  [Region]  nvarchar(15)  DEFAULT 'N/A' NOT NULL
,  [Country]  nvarchar(15)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_northwind.DimSupplier] PRIMARY KEY CLUSTERED 
( [SupplierKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT northwind.DimSupplier ON
;
INSERT INTO northwind.DimSupplier (SupplierKey, SupplierID, CompanyName, ContactName, ContactTitle, City , Region, Country, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT northwind.DimSupplier OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[northwind].[Supplier]'))
DROP VIEW [northwind].[Supplier]
GO
CREATE VIEW [northwind].[Supplier] AS 
SELECT [SupplierKey] AS [SupplierKey]
, [SupplierID] AS [SupplierID]
, [CompanyName] AS [CompanyName]
, [ContactName] AS [ContactName]
, [ContactTitle] AS [ContactTitle]
, [City ] AS [City ]
, [Region] AS [Region]
, [Country] AS [Country]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM northwind.DimSupplier
GO


/* Drop table northwind.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'northwind.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE northwind.DimDate 
;

/* Create table northwind.DimDate */
CREATE TABLE northwind.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  datetime   NULL
,  [FullDateUSA]  nchar(11)   NOT NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  smallint   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  [smallint]   NOT NULL
,  [IsAWeekday]  varchar(1)  DEFAULT 'N' NOT NULL
, CONSTRAINT [PK_northwind.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'northwind', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Date dimension contains one row for every day, beginning at 1/1/2005. There may also be rows for "hasn''t happened yet."', @level0type=N'SCHEMA', @level0name=northwind, @level1type=N'TABLE', @level1name=DimDate
;

INSERT INTO northwind.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsAWeekday)
VALUES (-1, '', 'Unk date', 0, 'Unk day', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, '?')
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[northwind].[Date]'))
DROP VIEW [northwind].[Date]
GO
CREATE VIEW [northwind].[Date] AS 
SELECT [DateKey] AS [DateKey]
, [Date] AS [Date]
, [FullDateUSA] AS [FullDateUSA]
, [DayOfWeek] AS [DayOfWeek]
, [DayName] AS [DayName]
, [DayOfMonth] AS [DayOfMonth]
, [DayOfYear] AS [DayOfYear]
, [WeekOfYear] AS [WeekOfYear]
, [MonthName] AS [MonthName]
, [MonthOfYear] AS [MonthOfYear]
, [Quarter] AS [Quarter]
, [QuarterName] AS [QuarterName]
, [Year] AS [Year]
, [IsAWeekday] AS [IsAWeekday]
FROM northwind.DimDate
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DateKey', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FullDateUSA', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfYear', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WeekOfYear', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthOfYear', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'QuarterName', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsAWeekday', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Full date as a SQL date', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'String expression of the full date, eg MM/DD/YYYY', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day of week; Sunday = 1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Day name of week, eg Monday', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the month', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Number of the day in the year', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Week of year, 1..53', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month name, eg January', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Month of year, 1..12', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar quarter, 1..4', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quarter name eg. First', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar year, eg 2010', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is today a weekday', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20041123', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'38314', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'23-Nov-2004', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..7', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Sunday', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..31', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..365', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1..52 or 53', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, …, 12', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3, 4', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'November', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2004', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 0', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'1', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Calendar', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Day', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'In the form: yyyymmdd', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'FullDateUSA'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'QuarterName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'northwind', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
;
ALTER TABLE northwind.FactSales ADD CONSTRAINT
   FK_northwind_FactSales_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactSales ADD CONSTRAINT
   FK_northwind_FactSales_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactSales ADD CONSTRAINT
   FK_northwind_FactSales_EmployeeKey FOREIGN KEY
   (
   EmployeeKey
   ) REFERENCES DimEmployee
   ( EmployeeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactSales ADD CONSTRAINT
   FK_northwind_FactSales_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactSales ADD CONSTRAINT
   FK_northwind_FactSales_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactInventoryDailySnapshot ADD CONSTRAINT
   FK_northwind_FactInventoryDailySnapshot_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactInventoryDailySnapshot ADD CONSTRAINT
   FK_northwind_FactInventoryDailySnapshot_SupplierKey FOREIGN KEY
   (
   SupplierKey
   ) REFERENCES DimSupplier
   ( SupplierKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE northwind.FactInventoryDailySnapshot ADD CONSTRAINT
   FK_northwind_FactInventoryDailySnapshot_DateKey FOREIGN KEY
   (
   DateKey
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
