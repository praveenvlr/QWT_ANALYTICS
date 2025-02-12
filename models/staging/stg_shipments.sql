{{config(materialized= 'table')}}

select 
OrderId ,
LineNo ,
ShipperId ,
CustomerId ,
ProductId ,
EmployeeId ,
to_date(split_part(ShipmentDate,' ',1)) AS ShipmentDate ,
Status 
 from
{{source('raw_qwt', 'raw_shipments')}}