use ships;
-- Demo
GO
CREATE VIEW v_Classes_Ships
AS
 SELECT c.class as classA, type, country, s.class as classB
 FROM classes c
 JOIN ships s ON c.class = s.class;
GO
drop view v_Classes_Ships;

begin transaction;
use movies;

-- Task 1.1
GO
create view actresses_data
as
	select name, birthdate
	from moviestar
	where gender = 'F';
GO
select * from actresses_data;

-- Task 1.2
GO
create view movieStarData
as
	select name, sum (case when movietitle is null then 0 else 1 end) as moviesCount
	from moviestar
	left join starsin on name = starname
	group by name;
GO
select * from movieStarData;

use pc;

-- Task 2.1
GO
create view productsData
as
	(select code, model, price
	from laptop)
	union all
	(select code, model, price
	from printer)
	union all
	(select code, model, price
	from pc);
GO
select * from productsData;

-- Task 2.2 / 2.3
GO
alter view productsData
as
	(select code, model, price, speed, 'Laptop' as type
	from laptop)
	union all
	(select code, model, price, null, 'Printer' as type
	from printer)
	union all
	(select code, model, price, speed, 'PC' as type
	from pc);
GO
select * from productsData;

use ships;

-- Task 3.1
GO
create view BritishShips
as
	select name, classes.class, type, numguns, bore, displacement, launched
	from classes
	join ships on classes.class = ships.class
	where country = 'Gt.Britain';
GO

select * from BritishShips;

-- Task 3.2
select name, numguns, displacement
from BritishShips
where type = 'bb' and launched < 1919;

-- Task 3.3
select name, numguns, displacement
from classes
join ships on classes.class = ships.class
where country = 'Gt.Britain' and type = 'bb' and launched < 1919;

-- Task 3.4
select avg(maxDispl) as averageMaxDispl
from 
(select country, max(displacement) as maxDispl
from classes
group by country) maxValues;

-- Task 3.5
go
create view sunkShips
as
	select battle, ship
	from outcomes
	where result = 'sunk';
go

-- Task 3.6
--insert into sunkShips
--values ('California', 'Guadalcanal');

-- Task 3.7
go
create view manyGunsClasses 
as
	select class, numguns
	from classes
	where numguns >= 9
	with check option;
go
select * from manyGunsClasses;

update manyGunsClasses
set numguns = 9
where class = 'Iowa';

select * from manyGunsClasses;
select * from classes;

-- Task 3.9
go
create view desiredBattles
as
	select battle, count(*) as shipCount
	from outcomes
	join ships on ship = name
	join classes on classes.class = ships.class
	where numguns <= 9
	group by battle
	having count(*) >= 3 and sum(case result when 'damaged' then 1 else 0 end) > 0;
go
select * from desiredBattles;
drop view desiredBattles;
rollback;
