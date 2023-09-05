CREATE TABLE if not exists DWH_FACT_CUSTOMER_ADDRESS(
customer_id varchar(128) primary key,
address varchar(128),
postcode int,
state varchar(128),
country varchar(128),
property_valuation int,
create_dt date,
update_dt date
);

CREATE TRIGGER if not exists update_trigger_DWH_FACT_CUSTOMER_ADDRESS AFTER UPDATE
    ON DWH_FACT_CUSTOMER_ADDRESS
    BEGIN
        update DWH_FACT_CUSTOMER_ADDRESS SET update_dt = current_timestamp WHERE
        customer_id = NEW.customer_id;
    END;

CREATE TRIGGER if not exists insert_trigger_DWH_FACT_CUSTOMER_ADDRESS AFTER INSERT
    ON DWH_FACT_CUSTOMER_ADDRESS
    BEGIN
        update DWH_FACT_CUSTOMER_ADDRESS SET (create_dt, update_dt) =
        (current_timestamp, current_timestamp) WHERE
        customer_id=NEW.customer_id;
    END;