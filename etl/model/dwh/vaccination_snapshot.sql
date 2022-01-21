select (row_number() over ())           as vaccination_snapshot_id,
       vakcina_kod                      as vaccine_id,
       kraj_nuts_kod                    as vaccination_county_id,
       coalesce('CZ0'|| left(orp_bydliste_kod,2), 'CZ000') as county_id,
       coalesce('CZ0'|| left(orp_bydliste_kod,2), 'CZ000') as wdf__county_id,
       vekova_skupina                   as vaccination_snapshot_age_group,
       pohlavi                          as vaccination_snapshot_gender,
       poradi_davky                     as vaccination_snapshot_dose_order,
       pocet_davek                      as vaccination_snapshot_count
from stage.ext_ockovani_zakladni_prehled
