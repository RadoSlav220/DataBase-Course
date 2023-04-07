use movies;

--select title, year, studioname
--from movie;

/*
select title, year, studioname, address
from movie, studio
where studioname = name
	and incolor = 'y';
*/

select title, year, studioname, address
from movie
join studio ON studioname = name
where incolor = 'y';



