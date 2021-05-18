set search_path to current_analysis;

-- Возвращает разницу в цене, которую группа пользователей c id = current_group_id заплатила бы за элекроэнергию
-- в случае перехода на новый тариф с id = new_tax_id
create or replace function calculate_profit(current_group_id bigint, new_tax_id bigint)
returns numeric(120, 10) as $$
    declare
        old_consumption numeric(120, 10) := 0.0;
        new_consumption numeric(120, 10) := 0.0;
    begin
        old_consumption := old_consumption +
                (select total * (
                    select price_day_buy_value
                    from "group" join tax t on t.tax_id = "group".tax_id
                    where "group".group_id  = current_group_id
                )
                from (
                         select sum(power_value) as total
                         from consumer
                                  join consumer_x_consumption_measur cxcm
                                       on consumer.consumer_id = cxcm.consumer_id
                                  join consumption_measurement cm
                                       on cxcm.consumption_measurement_id = cm.consumption_measurement_id
                         where consumer.group_id = current_group_id
                           and extract(hour from timestamp_dttm) between 7 and 23
                     ) as total_table);

        old_consumption := old_consumption +
                (select total * (
                    select price_night_buy_value
                    from "group" join tax t on t.tax_id = "group".tax_id
                    where "group".group_id  = current_group_id
                )
                 from (
                          select sum(power_value) as total
                          from consumer
                                   join consumer_x_consumption_measur cxcm
                                        on consumer.consumer_id = cxcm.consumer_id
                                   join consumption_measurement cm
                                        on cxcm.consumption_measurement_id = cm.consumption_measurement_id
                          where consumer.group_id = current_group_id
                            and (extract(hour from timestamp_dttm) between 0 and 7
                                     or extract(hour from timestamp_dttm) between 23 and 24)
                      ) as total_table);

        old_consumption := old_consumption -
                           (select total * (
                               select price_day_sell_value
                               from "group" join tax t on t.tax_id = "group".tax_id
                               where "group".group_id  = current_group_id
                           )
                            from (
                                     select sum(power_value) as total
                                     from solar_panel
                                        join solar_panel_x_production_measur spxpm
                                            on solar_panel.solar_panel_id = spxpm.solar_panel_id
                                        join production_measurement pm
                                            on spxpm.production_measurement_id = pm.production_measurement_id
                                     where solar_panel.group_id = current_group_id
                                       and extract(hour from timestamp_dttm) between 7 and 23
                                 ) as total_table);



        new_consumption := new_consumption +
                           (select total * (
                               select price_day_buy_value
                               from tax
                               where tax_id = new_tax_id
                           )
                            from (
                                     select sum(power_value) as total
                                     from consumer
                                              join consumer_x_consumption_measur cxcm
                                                   on consumer.consumer_id = cxcm.consumer_id
                                              join consumption_measurement cm
                                                   on cxcm.consumption_measurement_id = cm.consumption_measurement_id
                                     where consumer.group_id = current_group_id
                                       and extract(hour from timestamp_dttm) between 7 and 23
                                 ) as total_table);

        new_consumption := new_consumption +
                           (select total * (
                               select price_night_buy_value
                               from tax
                               where tax_id = new_tax_id
                           )
                            from (
                                     select sum(power_value) as total
                                     from consumer
                                              join consumer_x_consumption_measur cxcm
                                                   on consumer.consumer_id = cxcm.consumer_id
                                              join consumption_measurement cm
                                                   on cxcm.consumption_measurement_id = cm.consumption_measurement_id
                                     where consumer.group_id = current_group_id
                                       and (extract(hour from timestamp_dttm) between 0 and 7
                                         or extract(hour from timestamp_dttm) between 23 and 24)
                                 ) as total_table);

        new_consumption := new_consumption -
                           (select total * (
                               select price_day_sell_value
                               from tax
                               where tax_id = new_tax_id
                           )
                            from (
                                     select sum(power_value) as total
                                     from solar_panel
                                              join solar_panel_x_production_measur spxpm
                                                   on solar_panel.solar_panel_id = spxpm.solar_panel_id
                                              join production_measurement pm
                                                   on spxpm.production_measurement_id = pm.production_measurement_id
                                     where solar_panel.group_id = current_group_id
                                       and extract(hour from timestamp_dttm) between 7 and 23
                                 ) as total_table);
        return new_consumption - old_consumption;
    end;
