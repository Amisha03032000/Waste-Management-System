-- Nonclustered index to retrieve WorkOrder info given WorkOrderStartDate
create nonclustered index IX__WorkOrder_WorkOrderStartDate
on dbo.WorkOrder (WorkOrderStartDate)
include ([WorkOrderID],[CompanyID])
go

select WorkOrderID, CompanyID, WorkOrderStartDate,WorkOrderStatus from WorkOrder where WorkOrderStartDate='2020-04-15'


-- composite nonclustered index to retrieve data given company state and companyname
create nonclustered index IX_Company_CompanyState_CompanyName
on dbo.Company (CompanyState asc,CompanyName desc)
include ([CompanyID],[CompanyCity])
go

select CompanyID, CompanyName, CompanyState from Company where CompanyState='NY' and CompanyName='ABC Inc.'

-- create nonclustered index for driver's phone number as it is used more often
create nonclustered index IX_Driver_DriverPhoneNumber
on dbo.Driver (DriverPhoneNumber)
include ([DriverID],[DriverFirstName],[DriverLastName])
go

select DriverID, DriverFirstName, DriverState from Driver where DriverPhoneNumber='5678901234'

 