CREATE DATABASE WasteManagement1
USE WasteManagement1
GO


-- Customer Table
CREATE TABLE Customer (
    CustomerID INT NOT NULL IDENTITY(1, 1),
    CustomerFirstName NVARCHAR(25),
    CustomerLastName NVARCHAR(25),
    CustomerPhoneNumber CHAR(10),
    CustomerStreet VARCHAR(30),
    CustomerCity VARCHAR(20),
    CustomerState CHAR(2),
    CustomerPostalCode CHAR(5),
    CONSTRAINT Customer_PK PRIMARY KEY (CustomerID),
    CONSTRAINT chk_Custphone CHECK (CustomerPhoneNumber not like '%[^0-9]%'),
    CONSTRAINT chk_zip CHECK (CustomerPostalCode not like '%[^0-9]%')
);

-- Bin Table
CREATE TABLE Bin (
    BinID INT NOT NULL IDENTITY(1,1),
    Capacity INT,
    LastEmptiedDate DATE,
    CustomerID INT NOT NULL,
    CONSTRAINT Bin_PK PRIMARY KEY (BinID),
    CONSTRAINT Bin_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
);

-- Vehicle Table
CREATE TABLE Vehicle (
    VehicleID INT NOT NULL IDENTITY(1,1),
    VehicleCapacity BIGINT,
    VehiclePlate VARCHAR(8),
    CONSTRAINT Vehicle_PK PRIMARY KEY (VehicleID)
);

-- Serviced Table
CREATE TABLE Serviced (
    ServiceID INT NOT NULL IDENTITY(1,1),
    BinID INT NOT NULL,
    VehicleID INT NOT NULL,
    ServiceDate DATE,
    GarbageWeight BIGINT,
    CONSTRAINT Serviced_PK PRIMARY KEY (ServiceID),
    CONSTRAINT Serviced_FK1 FOREIGN KEY (BinID) REFERENCES Bin(BinID),
    CONSTRAINT Serviced_FK2 FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);

-- Driver Table
CREATE TABLE Driver (
    DriverID INT NOT NULL IDENTITY(1,1),
    DriverFirstName NVARCHAR(25),
    DriverLastName NVARCHAR(25),
    DriverPhoneNumber CHAR(10),
    DriverStreet VARCHAR(30),
    DriverCity VARCHAR(20),
    DriverState CHAR(2),
    DriverPostalCode VARCHAR(9),
    CONSTRAINT Driver_PK PRIMARY KEY (DriverID),
    CONSTRAINT chk_phone CHECK (DriverPhoneNumber not like '%[^0-9]%')
);


-- Assigned Table
CREATE TABLE Assigned (
    DriverID INT NOT NULL,
    VehicleID INt NOT NULL,
    AssignedDate DATE,
    CONSTRAINT Assigned_PK PRIMARY KEY (DriverID, VehicleID),
    CONSTRAINT Assigned_FK FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
    CONSTRAINT Assigned_FK1 FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);



-- Waste Table
CREATE TABLE Waste (
    WasteID INT NOT NULL IDENTITY(1,1),
    WasteName NVARCHAR(50),
    HazardeousWaste CHAR(1),
    CONSTRAINT Waste_PK PRIMARY KEY (WasteID),
    CONSTRAINT chk_hazardous CHECK(HazardeousWaste in ('Y','N'))
);


