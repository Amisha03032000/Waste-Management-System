CREATE TRIGGER UpdateWorkOrderStatus
ON WorkOrder
AFTER UPDATE
AS
BEGIN
    IF UPDATE(WorkOrderEndDate)
    BEGIN
        UPDATE WorkOrder
        SET WorkOrderStatus = 'Completed', PaymentDate = GETDATE(), Amount = 100, PaymentMethod = 'Credit'
        FROM inserted
        WHERE inserted.WorkOrderID = WorkOrder.WorkOrderID
          AND inserted.WorkOrderEndDate IS NOT NULL
    END
END
--ABORT
EXEC updateDate @workId = 19, @status = 'Active', @endDate = '2024-03-09'


select * from WorkOrder
 