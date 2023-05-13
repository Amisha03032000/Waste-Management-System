-- UDF to get total waste by centerID 
 
CREATE FUNCTION dbo.GetTotalWasteByCenterID (@CenterID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalWaste DECIMAL(10,2)
    SELECT @TotalWaste = SUM(GarbageWeight)
    FROM Serviced s
    JOIN Bin b ON s.BinID = b.BinID
    JOIN SegCenter c ON b.CustomerID = c.CompanyID
    WHERE c.CenterID = @CenterID
    RETURN @TotalWaste
END

 

ALTER TABLE SegCenter
ADD TotalWaste AS dbo.GetTotalWasteByCenterID(CenterID)


SELECT dbo.GetTotalWasteByCenterID(9) AS TotalWaste

