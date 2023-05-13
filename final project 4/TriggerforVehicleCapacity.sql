CREATE TRIGGER CheckVehicleCapacity
ON Vehicle
AFTER INSERT, UPDATE
AS
BEGIN
  IF EXISTS (SELECT 1 FROM inserted WHERE VehicleCapacity > 10000)
  BEGIN
    RAISERROR('Vehicle capacity cannot be more than 10000', 16, 1)
    ROLLBACK TRANSACTION
  END
END


SELECT * from Vehicle
INSERT INTO Vehicle (VehicleCapacity, VehiclePlate) VALUES (20000, 'BMQ2345');
