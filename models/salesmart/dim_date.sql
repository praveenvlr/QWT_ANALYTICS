{{config(materialized = 'table', schema = 'salesmart_dev')}}

{% set min_order_Date= get_min_order_date() %}

{% set max_order_Date= get_max_order_date() %}
 
 {{dbt_date.get_date_dimension(min_order_Date,max_order_Date)}}