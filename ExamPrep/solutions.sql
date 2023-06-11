use ships;

-- Task 1
select name, (select count(*) from outcomes where ship = name and result = 'ok') as OK,
			(select count(*) from outcomes where ship = name and result = 'damaged') as Damaged,
			(select count(*) from ships 
			join classes on ships.class = classes.class
			where displacement = c.displacement) as SameDispl, DISPLACEMENT
from ships s
join classes c on s.class = c.class
where displacement < 64000;


use pc;

-- Task 2
go
create view zad2
as
	(select code, 'PC' as type, model, price
	from pc
	where price > 600)
	union
	(select code, 'Laptop' as type, model, price
	from laptop
	where price > 600)
go
select * from zad2;
drop view zad2;

use ships;

-- Task 3
go
create trigger tr
on ships
after insert, update
as
	if exists (select * from ships
				join classes on ships.class = classes.class
				where launched > 1944 and numguns < 10)
	rollback;
go
drop trigger tr;

-- Task 4
select * from outcomes
where ship in (select name from ships
				join classes on ships.class = classes.class
				where country = 'USA' and numguns > 10)
		or ship in (select name from ships
					join classes on ships.class = classes.class
					join outcomes on name = ship
					where country = 'Gt.Britain'
					group by name
					having count(*) > 3);

