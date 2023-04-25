use movies;

-- Task 1.1
select name
from MOVIESTAR
where GENDER = 'F' and
		name in (select name 
				from MOVIEEXEC
				where NETWORTH > 10000000);

-- Task 1.2.
select name
from moviestar
where name not in (select name
					from MOVIEEXEC);

use pc;

-- Task 2.1.
select distinct maker
from product
where model in (select model
				from pc
				where speed >= 500);

-- Task 2.2.
select *
from laptop
where speed < all (select speed
					from pc);

-- Task 2.3.
select distinct model
from ( select model, price
		from laptop
			union
		select model, price
		from printer
			union
		select model, price
		from pc
) everything
where price >= all (select price 
					from laptop
						union
					select price
					from printer
						union
					select price
					from pc);

-- Task 2.4.
select distinct maker
from product
where model in (select model
				from printer
				where color = 'y' and price >= all (select price from printer where color = 'y'));

-- Task 2.5.
select distinct maker
from product
join pc on product.model = pc.model
where speed >= all (select speed from pc)
and ram <= all (select ram from pc where speed >= all (select speed from pc)); 

select distinct maker
from product
where model in (select model
				from pc
				where ram <= all (select ram from pc)
					and speed >= all (select speed
										from pc
										where ram <= all (select ram from pc)));

use ships;

-- Task 3.1.
select distinct country
from classes
where NUMGUNS >= all (select numguns from classes);

-- Task 3.2.
select name
from ships
where class in (select class from classes where bore = 16);

-- Task 3.3.
select battle
from outcomes
where ship in (select name from ships where class = 'Kongo');

-- Task 3.4.
select name
from ships
where class in (select class 
				from classes cl1 
				where numguns >= all (select numguns from classes cl2 where cl1.bore = cl2.bore));

-- another solution
select name
from ships s
join classes c on s.class = c.class
where numguns >= all (select numguns
				from classes c2
				where c2.bore = c.bore);
