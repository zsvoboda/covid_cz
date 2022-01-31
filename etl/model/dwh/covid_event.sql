select (row_number() over ())                                                       as covid_event_id,
       datum                                                                        as covid_event_date,
       covid_event_type,
       lpad(cast(vek as CHAR(3)), 3, '0')                                           as covid_event_person_age,
       vek                                                                          as covid_event_person_age_num,
       (case when pohlavi = 'Z' then 'F' when pohlavi = 'M' then 'M' end)           as covid_event_person_gender,
       okres_lau_kod                                                                as district_id,
       kraj_nuts_kod                                                                as wdf__county_id,
       1                                                                            as covid_event_cnt
from (select id, datum, 'I' as covid_event_type, vek, pohlavi, okres_lau_kod, kraj_nuts_kod from stage.ext_osoby
      UNION
      select id, datum, 'R' as covid_event_type, vek, pohlavi, okres_lau_kod, kraj_nuts_kod from stage.ext_vyleceni
      UNION
      select id, datum, 'D' as covid_event_type, vek, pohlavi, okres_lau_kod, kraj_nuts_kod from stage.ext_umrti) a