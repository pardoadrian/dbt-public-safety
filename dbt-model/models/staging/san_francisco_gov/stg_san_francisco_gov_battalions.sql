with battlion as (
    
    select distinct
        Battalion as battlion_id
        
    
    from {{source('san_francisco_gov','src_fire_incidents')}}
)

select * from battlion