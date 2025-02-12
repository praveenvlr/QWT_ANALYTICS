{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'TRANSFORMING_DEV'))}}
select
GET(XMLGET(Suppliers_Info, 'SupplierID'), '$') as SupplierID,
GET(XMLGET(Suppliers_Info, 'CompanyName'), '$')::varchar as CompanyName,
GET(XMLGET(Suppliers_Info, 'ContactName'), '$')::varchar as ContactName,
GET(XMLGET(Suppliers_Info, 'Address'), '$')::varchar as Address,
GET(XMLGET(Suppliers_Info, 'City'), '$')::varchar as City,
GET(XMLGET(Suppliers_Info, 'PostalCode'), '$')::varchar as PostalCode,
GET(XMLGET(Suppliers_Info, 'Country'), '$')::varchar as Country,
GET(XMLGET(Suppliers_Info, 'Phone'), '$')::varchar as Phone,
GET(XMLGET(Suppliers_Info, 'Fax'), '$')::varchar as Fax

from
{{ref('stg_suppliers')}} 

