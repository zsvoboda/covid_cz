select distinct okres_kod   as district_id,
                kraj_kod    as county_id,
                okres       as district_name
from stage.ext_souradnice
