use movies;

-- Task 1.1
insert into moviestar 
values('Bruce Willis', 'somewhere', 'M', '1955-03-19');

go
create trigger tr11
on movie
after insert
as
	insert into starsin (movietitle, movieyear, starname)
	select title, year, 'Bruce Willis'
	from inserted
	where title like '%save%' or title like '%world%';
go

drop trigger tr11;
delete from moviestar
where name = 'Bruce Willis';

-- Task 1.2
go
create trigger tr12
on movieexec
after insert, update, delete
as
    if (select AVG(networth)
        from movieexec) < 500000 or (select count(*) from MOVIEEXEC) = 0
        rollback;
go
drop trigger tr12;

-- Task 1.3
go
create trigger tr3
on movieexec
instead of delete
as
begin
	update movie 
	set PRODUCERC# = null
	where PRODUCERC# in (select cert# from deleted);

	delete from movieexec
    where cert# in (select cert# from deleted);
end;
go
drop trigger tr13;

-- Task 1.4
go
create trigger tr4
on starsin
instead of insert
as
begin
	insert into movie (title, year)
	select distinct movietitle, movieyear
	from inserted
	where not exists (select * from movie 
						where title = movietitle and year = movieyear);

	insert into moviestar (name)
	select distinct starname
	from inserted
	where starname not in (select name from moviestar);

	insert into starsin
	select * from inserted;
end;
go
drop trigger tr14;

use pc;

-- Task 2.1
go
create trigger tr21
on laptop
after delete
as
	insert into pc
	select code + 100, '1121', speed, ram, hd, '52x', price
	from deleted
	where model in (select model
					from product 
					where maker = 'D');
go
drop trigger tr21;

-- Task 2.2
go
create trigger tr22
on pc
after update
as
	if exists (select * from pc p
				where exists (select * from pc 
								where price < p.price and speed = p.speed)
					  and code in (select code from deleted
									join inserted on deleted.code = inserted.code
									where inserted.price != deleted.price)) 
	rollback;
go
drop trigger tr22;

-- Task 2.3
go
create trigger tr23
on product
after insert, update
as
	if exists (select * from inserted 
				where type = 'PC' and maker in (select maker from product
												where type = 'Printer'))
	rollback;
go
drop trigger tr23;

-- Task 2.4
go
create trigger tr24
on product
after insert, update
as
	if exists (select * from pc p
				join product on p.model = product.model
				where maker not in (select maker from laptop
									join product on laptop.model = product.model
									where speed >= p.speed))
	rollback;
go
drop trigger tr24;

-- Task 2.5
go
create trigger tr25
on laptop
after insert, update, delete
as
	if exists (select maker from product
				left join laptop on product.model = laptop.model
				where type = 'laptop'
				group by maker
				having avg(price) < 2000)
	rollback;
go
drop trigger tr25;

-- Task 2.6
go
create trigger tr26
on laptop
after insert, update
as
	if exists (select * from laptop lap
				where exists (select * from pc p
								where lap.ram > p.ram and lap.price < p.price))
	rollback;
go
drop trigger tr26;

-- Task 2.7
go
create trigger tr27
on printer
instead of insert
as
	insert into printer
	select * from inserted
	where color != 'y' or type != 'Matrix';
go
drop trigger tr27;

use ships;

-- Task 3.1
go
create trigger tr31
on classes
instead of insert 
as
	insert into classes
	select * from inserted
	where displacement <= 35000;

	insert into classes
	select class, type, country, numguns, bore, 35000
	from inserted
	where displacement > 35000;
go
drop trigger tr31

-- Task 3.2
go
create view v32
as
	select class, count(*) as shipsCount
	from ships
	group by class;
go
select * from v32;

go
create trigger tr32
on v32
instead of delete
as
	delete from outcomes
	where ship in (select name from ships 
					where class in (select class from deleted));

	delete from ships
	where class in (select class from deleted);
	
	delete from classes
	where class in (select class from deleted);
go

drop trigger tr32;
drop view v32;

-- Task 3.3
go
create trigger tr33
on ships
after insert, update
as
	if exists (select class from ships
				group by class
				having count(*) > 2)
	rollback;
go
drop trigger tr33;

-- Task 3.4
go
create trigger tr34
on outcomes
after insert, update
as
	if exists (select * from outcomes o1
				join ships on ship = name
				join classes on ships.class = classes.class
				where numguns > 9 
				and exists (select ship from outcomes o2
							join ships on ship = name
							join classes on ships.class = classes.class
							where numguns < 9 and o1.battle = o2.battle))
	rollback;
go
drop trigger tr34;

-- Task 3.5
go
create trigger tr351
on outcomes
after insert, update
as
	if exists (select ship from outcomes o
				join battles b on name = battle
				where result = 'sunk' 
						and ship in (select ship from outcomes
									join battles bat on name = battle
									where date > b.date))
	rollback;
go

go
create trigger tr352
on battles
after update
as
	if exists (select ship from outcomes o
				join battles b on name = battle
				where result = 'sunk' 
						and ship in (select ship from outcomes
									join battles bat on name = battle
									where date > b.date))
	rollback;
go

drop trigger tr351, tr352;


