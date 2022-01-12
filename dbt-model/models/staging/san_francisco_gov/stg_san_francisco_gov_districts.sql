-- This refers to the table created from seeds/all_districts.csv
select * from {{ ref('all_districts') }}