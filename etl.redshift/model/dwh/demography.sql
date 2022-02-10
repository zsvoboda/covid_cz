select distinct obec_kod2           as demography_id,
                obec_kod2           as city_id,
                kraj_kod            as wdf__county_id, 
                pocet_obyvatel      as city_population,
                pocet_muzi          as city_population_male,
                pocet_zeny          as city_population_female,
                vek_prumer          as city_average_age,
                vek_prumer_muzi     as city_average_age_male,
                vek_prumer_zeny     as city_average_age_female
from stage.ext_demografie_2021
join stage.ext_souradnice 
    on stage.ext_souradnice.obec_kod = stage.ext_demografie_2021.obec_kod2
