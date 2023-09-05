CREATE TABLE if not exists DWH_FACT_CUSTOMER_DEMOGRAPHIC(
customer_id bigint primary key,
first_name varchar(128),
last_name varchar(128),
gender varchar(128),
past_3_years_bike_related_purchases int,
dob date,
job_title varchar(128),
job_industry_category varchar(128),
wealth_segment varchar(128),
deceased_indicator varchar(128),
owns_car boolean,
tenure int,
create_dt date,
update_dt date
);


CREATE TRIGGER if not exists update_trigger_DWH_FACT_CUSTOMER_DEMOGRAPHIC AFTER UPDATE
    ON DWH_FACT_CUSTOMER_DEMOGRAPHIC
    BEGIN
        update DWH_FACT_CUSTOMER_DEMOGRAPHIC SET update_dt = current_timestamp WHERE
        customer_id = NEW.customer_id;
    END;

CREATE TRIGGER if not exists insert_trigger_DWH_FACT_CUSTOMER_DEMOGRAPHIC AFTER INSERT
    ON DWH_FACT_CUSTOMER_DEMOGRAPHIC
    BEGIN
        update DWH_FACT_CUSTOMER_DEMOGRAPHIC SET (create_dt, update_dt) =
        (current_timestamp, current_timestamp) WHERE
        customer_id = NEW.customer_id;
    END;