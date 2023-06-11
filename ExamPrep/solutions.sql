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


/*
Да се напише изглед, който намира имената на всички актьори, 
играли във филми с дължина под 120 минути или с неизвестна дължина.
*/
use movies;

go
create view stars
as
select distinct starname
from starsin
left join movie on movietitle = title and movieyear = year
where length < 120 or length is null
go
select * from stars;

/*
Да се направи възможно изтриването на редове в изгледа. 
При изпълнение на delete заявка върху stars 
да се изтриват съответните редове от starsin.
*/
go
create trigger starDelete
on stars
instead of delete
as
	delete from starsin
	where starname in (select starname from deleted);
go
drop trigger starDelete;
drop view stars;

/*
Да се изтрият всички участия на филмови звезди (редове в StarsIn) във филми, 
чието заглавие започва със Star, но само ако не са играли във филми, 
незапочващи със Star.
*/
select * from starsin
where movietitle like 'Star%' 
		and starname not in (select starname from starsin
							where movietitle not like 'Star%');

use pc;
/*
Да се изтрият всички компютри, произведени от производител, който не
произвежда цветни принтери. 
*/
delete from pc
where model in (select model from product
				where maker not in (select maker from printer
									join product on printer.model = product.model
									where color = 'y'));

/*
а) да се създаде изглед, който показва кодовете, моделите, процесорите, 
RAM паметта, харддиска и цената на всички PC-та и лаптопи. 
Да има допълнителна колона, която указва типа на продукта - PC или Laptop.
б) да се направи възможно изпълнението на DELETE заявки върху този изглед
*/
go
create view computers
as
	(select code, 'PC' as type, model, speed, ram, hd, price
	from pc)
	union
	(select code, 'Laptop' as type, model, speed, ram, hd, price
	from laptop);
go

create trigger deleteComp
on computers
instead of delete
as
	delete from pc
	where code in (select code from deleted where type = 'pc');

	delete from laptop
	where code in (select code from deleted where type = 'laptop');
go
drop view computers;

