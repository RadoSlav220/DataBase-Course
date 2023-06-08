use pc;

-- Task 1.1
select avg(speed) as averageSpeed
from pc;

-- Task 1.2
select maker, avg(screen) as averageScreen
from product
join laptop on product.model = laptop.model
group by maker;

-- Task 1.3
select avg(speed) as averageSpeed
from laptop
where price > 1000;

-- Task 1.4
select avg(price) as averagePrice
from product
join pc on product.model = pc.model
where maker = 'A';

-- Task 1.5
select avg(price) as averagePrice
from 
((select price 
from pc
join product on pc.model = product.model
where maker = 'B')

UNION ALL

(select price 
from laptop
join product on laptop.model = product.model
where maker = 'B')) prices;

-- Task 1.6
select speed, avg(price) as averagePrice
from pc
group by speed;

-- Task 1.7
select maker
from product
where type='PC'
group by maker
having count(*) >= 3;

-- Task 1.8
select distinct maker
from product 
join pc on product.model = pc.model
where price = (select max(price) from pc); 

-- Task 1.9
select speed, avg(price)
from pc
group by speed
having speed > 800;

-- Task 1.10
select avg(hd) as averageSize
from pc
join product on pc.model = product.model
where maker in (select maker
				from product
				where type='Printer');

-- Task 1.11
select screen, max(price) - min(price) as priceDiff
from laptop
group by screen;

use ships;

-- Task 2.1
select count(*) as classesCount
from classes;

-- Task 2.2
select avg(numguns) as averageNumguns
from ships
join classes on ships.class = classes.class;

-- Task 2.3
select classes.class, min(launched) as First, max(launched) as Last
from classes
left join ships on classes.class = ships.class
group by classes.class;

-- Solution if we don't want to display classes with no ships
select class, min(launched) as FirstYear, max(launched) as LastYear
from ships
group by class;

-- Task 2.4
select class, count(*) as sunk
from ships
join outcomes on ships.name = outcomes.ship
where result = 'sunk'
group by class;

-- Task 2.5
select class, count(*) as sunk
from ships
join outcomes on ships.name = outcomes.ship
where result = 'sunk' and class in (select class from ships group by class having count(*) > 4)
group by class;

-- Task 2.6
select country, avg(displacement) as averageDisplacement
from classes
group by country;

use movies;

-- Task 3.1
select starname, count(distinct studioname) as studiosCount
from starsin
join movie on movietitle = title and movieyear = year
group by starname;

-- Task 3.2
select name, count(distinct studioname) as studiosCount
from moviestar
left join starsin on name = starname
left join movie on movietitle = title and movieyear = year
group by name;

-- Task 3.3
select starname
from starsin
where movieyear > 1990
group by starname
having count(*) >= 3;

use pc;

-- Task 3.4
select model
from pc
group by model
order by max(price);


