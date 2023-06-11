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




