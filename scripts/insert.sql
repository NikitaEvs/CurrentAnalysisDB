set search_path to current_analysis;

-- Populate users
insert into "user" (email, password) values ('cat@gmail.com', 'aaa');
insert into "user" (email, password) values ('dog@gmail.com', 'bbb');
insert into "user" (email, password) values ('beaver@gmail.com', 'ccc');
insert into "user" (email, password) values ('cow@gmail.com', 'ddd');
insert into "user" (email, password) values ('penguin@gmail.com', 'eee');
insert into "user" (email, password) values ('bear@gmail.com', 'fff');
insert into "user" (email, password) values ('capybara@gmail.com', 'ggg');
insert into "user" (email, password) values ('elephant@gmail.com', 'hhh');
insert into "user" (email, password) values ('giraffe@gmail.com', 'iii');
insert into "user" (email, password) values ('fish@gmail.com', 'jjj');

-- Populate taxes
insert into tax (price_day_sell_value,
                 price_night_sell_value,
                 price_day_buy_value,
                 price_night_buy_value)
values (6.49,
        2.42,
        6.59,
        2.52);

insert into tax (price_day_sell_value,
                 price_night_sell_value,
                 price_day_buy_value,
                 price_night_buy_value)
values (5.63,
        5.63,
        5.73,
        5.73);

insert into tax (price_day_sell_value,
                 price_night_sell_value,
                 price_day_buy_value,
                 price_night_buy_value)
values (4.51,
        1.66,
        4.61,
        1.76);

insert into tax (price_day_sell_value,
                 price_night_sell_value,
                 price_day_buy_value,
                 price_night_buy_value)
values (6.72,
        2.55,
        6.82,
        2.65);

insert into tax (price_day_sell_value,
                 price_night_sell_value,
                 price_day_buy_value,
                 price_night_buy_value)
values (4.83,
        1.81,
        4.93,
        1.91);

-- Populate groups
insert into "group" (tax_id) values (2);
insert into "group" (tax_id) values (2);
insert into "group" (tax_id) values (1);
insert into "group" (tax_id) values (3);
insert into "group" (tax_id) values (4);

-- Populate user_x_groups
insert into user_x_group (user_id, group_id) values (1, 1);
insert into user_x_group (user_id, group_id) values (2, 1);
insert into user_x_group (user_id, group_id) values (3, 2);
insert into user_x_group (user_id, group_id) values (4, 2);
insert into user_x_group (user_id, group_id) values (5, 3);
insert into user_x_group (user_id, group_id) values (6, 3);
insert into user_x_group (user_id, group_id) values (7, 4);
insert into user_x_group (user_id, group_id) values (8, 4);
insert into user_x_group (user_id, group_id) values (9, 5);
insert into user_x_group (user_id, group_id) values (10, 5);

-- Populate consumer
insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
                      )
values (
            1,
            'kettle',
            1200.0
       );

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
)
values (
           1,
           'bulb',
           100.0
       );

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
)
values (
           2,
           'phone',
           40.0
       );

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
)
values (
           2,
           'laptop',
           70.0
       );

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
)
values (
           3,
           'bulb',
           100.0
       );

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
)
values (
           3,
           'freezer',
           1500.0
       );

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
)
values (
           4,
           'microwave',
           1500.0
       );

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
)
values (
           4,
           'phone',
           35.0
       );

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
)
values (
           5,
           'light',
           250.0
       );

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value
)
values (
           5,
           'kettle',
           1300.0
       );

-- Populate solar_panels

insert into solar_panel (group_id,
                         max_power_value)
values (
            1,
            1000.0
       );

insert into solar_panel (group_id,
                         max_power_value)
values (
           1,
           1100.0
       );

insert into solar_panel (group_id,
                         max_power_value)
values (
           2,
           1300.0
       );

insert into solar_panel (group_id,
                         max_power_value)
values (
           2,
           1300.0
       );

insert into solar_panel (group_id,
                         max_power_value)
values (
           3,
           1000.0
       );

insert into solar_panel (group_id,
                         max_power_value)
values (
           3,
           2000.0
       );

insert into solar_panel (group_id,
                         max_power_value)
values (
           4,
           2000.0
       );

insert into solar_panel (group_id,
                         max_power_value)
values (
           4,
           2000.0
       );

insert into solar_panel (group_id,
                         max_power_value)
values (
           5,
           1800.0
       );

insert into solar_panel (group_id,
                         max_power_value)
values (
           5,
           1700.0
       );

-- Populate company
insert into company (company_nm) values ('МРСК Поволжье');
insert into company (company_nm) values ('МРСК Урал');
insert into company (company_nm) values ('МРСК Центр');
insert into company (company_nm) values ('МРСК Юг');
insert into company (company_nm) values ('МРСК Восток');

