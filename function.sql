
create or replace function order_payment_share () returns trigger language plpgsql
as
$$
    declare
        car_data record;

    begin

        if old.is_paid = 0 and new.is_paid = 1 then

            select * from car into car_data where car_id = new.car_id;

            insert into order_payment (
                total_price,
                add_tariff_price, 
                investor,
                company, 
                insurance
            ) values (
                new.total_price,
                COALESCE(new.add_tariff_price_day, 0) * new.day_count,
                (car_data.day_price * (CAST(car_data.investor_percentage AS float) / 100)) * new.day_count,
                (car_data.day_price * (1 - (CAST(car_data.investor_percentage AS float) / 100))) * new.day_count,
                car_data.insurance * new.day_count
            );

        end if;

        return new;
    end;
$$;


create trigger trigger_order_payment_share
after insert or update on orders
for each row execute procedure order_payment_share();

