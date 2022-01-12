select
    incident_id,
    incident_date,
    t.year,
    d.city,
    d.zipcode,
    coordinates,
    b.battlion_id
    neighborhood_district,
    ignition_cause,
    civilian_fatalities
    structure_type
from {{ref('stg_san_francisco_gov_fire_incidents')}} fi
left join {{ref('stg_san_francisco_gov_battlion')}} b on fi.battlion_id = b.battlion_id
left join {{ref('stg_san_francisco_gov_districts')}} d on d.district_spk = fi.district_spk
left join {{ref('dim_time')}} t on t.date_spk = fi.date_spk
;