-- Complaint Table
CREATE TABLE Complaint (
    ComplaintID INT NOT NULL IDENTITY(1,1),
    ComplaintDescription VARCHAR(100),
    ComplaintDate DATE,
    ComplaintStatus VARCHAR(10),
    CustomerID INT NOT NULL,
    CONSTRAINT Compalint_PK PRIMARY KEY (ComplaintID),
    CONSTRAINT Complaint_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Company Table
CREATE TABLE Company (
    CompanyID INT NOT NULL IDENTITY(1,1),
    CompanyName NVARCHAR(50),
    CompanyPhoneNumber CHAR(10),
    CompanyState CHAR(2),
    CompanyCity VARCHAR(20),
    CompanyStreet VARCHAR(30),
    CompanyPostalCode VARCHAR(9),
    CONSTRAINT Company_PK PRIMARY KEY (CompanyID),
    CONSTRAINT check_CompanyPhone CHECK (CompanyPhoneNumber not like '%[^0-9]%')
);


-- WorkOrder Table
CREATE TABLE WorkOrder(
    WorkOrderID INT NOT NULL IDENTITY(1,1),
    ComplaintID INT NOT NULL,
    CompanyID INT NOT NULL,
    WorkOrderStartDate DATE,
    WorkOrderEndDate DATE,
    Comment VARCHAR(50),
    WorkOrderStatus VARCHAR(10),
    PaymentDate DATE,
    PaymentMethod VARCHAR(10),
    Amount DECIMAL(5, 2),
    CONSTRAINT WorkOrder_PK PRIMARY KEY (WorkOrderID),
    CONSTRAINT WorkOrder_FK FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
    CONSTRAINT WorkOrder_FK1 FOREIGN KEY (ComplaintID) REFERENCES Complaint(ComplaintID),
    CONSTRAINT check_Dates CHECK ((WorkOrderStartDate is null OR WorkOrderEndDate is null OR WorkOrderStartDate < WorkOrderEndDate))
);



-- Recycling Center Table
CREATE TABLE Recycling (
    RecyclingID INT NOT NULL IDENTITY(1,1),
    RecyclingWaste CHAR(1),
    CONSTRAINT Recycling_PK PRIMARY KEY (RecyclingID)
);


-- SegCenter Table
CREATE TABLE SegCenter (
    CenterID INT NOT NULL IDENTITY(1,1),
    CenterLocation VARCHAR(50),
    RecyclingID INT REFERENCES Recycling(RecyclingID),
    CompanyID INT NOT NULL,
    CONSTRAINT SegCenter_PK PRIMARY KEY (CenterID),
    CONSTRAINT SegCenter_FK FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
    CONSTRAINT SegCenter_PK1 UNIQUE (CenterID, RecyclingID)
);


-- Recycling Center
CREATE TABLE RecyclingCenter (
    CenterID INT NOT NULL,
    RecyclingID AS 1 PERSISTED,
    TotalWasteRecycled INT,
    CONSTRAINT RecyclingCenter_PK PRIMARY KEY (CenterID),
    CONSTRAINT RecyclingCenter_FK FOREIGN KEY (CenterID, RecyclingID) REFERENCES SegCenter(CenterID, RecyclingID),
);

-- Disposal Center
CREATE TABLE DisposalCenter (
    CenterID INT NOT NULL,
    RecyclingID AS 2 PERSISTED,
    TotalWasteDisposed INT,
    CONSTRAINT DisposalCenter_PK PRIMARY KEY (CenterID),
    CONSTRAINT DisposalCenter_FK FOREIGN KEY (CenterID, RecyclingID) REFERENCES SegCenter(CenterID, RecyclingID)
);

CREATE TABLE Allotment (
    CenterID INT NOT NULL,
    WasteID INT NOT NULL,
    VehicleID INT NOT NULL,
    WeightCollected INT,
    AllotmentDate DATE,
    CONSTRAINT Allotment_PK PRIMARY KEY (CenterID, WasteID, VehicleID),
    CONSTRAINT Alotment_FK FOREIGN KEY (CenterID) REFERENCES SegCenter(CenterID),
    CONSTRAINT Alotment_FK1 FOREIGN KEY (WasteID) REFERENCES Waste(WasteID),
    CONSTRAINT Alotment_FK2 FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);


CREATE TABLE Employee (
    EmployeeID INT NOT NULL IDENTITY(1,1),
    EmployeeFirstName VARCHAR(25),
    EmployeeLastName Varchar(25),
    Username VARCHAR(25),
    [Password] Varchar(400),
    CompanyID int not null,
    CONSTRAINT Employee_PK PRIMARY KEY (EmployeeID),
     CONSTRAINT Employee_Fk FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);


select * from SegCenter