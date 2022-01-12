-- This refers to the table created from seeds/all_days.csv
select * from {{ ref('all_days') }}