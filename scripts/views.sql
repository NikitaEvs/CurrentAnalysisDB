set search_path to current_analysis;

create or replace view v_user as
(
    select substr(email, 0, length(email) / 2)||'*****' as email, '*****' as password
    from "user"
);

select *
from v_user;

create or replace view v_tax as
(
    select price_day_sell_value as day_sell_price,
            price_day_buy_value as day_buy_price,
            price_night_sell_value as night_sell_price,
            price_night_buy_value as night_buy_price
    from tax
);

select *
from v_tax;

create or replace view v_group_x_user as
(
    select substr(email, 0, length(email) / 2)||'*****' as email,
           dense_rank() over (order by g.group_id) as group_number
    from "user"
        join user_x_group uxg
            on "user".user_id = uxg.user_id
        join "group" g
            on g.group_id = uxg.group_id
);

select * from v_group_x_user;

create or replace view v_user_x_tax as
(
    select substr(email, 0, length(email) / 2)||'*****' as email,
            price_day_sell_value as day_sell_price,
            price_day_buy_value as day_buy_price,
            price_night_sell_value as night_sell_price,
            price_night_buy_value as night_buy_price
    from "user"
         join user_x_group uxg
              on "user".user_id = uxg.user_id
         join "group" g
              on g.group_id = uxg.group_id
         join tax t
             on g.tax_id = t.tax_id
);

select * from v_user_x_tax;

create or replace view v_consumer as
(
    select consumer_type_nm,
           max_power_value,
           error_flg,
           power_day_amt,
           power_night_amt
    from consumer
    order by max_power_value desc
);

select * from v_consumer;

create or replace view v_solar_panel as
(
    select max_power_value,
           power_day_amt,
           power_night_amt
    from solar_panel
    order by max_power_value desc
);

select * from v_solar_panel;

create or replace view v_consumption_measur as
(
    select consumer_type_nm,
           max_power_value,
           power_value,
           timestamp_dttm
    from consumer
        join consumer_x_consumption_measur cxcm
            on consumer.consumer_id = cxcm.consumer_id
        join consumption_measurement cm
            on cxcm.consumption_measurement_id = cm.consumption_measurement_id
    order by timestamp_dttm
);

select * from v_consumption_measur;

create or replace view v_production_measur as
(
    select max_power_value,
           power_value,
           timestamp_dttm
    from solar_panel
        join solar_panel_x_production_measur spxpm
            on solar_panel.solar_panel_id = spxpm.solar_panel_id
        join production_measurement pm
            on spxpm.production_measurement_id = pm.production_measurement_id
    order by timestamp_dttm
);

select * from v_production_measur;

create or replace view v_sensor as
(
    select '***' as token,
           company_nm
    from sensor
        join company c
            on c.company_id = sensor.company_id
);

select * from v_sensor;
