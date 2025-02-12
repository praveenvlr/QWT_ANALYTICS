{{config(materialized= 'table')}}

select 
office as officeid,
officeaddress as address,
OfficePostalCode as PostalCode,
OfficeCity as City,
OfficeStateProvince as StateProvince,
OfficePhone	as Phone,
OfficeFax as Fax,
OfficeCountry as Country
from
{{source('raw_qwt', 'raw_office')}}