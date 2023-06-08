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
					