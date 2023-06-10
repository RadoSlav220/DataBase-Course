use movies;

-- Task 1.1
select case
			when year(birthdate) < 1960 then 'before 60s'  
			when year(birthdate) < 1970 then '60s'
			when year(birthdate) < 1980 then '70s'
			else 'during after 80s'
	   end as period, count(*) as count
from moviestar
group by case
			when year(birthdate) < 1960 then 'before 60s'  
			when year(birthdate) < 1970 then '60s'
			when year(birthdate) < 1980 then '70s'
			else 'during after 80s'
		 end;

use ships;

-- Task 2.1
select battle
from outcomes
join ships on ship = name
join classes on ships.class = classes.class
where numguns < 9
group by battle
having count(*) >= 3 and sum(case result when 'ok' then 1 else 0 end) >= 2;


					