-- Populate sensor
insert into sensor (group_id,
                    company_id,
                    token_value)
values (
            1,
            1,
            'aaa'
       );

insert into sensor (group_id,
                    company_id,
                    token_value)
values (
           1,
           1,
           'bbb'
       );

insert into sensor (group_id,
                    company_id,
                    token_value)
values (
           2,
           1,
           'ccc'
       );

insert into sensor (group_id,
                    company_id,
                    token_value)
values (
           2,
           1,
           'ddd'
       );

insert into sensor (group_id,
                    company_id,
                    token_value)
values (
           3,
           2,
           'eee'
       );

insert into sensor (group_id,
                    company_id,
                    token_value)
values (
           3,
           2,
           'fff'
       );

insert into sensor (group_id,
                    company_id,
                    token_value)
values (
           4,
           3,
           'ggg'
       );

insert into sensor (group_id,
                    company_id,
                    token_value)
values (
           4,
           3,
           'hhh'
       );


insert into sensor (group_id,
                    company_id,
                    token_value)
values (
           5,
           5,
           'iii'
       );

insert into sensor (group_id,
                    company_id,
                    token_value)
values (
           5,
           5,
           'jjj'
       );

--  Populate consumption_measurement
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(1, '2020-03-04 01:00:00', 1024.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(1, '2020-03-04 02:00:00', 37.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(2, '2020-03-04 03:00:00', 349.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(2, '2020-03-04 04:00:00', 155.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(3, '2020-03-04 05:00:00', 875.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(3, '2020-03-04 06:00:00', 596.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(4, '2020-03-04 07:00:00', 1105.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(4, '2020-03-04 08:00:00', 516.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(5, '2020-03-04 09:00:00', 1087.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(5, '2020-03-04 10:00:00', 998.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(6, '2020-03-04 11:00:00', 1035.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(6, '2020-03-04 12:00:00', 742.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(7, '2020-03-04 13:00:00', 1247.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(7, '2020-03-04 14:00:00', 1177.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(8, '2020-03-04 15:00:00', 352.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(8, '2020-03-04 16:00:00', 86.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(9, '2020-03-04 17:00:00', 128.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(9, '2020-03-04 18:00:00', 347.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(10, '2020-03-04 19:00:00', 1117.0);
insert into consumption_measurement (sensor_id, timestamp_dttm, power_value) values(10, '2020-03-04 20:00:00', 219.0);

-- Populate production_measurement
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(1, '2020-03-04 01:00:00', 1686.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(1, '2020-03-04 02:00:00', 1451.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(2, '2020-03-04 03:00:00', 550.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(2, '2020-03-04 04:00:00', 1165.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(3, '2020-03-04 05:00:00', 1989.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(3, '2020-03-04 06:00:00', 1311.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(4, '2020-03-04 07:00:00', 1498.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(4, '2020-03-04 08:00:00', 1169.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(5, '2020-03-04 09:00:00', 1215.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(5, '2020-03-04 10:00:00', 1590.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(6, '2020-03-04 11:00:00', 1268.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(6, '2020-03-04 12:00:00', 1403.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(7, '2020-03-04 13:00:00', 695.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(7, '2020-03-04 14:00:00', 1709.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(8, '2020-03-04 15:00:00', 1232.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(8, '2020-03-04 16:00:00', 819.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(9, '2020-03-04 17:00:00', 609.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(9, '2020-03-04 18:00:00', 1116.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(10, '2020-03-04 19:00:00', 1492.0);
insert into production_measurement (sensor_id, timestamp_dttm, power_value) values(10, '2020-03-04 20:00:00', 1545.0);

-- Populate consumer_x_consumption_measur
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (1, 1);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (1, 2);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (2, 3);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (2, 4);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (3, 5);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (3, 6);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (4, 7);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (4, 8);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (5, 9);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (5, 10);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (6, 11);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (6, 12);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (7, 13);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (7, 14);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (8, 15);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (8, 16);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (9, 17);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (9, 18);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (10, 19);
insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id) values (10, 20);

-- Populate solar_panel_x_production_measur
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (1, 1);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (1, 2);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (2, 3);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (2, 4);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (3, 5);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (3, 6);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (4, 7);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (4, 8);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (5, 9);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (5, 10);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (6, 11);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (6, 12);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (7, 13);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (7, 14);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (8, 15);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (8, 16);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (9, 17);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (9, 18);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (10, 19);
insert into solar_panel_x_production_measur (solar_panel_id, production_measurement_id) values (10, 20);


