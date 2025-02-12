{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'TRANSFORMING_DEV'))}}

/*select 
emp.empid,
emp.firstname,
emp.lastname,
emp.title,
emp.hiredate,
IFF(emp.extension = '-', 'NA', emp.extension) as extension,
emp.yearsalary,
IFF(mgr.firstname is null, emp.firstname, mgr.firstname) as managername,
IFF(mgr.title is null, emp.title, mgr.title) as managertitle,
ofc.address,
ofc.city,
ofc.country 
from 
{{ref('stg_employees')}} as emp left join 
{{ref('stg_employees')}} as mgr on emp.reportsto = mgr.empid 
left join {{ref('stg_offices')}} as ofc on emp.office = ofc.officeid */

 
 with recursive managers 
        (indent, officeid, empid, empname, emptitle, managerid, managername, managertitle) 
    as
      (
 
    select '*' as indent, 
                    office as officeid,
                    empid, 
                    firstname as empname, 
                    title as emptitle, 
                    empid as managerid, 
                    firstname as managername,
                    title as managertitle 
                    from {{ref('stg_employees')}} where title = 'President'
 
        union all
 
          select indent || '*',
            emp.office as officeid,
            emp.empid, 
            emp.firstname as empname, 
            emp.title as emptitle, 
            mgr.empid as managerid,
            mgr.empname as managername,
            mgr.emptitle as managertitle
          from {{ref('stg_employees')}} as emp inner join managers as mgr
            on emp.reportsto = mgr.empid
      ),
 
      office (officeid, city, country)
      as
      (
      select officeid, city, country from {{ref('stg_offices')}}
      )
 
  select indent,  empid, empname, emptitle, managerid, managername, managertitle,
  ofc.city, ofc.country
    from managers as mgr inner join office as ofc on mgr.officeid = ofc.officeid 