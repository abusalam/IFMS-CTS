
– Get all comments on a table
select tc.*
from all_tab_comments tc
    join all_tables t
    on tc.owner = t.owner
    and tc.table_name = t.table_name
where t.table_name = 'HR_MM_GEN_TA_DA_BLOCK_YEAR'


– Get all comments on all columns of a table
SELECT table_name,
     column_name,
     comments
   FROM ALL_COL_COMMENTS
   WHERE owner   ='IHRMS'
   AND table_name='HR_MM_GEN_TA_DA_TRAVEL_TYPE';

– Check existence of a column in entire schema
SELECT t.owner,
     t.table_name,
     t.num_rows
FROM   all_tables t
     LEFT JOIN all_tab_columns c
            ON t.table_name = c.table_name
WHERE  num_rows IS NOT NULL AND t.owner='IHRMS' AND c.column_name = 'INT_TA_DA_CLAIM_ID'
GROUP  BY t.owner,
        t.table_name,
        t.num_rows
ORDER  BY t.num_rows DESC;

– Find all foreign keys
SELECT a.table_name, a.column_name, a.constraint_name, c.owner,
      -- referenced pk
      c.r_owner, c_pk.table_name r_table_name, c_pk.constraint_name r_pk
 FROM all_cons_columns a
 JOIN all_constraints c ON a.owner = c.owner
                       AND a.constraint_name = c.constraint_name
 JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                          AND c.r_constraint_name = c_pk.constraint_name
WHERE c.constraint_type = 'R'
  AND a.table_name = 'HR_TM_TA_DA_APPLICATION'

– References
select table_name, constraint_name, status, owner
from all_constraints
where r_owner = 'IHRMS'
and constraint_type = 'R'
and r_constraint_name in
(
  select constraint_name from all_constraints
  where constraint_type in ('P', 'U')
  and table_name = 'HR_TM_TA_DA_APPLICATION'
  and owner = 'IHRMS'
)
order by table_name, constraint_name