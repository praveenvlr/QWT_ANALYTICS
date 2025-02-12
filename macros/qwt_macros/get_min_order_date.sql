{% macro get_min_order_date() -%}
 
{% set lineno_query %}
select min(orderDate) as minorderdate
from {{ ref('fct_orders') }}
order by 1
{% endset %}
 
{% set results = run_query(lineno_query) %}
 
{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0][0] %}
{% else %}
{% set results_list = [] %}
{% endif %}
 
{{ return(results_list) }}

{% endmacro %}