create schema current_analysis;

set search_path to current_analysis;

create table if not exists "user" (
    user_id serial primary key,
    email text not null unique,
    password text not null
);

create table if not exists tax (
    tax_id serial primary key,
    price_day_sell_value numeric(10, 2),
    price_night_sell_value numeric(10, 2),
    price_day_buy_value numeric(10, 2),
    price_night_buy_value numeric(10, 2)
);

create table if not exists "group" (
    group_id serial primary key,
    tax_id serial references tax(tax_id)
);

create table if not exists user_x_group (
    user_id serial references "user"(user_id),
    group_id serial references "group"(group_id)
);

create table if not exists consumer (
    consumer_id serial primary key,
    group_id serial references "group"(group_id),
    consumer_type_nm text,
    max_power_value numeric(20, 2),
    error_flg bool default false,
    power_day_amt numeric(20, 2) default 0.0,
    power_night_amt numeric(20, 2) default 0.0
);

create table if not exists solar_panel (
    solar_panel_id serial primary key,
    group_id serial references "group"(group_id),
    max_power_value numeric(20, 2),
    power_day_amt numeric(20, 2) default 0.0,
    power_night_amt numeric(20, 2) default 0.0
);

create table if not exists company (
    company_id serial primary key,
    company_nm text
);

create table if not exists sensor (
    sensor_id serial primary key,
    group_id serial references "group"(group_id),
    company_id serial references company(company_id),
    token_value text not null unique
);

create table if not exists consumption_measurement (
    consumption_measurement_id serial primary key,
    sensor_id serial references sensor(sensor_id),
    timestamp_dttm timestamp(0),
    power_value numeric(20, 2)
);

create table if not exists production_measurement (
    production_measurement_id serial primary key,
    sensor_id serial references sensor(sensor_id),
    timestamp_dttm timestamp(0),
    power_value numeric(20, 2)
);

create table if not exists consumer_x_consumption_measur (
    consumer_id serial references consumer(consumer_id),
    consumption_measurement_id serial
        references consumption_measurement(consumption_measurement_id)
);

create table if not exists solar_panel_x_production_measur (
    solar_panel_id serial references solar_panel(solar_panel_id),
    production_measurement_id serial
        references production_measurement(production_measurement_id)
);
