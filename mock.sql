alter table car add column investor_id int references investor(investor_id);
alter table car add column investor_percentage int;
alter table car alter column investor_percentage set not null;

insert into investor (name)
values
('Akbar'),
('Kamoliddin'),
('Farrux');

update car set investor_id = 1 where car_id = 1;
update car set investor_id = 1 where car_id = 2;
update car set investor_id = 2 where car_id = 3;
update car set investor_id = 3 where car_id = 4;
update car set investor_id = 3 where car_id = 5;

insert into modul (modul_name) values
('Malibu'),
('Tracker'),
('Cobalt'),
('Onix'),
('Nexia');

alter table car add column modul_id int references modul(modul_id);
alter table car alter column modul_id set not null;

update car set modul_id = 1 where car_id = 1;
update car set modul_id = 2 where car_id = 2;
update car set modul_id = 3 where car_id = 3;
update car set modul_id = 4 where car_id = 4;
update car set modul_id = 5 where car_id = 5;

alter table car add column insurance numeric;
alter table car alter column insurance set not null;


insert into add_tariff (name, price)
values
('Haydovchi', 300000),
('Anti-Radar', 40000),
('Serena', 30000);

alter table orders add column add_tariff_price_day numeric;
alter table orders add column total_price numeric;
alter table orders alter column total_price set not null;
alter table orders add column is_paid integer default 0;


insert into orders (
    price,
    status,
    car_id,
    client_id,
    day_count,
    add_tariff_price_day,
    total_price
) values 
(
    (
        select 
        day_price + 340000 + 30000 
        from car where car_id = 1
    ),
    'new',
    1,
    1,
    4,
    340000,
    (
        select (day_price + 340000 + 30000) * 4 
        from car where car_id = 1
    )
)


update orders set is_paid = 0 where order_id = 5;
update orders set is_paid = 1 where order_id = 5;

