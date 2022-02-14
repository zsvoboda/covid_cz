select distinct 
    kraj_kod as vaccination_county_id,
    kraj as vaccination_county_name, 
    'CZ' as vaccination_country_id
from stage.ext_souradnice
