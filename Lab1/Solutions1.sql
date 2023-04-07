use ships;

-- Task 3.1
/*
select class, country
from classes
where NUMGUNS < 10;
*/

-- Task 3.2
/*
select name as shipName
from ships
where LAUNCHED < 1918
*/

-- Task 3.3
/*
select ship, battle
from OUTCOMES
where result = 'sunk';
*/

-- Task 3.4
/*
select name
from ships
where name = class;
*/

-- Task 3.5
/*
select name
from ships
where name like 'R%';
*/

-- Task 3.6
select name
from ships
where name like '_% _%'
		and name not like '_% _% _%';

