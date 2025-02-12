{{config(materialized= 'table',alias='Products')}}

select * from
{{source('raw_qwt', 'raw_products')}}