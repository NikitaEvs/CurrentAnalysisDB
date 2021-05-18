set search_path to current_analysis;

insert into consumer (group_id,
                      consumer_type_nm,
                      max_power_value,
                      error_flg,
                      power_day_amt,
                      power_night_amt)
values (1, 'kettle', 1200.0, false, 0.0, 0.0);

select * from consumer
where consumer_type_nm = 'bulb';

update consumer set group_id = 2 where group_id = 1;

delete from consumer where group_id = 4;

insert into consumption_measurement (sensor_id, timestamp_dttm, power_value)
values (1, '20200410', 1450.0);

select * from consumption_measurement
where timestamp_dttm < '20200415';

update consumption_measurement
set sensor_id = 2
where sensor_id = 1;

delete from consumption_measurement
where timestamp_dttm between '20200415' and '20200422';

