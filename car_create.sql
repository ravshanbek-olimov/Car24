
-- drop table if exists investor cascade;
-- drop table if exists modul cascade;

create table investor (
    investor_id serial primary key,
    name varchar(22)
);

create table modul (
    modul_id serial not null primary key,
    modul_name varchar(24)
);

create table add_tariff (
    add_tariff_id serial primary key,
    name varchar(24) not null,
    price numeric not null
);

create table order_payment (
    order_payment_id serial primary key,
    total_price numeric not null,
    add_tariff_price numeric,
    investor numeric not null,
    company numeric not null,
    insurance numeric not null
);
