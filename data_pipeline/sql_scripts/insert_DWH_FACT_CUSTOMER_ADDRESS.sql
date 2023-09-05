INSERT OR IGNORE INTO
    DWH_FACT_CUSTOMER_ADDRESS (customer_id, address, postcode,state, country,
                               property_valuation
                               )
SELECT
       cast(customer_id as bigint) as customer_id,
       address,
       cast(postcode as int) as postcode,
       state,
       country,
       cast(property_valuation as int) as property_valuation
FROM STG_CUSTOMER_ADDRESS
ORDER BY customer_id;