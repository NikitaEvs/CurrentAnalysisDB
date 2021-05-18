set search_path to current_analysis;

-- Найти id и типы потребителей, у которых наблюдалась мощность
-- больше их максимального значения
select distinct consumer.consumer_id, consumer.consumer_type_nm
from consumer
    join consumer_x_consumption_measur cxcm
        on consumer.consumer_id = cxcm.consumer_id
    join consumption_measurement cm
        on cxcm.consumption_measurement_id = cm.consumption_measurement_id
where power_value > consumer.max_power_value;

-- Вывести группы в порядке убывания разницы в максимально возможных
-- параметрах генерации и потребления всех устройств в сети группы
select group_id,
       sum(produced_val) - sum(consumed_val) as power_difference
from (
         select c.group_id,
                max_power_value as consumed_val,
                0 as produced_val
         from "group"
                  join consumer c
                       on "group".group_id = c.group_id
         union all
         select sp.group_id,
                0 as consumed_val,
                max_power_value as produced_val
         from "group"
                  join solar_panel sp
                       on "group".group_id = sp.group_id
     ) as grouping
group by group_id
order by power_difference desc;


-- Выясним, сможем ли мы обеспечить стоимость бесперерывной работы всех потребителей в группе, если 12 часов в день
-- солнечные панели будут на максимальноей мощности и выведем разницу в деньгах при таком раскладе
select group_id,
       sum(produced_val * tax.price_day_sell_value / 2.0
               - consumed_val * (tax.price_day_buy_value + tax.price_night_buy_value) / 2.0
        ) as profit
from (
         select c.group_id, tax_id,
                max_power_value as consumed_val,
                0 as produced_val
         from "group"
                  join consumer c
                       on "group".group_id = c.group_id
         union all
         select sp.group_id, tax_id,
                0 as consumed_val,
                max_power_value as produced_val
         from "group"
                  join solar_panel sp
                       on "group".group_id = sp.group_id
     ) as grouped join tax on tax.tax_id = grouped.tax_id
group by group_id
order by profit desc;


-- Выясним, датчики от каких компаний чаще фиксируют превышение заявленной мощности для солнечных панелей
-- Выведем список компаний и число превышений для солнечных панелей
select company_nm, count(*) as number_of_problem
from (
         select distinct spxpm.solar_panel_id, sensor_id
         from solar_panel
                  join solar_panel_x_production_measur spxpm
                       on solar_panel.solar_panel_id = spxpm.solar_panel_id
                  join production_measurement pm
                       on spxpm.production_measurement_id = pm.production_measurement_id
        where (power_value > solar_panel.max_power_value)
     ) as solar_with_measure
join sensor on solar_with_measure.sensor_id = sensor.sensor_id
join company c on sensor.company_id = c.company_id
group by company_nm
order by number_of_problem desc;


-- Выведем для каждого типа прибора разницу между максимальным потреблением у пользователей и минимальным
select consumer_type_nm, max(power_value) - min(power_value) as difference
from consumer
    join consumer_x_consumption_measur cxcm
        on consumer.consumer_id = cxcm.consumer_id
    join consumption_measurement cm
        on cm.consumption_measurement_id = cxcm.consumption_measurement_id
group by consumer_type_nm;

