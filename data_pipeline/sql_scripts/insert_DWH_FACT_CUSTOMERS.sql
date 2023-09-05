INSERT OR IGNORE INTO
    DWH_FACT_CUSTOMERS (customer_id,first_name,last_name,gender,
                        past_3_years_bike_related_purchases, dob, job_title,
                        job_industry_category, wealth_segment,
                        deceased_indicator, owns_car, tenure, address,
                        postcode,state, country, property_valuation)
SELECT cast(scd.customer_id as bigint) as customer_id,
       first_name,
       last_name,
       gender,
       cast(past_3_years_bike_related_purchases as int) as past_3_years_bike_related_purchases,
       cast(dob as date) as dob,
       job_title,
       job_industry_category,
       wealth_segment,
       deceased_indicator,
       cast(owns_car as boolean) as owns_car,
       cast(tenure as int) as tenure,
       address,
       cast(postcode as int) as postcode,
       state,
       country,
       cast(property_valuation as int) as property_valuation
FROM STG_CUSTOMER_DEMOGRAPHIC as scd
JOIN STG_CUSTOMER_ADDRESS on scd.customer_id = STG_CUSTOMER_ADDRESS.customer_id
ORDER BY customer_id;