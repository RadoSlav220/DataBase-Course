use movies;

-- Task 1.1
select name
from MOVIESTAR
join STARSIN on name = STARNAME
where GENDER = 'F' and MOVIETITLE = 'Terms of Endearment'; 

-- Task 1.2
select distinct starname
from STARSIN
join movie on MOVIETITLE = TITLE and MOVIEYEAR = YEAR
where STUDIONAME = 'MGM' and YEAR = 1995


use pc;

-- Task 2.1
select distinct maker, speed
from product
join laptop on product.model = laptop.model
where hd >= 9;

-- Task 2.2
(select laptop.model, price
from laptop
join product on product.model = laptop.model
where maker = 'B')
union
(select printer.model, price
from printer
join product on product.model = printer.model
where maker = 'B')
union
(select pc.model, price
from pc
join product on product.model = pc.model
where maker = 'B')
order by price desc;

-- Task 2.3
select distinct p1.hd
from pc p1, pc p2
where p1.hd = p2.hd and p1.code != p2.code;

-- Task 2.4
select distinct p1.model, p2.model
from pc p1
join pc p2 on p1.speed = p2.speed and p1.ram = p2.ram
where p1.model < p2.model;

-- Task 2.5
select distinct maker
from product
join pc pc1 on product.model = pc1.model
join pc pc2 on product.model = pc2.model
where pc1.code != pc2.code and pc1.speed >= 500 and pc2.speed >= 500;


use ships;

-- Task 3.1
select name
from ships
join classes on classes.CLASS = ships.CLASS
where DISPLACEMENT > 35000;

-- Task 3.2
select name, DISPLACEMENT, numguns
from ships
join classes on classes.class = ships.class
join outcomes on outcomes.ship = ships.name
where battle = 'Guadalcanal';

-- Task 3.3
(select country
from classes
where type = 'bb')
INTERSECT
(select country
from classes
where type = 'bc');

-- Task 3.4
select distinct o1.ship
from outcomes o1
join battles b1 on b1.name = o1.battle
join outcomes o2 on o1.ship = o2.ship
join battles b2 on b2.name = o2.battle
where o1.result = 'damaged' and b1.date < b2.date;