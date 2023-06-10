use movies;

-- Task 1.1
insert into moviestar(name, gender, birthdate)
values ('Nicole Kidman', 'F' ,'1967-06-20');

-- Task 1.2
delete from movieexec
where networth < 10000000;

-- Task 1.3
delete from moviestar
where address is null;

-- Task 1.4
update movieexec
set name = 'Pres.' + name
where cert# in (select presc# from studio);

use pc;

-- Task 2.1
insert into product
values ('1100', 'C', 'PC');

insert into pc
values (12, '1100', 2400, 2048, 500, '52x', 300);

-- Task 2.2
delete from product
where type = 'PC' and model = '1100';

delete from pc
where model = '1100';

-- Task 2.3
insert into laptop
select code + 100, model, speed, ram, hd, price + 500, 15
from pc;

-- Task 2.4
delete from laptop
where code in (select code from laptop 
				join product on laptop.model = product.model
				where maker not in 
								(select maker from product where type = 'Printer'));
-- another solution
delete from laptop
WHERE model IN ( SELECT model 
		         FROM product 
                 WHERE type='Laptop' AND
 		         maker NOT IN (SELECT maker
	                           FROM product
		                       WHERE type='Printer'));

-- Task 2.5
update product
set maker = 'A'
where maker = 'B';

-- Task 2.6
update pc
set price = price / 2, hd = hd + 20;

-- Task 2.7
update laptop
set screen = screen + 1
where model in (select model from product where maker = 'B');

use ships;

-- Task 3.1
insert into classes 
values ('Nelson', 'bb', 'Gr. Britain', 9, 16, 34000);

insert into ships
values ('Nelson', 'Nelson', 1927);

insert into ships
values ('Rodney', 'Nelson', 1927);

-- Task 3.2
delete from ships
where name in (select ship from outcomes where result = 'sunk');

-- Task 3.3
update classes
set bore = bore * 2.54, displacement = displacement / 1.1;

-- Task 3.4
delete from classes
where class not in (select class from ships
					group by class
					having count(*) >= 3);

-- Task 3.5
begin transaction;
select * from classes;

update classes
set bore = (select bore from classes where class = 'Bismarck'),
	displacement = (select displacement from classes where class = 'Bismarck')
where class = 'Iowa';

select * from classes;
rollback;
