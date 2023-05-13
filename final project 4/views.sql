-- View of all drivers with their assigned vehicles:

CREATE VIEW DriverVehicles AS
SELECT d.DriverID, d.DriverFirstName, d.DriverLastName, d.DriverPhoneNumber, d.DriverStreet, d.DriverCity, d.DriverState, d.DriverPostalCode, a.VehicleID, a.AssignedDate
FROM Driver d
JOIN Assigned a ON d.DriverID = a.DriverID;

Select DriverID, DriverFirstName from DriverVehicles

-- View of all complaints and the corresponding customer information

CREATE VIEW Complaints AS
SELECT c.ComplaintID, c.ComplaintDescription, c.ComplaintDate, c.ComplaintStatus, c.CustomerID, cust.CustomerFirstName, cust.CustomerLastName, cust.CustomerPhoneNumber, cust.CustomerStreet, cust.CustomerCity, cust.CustomerState, cust.CustomerPostalCode
FROM Complaint c
JOIN Customer cust ON c.CustomerID = cust.CustomerID;

Select ComplaintID, ComplaintStatus from Complaints

-- View of all companies with their recycling centers

CREATE VIEW CompanyRecycling AS
SELECT comp.CompanyID, comp.CompanyName, comp.CompanyPhoneNumber, comp.CompanyState, comp.CompanyCity, comp.CompanyStreet, comp.CompanyPostalCode, rc.CenterID, rc.CenterLocation
FROM Company comp
JOIN SegCenter rc ON comp.CompanyID = rc.CompanyID;

select CompanyID, CompanyName, CompanyCity from CompanyRecycling

-- View of all recycling centers with the total waste recycled

CREATE VIEW RecyclingTotals AS
SELECT rc.CenterID, rc.RecyclingID, rc.TotalWasteRecycled
FROM RecyclingCenter rc;

select CenterID, TotalWasteRecycled from RecyclingTotals