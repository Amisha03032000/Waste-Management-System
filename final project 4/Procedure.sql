USE WasteManagement1
GO

-- Procedure 1
CREATE PROC updateDate
(
    @workId int,
    @status VARCHAR(10),
    @endDate DATE
)
AS
BEGIN
    UPDATE WorkOrder
    SET WorkOrderEndDate = @endDate
    WHERE WorkOrderID = @workId AND WorkOrderStatus = @status
END

EXEC updateDate @workId = 12, @status = 'Active', @endDate = '2024-03-09'

select * From WorkOrder

select * From Waste
select * From Allotment
select * from SegCenter


select c.centerID, SUM(a.WeigthCollected) AS TotalWasteGenerated
From Allotment a
join SegCenter c
ON c.CenterID = a.CenterID
GROUP BY c.CenterID


select w.WasteID, SUM(a.WeigthCollected) AS TotalWasteGenerated
From Allotment a
join Waste w
on w.WasteID = a.WasteID
group by w.wasteID

--- procedure 2 
CREATE PROC totalWasteByWasteID (
    @wasteID INT,
    @TotalWasteGenerated INT OUTPUT
)
AS
BEGIN
    SELECT @TotalWasteGenerated = SUM(a.WeightCollected)
    From Allotment a
    join Waste w
    on w.WasteID = a.WasteID
    WHERE a.wasteID = @wasteID
    group by w.wasteID
    
END

DECLARE @TotalWasteGenerated INT
EXEC totalWasteByWasteID 5, @TotalWasteGenerated OUT
PRINT @TotalWasteGenerated

select *from Allotment


-- Procedure 3
CREATE PROC totalWasteByCenterID (
    @centerID INT,
    @TotalWasteGenerated INT OUTPUT
)
AS
BEGIN
    SELECT @TotalWasteGenerated = SUM(a.WeightCollected)
    From Allotment a
    join SegCenter c
    ON c.CenterID = a.CenterID
    WHERE a.centerID = @centerID
    GROUP BY c.CenterID
    
END

DECLARE @TotalWasteGenerated INT
EXEC totalWasteByCenterID 7, @TotalWasteGenerated OUT
PRINT @TotalWasteGenerated





UPDATE WorkOrder
SET WorkOrderEndDate = null
WHERE WorkOrderStatus = 'Pending'

SELECt * FROM WorkOrder









