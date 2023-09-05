INSERT OR IGNORE INTO
    DWH_FACT_CUSTOMER_DEMOGRAPHIC (customer_id,first_name,last_name,gender,
                                   past_3_years_bike_related_purchases, dob,
                                   job_title, job_industry_category,
                                   wealth_segment, deceased_indicator,owns_car,
                                   tenure
                                   )
SELECT cast(customer_id as bigint) as customer_id,
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
       cast(tenure as int) as tenure
FROM STG_CUSTOMER_DEMOGRAPHIC
ORDER BY customer_id;
