use movies;

-- Task 1.1.
select title, year, name, address
from movie
join studio on studioname = name
where length > 120;

-- Task 1.2.
select distinct studioname, starname
from movie 
join starsin on title = movietitle and year = movieyear
order by studioname;

-- Task 1.3.
select distinct name
from movieexec
join movie on cert# = producerc#
join starsin on movietitle = title
where starname = 'Harrison Ford';

-- Task 1.4.
select distinct starname
from starsin
join movie on title = movietitle
join moviestar on name = starname
where gender = 'F' and studioname = 'MGM';

-- Task 1.5.
select name, title
from movieexec
join movie on cert# = producerc#
where name in (select distinct name 
				from movieexec
				join movie on cert# = producerc#
				where title = 'Star Wars')

-- Task 1.6.
select name
from moviestar
left join starsin on name = starname
where movietitle is null;

use pc;

-- Task 2.1.
select distinct product.model, price
from product
left join pc on product.model = pc.model
where type = 'PC';

-- Task 2.2.
select distinct product.model, product.maker, product.type
from product
left join printer on printer.model = product.model
left join pc on pc.model = product.model
left join laptop on laptop.model = product.model
where (product.type = 'Printer' and printer.price is null) or 
		(product.type = 'PC' and pc.price is null) or
		(product.type = 'Laptop' and laptop.price is null);

-- another solution
select maker, model, type
from product
where model not in (select model from pc) and 
	model	not in (select model from printer) and
	model		not in (select model from laptop);

use ships;

-- Task 3.1.
select name, country, numguns, launched 
from ships
left join classes on classes.class = ships.class;

-- Task 3.2.
select ship 
from outcomes
join battles on battles.name = outcomes.battle
where year(battles.date) = 1942;