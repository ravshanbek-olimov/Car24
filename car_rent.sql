

-- car status
    -- - in_stock
    -- - in_booked
    -- - in_use

create table car (
    car_id serial primary key,
    state_number varchar,
    status varchar default 'in_stock',
    created_at timestamp default current_timestamp,
    updated_at timestamp
);

create table client (
    client_id serial primary key,
    name varchar
);

-- order status
    -- - new
    -- - client_took
    -- - client_returned

create table orders (
    order_id serial primary key,
    price decimal,
    status varchar not null,
    car_id int not null references car(car_id),
    client_id int not null references client(client_id),
    created_at timestamp default current_timestamp
);

create or replace function trigger_order_status() returns trigger language plpgsql
as
$$
    begin

        if new.status = 'new' then
            update car set 
                status = 'in_booked',
                updated_at = now()
            where car_id = new.car_id;
        elsif old.status = 'new' and new.status = 'client_took' then
            update car set
                status = 'in_use',
                updated_at = now()
            where car_id = new.car_id;
        elsif old.status = 'client_took' and new.status = 'client_returned' then
            update car set 
                status = 'in_stock',
                updated_at = now()
            where car_id = new.car_id;
        end if;

        return new;
    end;
$$;

create trigger trigger_orders
after insert or update on orders
for each row execute procedure trigger_order_status();



insert into car (state_number, status, updated_at) values
('01 A 111 AA', 'in_stock', now()),
('01 W 556 PB', 'in_stock', now()),
('11 111 YYY', 'in_stock', now()),
('77 Z 777 ZZ', 'in_stock', now()),
('01 G 900 MA', 'in_stock', now());

insert into client (name) values
('Samandar'),
('Moxirbek'),
('Jahongir');

insert into orders (status, car_id, client_id) values
('new', 4, 1),
('new', 5, 2),
('new', 1, 3);


update orders set
    price = 1000000,
    status = 'client_took'
where order_id = 3;


update orders set
    status = 'client_returned'
where order_id = 3;

