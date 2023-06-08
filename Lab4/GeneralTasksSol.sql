use ships;

-- Task 1
select name, launched
from ships
where name = class;

use movies;

-- Task 2
select *
from movie
where title like '%Star%' and title like '%Trek%'
order by year desc, title;

-- Task 3
select distinct movietitle, movieyear
from starsin
join moviestar on starname = name
where birthdate between '1.1.1970' and '1.7.1980';

use ships;

-- Task 4
select distinct name
from ships
join outcomes on name = ship
where name like 'C%' or name like 'K%';

-- Task 5
select distinct country
from ships
join classes on ships.class = classes.class
join outcomes on ships.name = outcomes.ship
where result = 'sunk';

-- Task 6
select distinct country
from classes

except

select distinct country
from ships
join classes on ships.class = classes.class
join outcomes on ships.name = outcomes.ship
where result = 'sunk';

-- Task 7
select classes.class
from classes
where class not in (select class from ships where launched >= 1921);

-- Task 8
select class, country, bore * 2.54 as bore_cm
from classes
where numguns in (6, 8, 10);

-- Task 9
select distinct country
from classes c1
where bore != any (select bore from classes c2 where c1.country = c2.country);

-- Task 10
select distinct country
from classes
where numguns >= all (select numguns from classes);

use pc;

-- Task 11
select *
from pc
join product p1 on pc.model = p1.model
where price < all (select price from laptop 
					join product p2 on laptop.model = p2.model
					where p1.maker = p2.maker);

-- Task 12
select *
from pc
join product p1 on pc.model = p1.model
where price < all (select price from laptop 
					join product p2 on laptop.model = p2.model
					where p1.maker = p2.maker)
and price < all (select price from printer 
					join product p2 on printer.model = p2.model
					where p1.maker = p2.maker);