select 
		(row_number() over ()) as vaccination_id, 
		datum as vaccination_date, 
		vaccine_id as vaccine_id, 
		kraj_nuts_kod as vaccination_county_id, 
		kraj_nuts_kod as wdf__county_id, 
		vekova_skupina as vaccination_age_group, 
		prvnich_davek as vaccination_first_doses, 
		druhych_davek as vaccination_second_doses, 
		celkem_davek as vaccination_total_doses 
	from stage.ext_ockovani o 
        join dwh.vaccine v 
            on v.vaccine_name = o.vakcina