$$ language plpgsql;

--------------------------------------------------------------------------------

-- Процедура, которая осуществляет вставку нового показания датчика с id = current_sensor потребителя consumer_type
-- во время measure_time с параметром мощности power
create or replace procedure add_consumer_measurement_with_type(current_sensor bigint,
                                                               measure_time timestamp(0),
                                                               consumer_type text,
                                                               power numeric(20, 2))
    language plpgsql
as $$
declare
    measurement_new_id bigint;
    current_group_id bigint;
    current_consumer_id bigint;
begin
    measurement_new_id :=
            (select nextval(pg_get_serial_sequence('consumption_measurement',
                                                   'consumption_measurement_id')));

    current_group_id :=
            (select group_id from sensor where sensor_id = current_sensor);

    current_consumer_id :=
            (select consumer_id from consumer where group_id = current_group_id and consumer_type_nm = consumer_type);

    insert into consumption_measurement (consumption_measurement_id, sensor_id, timestamp_dttm, power_value)
    values (measurement_new_id, current_sensor, measure_time, power);

    commit;

    insert into consumer_x_consumption_measur (consumer_id, consumption_measurement_id)
    values (current_consumer_id, measurement_new_id);
end;
$$;

--------------------------------------------------------------------------------

-- Функция, которая возрващает триггер на изменение значений power_day_amt и power_night_amt у
-- потребителя с id = consumer_id основываясь на показаниях с id = consumption_measurement_id
-- при вставке в таблицу consumer_x_consumption_measur
create or replace function update_power_amt() returns trigger as $$
    declare
        current_hour int;
    begin
        current_hour := extract(hour from (
                select timestamp_dttm
                from consumption_measurement
                where consumption_measurement_id = new.consumption_measurement_id
        ));

        if current_hour between 7 and 23 then
            update consumer
            set power_day_amt = consumer.power_day_amt + (
                    select power_value
                    from consumption_measurement
                    where consumption_measurement.consumption_measurement_id = new.consumption_measurement_id
                )
            where consumer_id = new.consumer_id;
        else
            update consumer
            set power_night_amt = consumer.power_night_amt + (
                    select power_value
                    from consumption_measurement
                    where consumption_measurement.consumption_measurement_id = new.consumption_measurement_id
                )
            where consumer_id = new.consumer_id;
        end if;

        return new;
    end;
    $$ language plpgsql;

-- Создаём триггер
create trigger new_consumption_measurement_trigger
    after insert on consumer_x_consumption_measur
    for row execute procedure update_power_amt();

--------------------------------------------------------------------------------

-- Функция, которая возвращает триггер на изменение err_flag у
-- потребителя с id = consumer_id основываясь на показаниях с id = consumption_measurement_id
-- при вставке в таблицу consumer_x_consumption_measur
create or replace function update_err_flag() returns trigger as $$
    begin
        if ((
                select power_value
                from consumption_measurement
                where consumption_measurement.consumption_measurement_id = new.consumption_measurement_id
            ) > (
                select max_power_value
                from consumer
                where consumer_id = new.consumer_id
            )) then
                update consumer
                set error_flg = true
                where consumer_id = new.consumer_id;
        end if;

        return new;
    end;
    $$ language plpgsql;

create trigger consumption_measurement_check_err_trigger
    after insert on consumer_x_consumption_measur
    for row execute procedure update_err_flag();

--------------------------------------------------------------------------------

-- Проверка работы функций и триггеров

call add_consumer_measurement_with_type(5::bigint,
                            '2020-05-09'::timestamp, 'bulb'::text, 900.0);

select calculate_profit(3, 5);


