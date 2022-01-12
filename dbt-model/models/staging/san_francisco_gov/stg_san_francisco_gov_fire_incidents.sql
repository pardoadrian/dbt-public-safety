with incidents as (
    
    select 
        "Incident Number" as incident_id,
        Battalion as battlion_id,
        concat(City,';', Zipcode) as district_spk,
        "Incident Date"::date as incident_date,
        "Suppression Personnel"::integer as supression_personnel,
        "Estimated Property Loss"::integer as estimated_property_loss,
        "Civilian Fatalities":: integer as civilian_fatalities,
        "Primary Situation"::integer as primary_situation
        "Ignition Cause" as ignition_cause,
        "Structure Type" as structure_type,
        Location as coordinates
    
    from {{source('san_francisco_gov','src_fire_incidents')}}
)

select * from incidents