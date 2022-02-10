select distinct 
    kraj_kod as county_id,
    kraj_kod as wdf__county_id, 
    kraj as county_name, 
    'CZ' as country_id
from stage.ext_souradnice
union 
select 'CZ000', 'CZ000', 'Neznámý', 'CZ'