create server multicorn_gooddata foreign data wrapper multicorn
  options (
    wrapper 'gooddata_fdw.GoodDataForeignDataWrapper',
    host 'http://gooddata-cn-ce:3000', -- host equal to name of container with GoodData.CN.CE
    token 'YWRtaW46Ym9vdHN0cmFwOmFkbWluMTIz', -- default gooddata-cn-ce token, documented in public DOC as well
    headers_host 'localhost'
  );
 
create schema "covid_cz";

call import_gooddata('covid_cz', 'all'); 

drop foreign table if exists infections_by_county;
create foreign table infections_by_county (
    date_quarter varchar options (id 'label/date.month'),
	county_name varchar options (id 'label/county_name'),
    infections  NUMERIC(18,0) options (id 'metric/infections'),
    deaths  NUMERIC(18,0) options (id 'metric/deaths')
)
SERVER multicorn_gooddata
OPTIONS ( workspace 'covid_cz');

select * from infections_by_county;

select date_month, county_name, infections from covid_cz.compute;