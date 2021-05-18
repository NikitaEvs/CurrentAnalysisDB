set search_path to current_analysis;

-- Получаем сумму, максимум и минимум мощности для каждого потребителя
-- по дням недели
create or replace view v_consumer_weekly_power_usage as
(
    select distinct consumer_type_nm,
           day_of_week,
           sum(power_value) over (partition by day_of_week) as power_amt,
           max(power_value) over (partition by day_of_week) as power_max,
           min(power_value) over (partition by day_of_week) as power_min
    from
        (
            select consumer_type_nm,
                   extract(isodow from timestamp_dttm) as day_of_week,
                   power_value
            from
                consumer
                    join consumer_x_consumption_measur cxcm
                         on consumer.consumer_id = cxcm.consumer_id
                    join consumption_measurement cm
                         on cxcm.consumption_measurement_id = cm.consumption_measurement_id
        ) as daily_usage
    order by consumer_type_nm, day_of_week
);

select * from v_consumer_weekly_power_usage;

-- Получаем для каждого пользователя суммарное производство
-- электричества от всех солнечных панелей, принадлежащих группе, в
-- которой находится пользователь
create or replace view v_solar_panel_user_sum as
(
    select email, solar_amt
    from (
             select distinct group_id, sum(power_value) over (partition by group_id) as solar_amt
             from (
                      select group_id,
                             power_value
                      from solar_panel
                               join solar_panel_x_production_measur spxpm
                                    on solar_panel.solar_panel_id = spxpm.solar_panel_id
                               join production_measurement pm
                                    on spxpm.production_measurement_id = pm.production_measurement_id
                  ) as daily_usage
         ) as user_usage
         join user_x_group
             on user_x_group.group_id = user_usage.group_id
         join "user"
             on user_x_group.user_id = "user".user_id
);

select * from v_solar_panel_user_sum;
