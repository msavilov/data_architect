DROP TABLE if exists STG_CUSTOMER_ADDRESS;
CREATE TABLE if not exists STG_CUSTOMER_ADDRESS(
customer_id varchar(128),
address varchar(128),
postcode varchar(128),
state varchar(128),
country varchar(128),
property_valuation varchar(128))