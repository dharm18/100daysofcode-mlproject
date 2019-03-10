-- Select all columns from cities
SELECT * from cities;

-- 3. Select fields with aliases
SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
  -- 1. Join to economies (alias e)
  INNER JOIN economies AS e
    -- 2. Match on code
    ON c.code = e.code;
	
	-- 4. Select fields
select code,name,region,year,fertility_rate
  -- 1. From countries (alias as c)
  from countries as c
  -- 2. Join with populations (as p)
  inner join populations as p
    -- 3. Match on country code
    on c.code = p.country_code
	
-- 4. Select fields
select c.name as country,continent,l.name as language,l.official
  -- 1. From countries (alias as c)
  from countries as c
  -- 2. Join to languages (as l)
  inner join languages as l
    -- 3. Match using code
    using(code)
	
	
-- 4. Select fields with aliases
select
p1.country_code,
p2.size as size2015,p1.size as size2010
-- 1. From populations (alias as p1)
from populations as p1
  -- 2. Join to itself (alias as p2)
  inner join populations as p2
    -- 3. Match on country code
    on p1.country_code = p2.country_code
	

SELECT name, continent, code, surface_area,
    -- 1. First case
    CASE WHEN surface_area > 2000000 THEN 'large'
        -- 2. Second case
        WHEN surface_area > 350000 THEN 'medium'
        -- 3. Else clause + end
        ELSE 'small' END
        -- 4. Alias name
        AS geosize_group
-- 5. From table
FROM countries;

SELECT country_code, size,
    -- 1. First case
    CASE WHEN size > 50000000 THEN 'large'
        -- 2. Second case
        WHEN size > 1000000 THEN 'medium'
        -- 3. Else clause + end
        ELSE 'small' END
        -- 4. Alias name
        AS popsize_group
-- 5. From table
FROM populations
-- 6. Focus on 2015
WHERE year = 2015;

-- Select the city name (with alias), the country code,
-- the country name (with alias), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- From left table (with alias)
FROM cities AS c1
  -- Join to right table (with alias)
  INNER JOIN countries AS c2
    -- Match on country code
    ON c1.country_code = c2.code
-- Order by descending country code
ORDER BY code desc;


/*
5. Select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- 1. From left table (alias as c)
FROM countries AS c
  -- 2. Join to right table (alias as l)
  INNER JOIN languages AS l
    -- 3. Match on fields
    ON c.code = l.code
-- 4. Order by descending country
ORDER BY country desc

-- 5. Select name, region, and gdp_percapita
SELECT name, region, gdp_percapita
-- 1. From countries (alias as c)
FROM countries AS c
  -- 2. Left join with economies (alias as e)
  LEFT JOIN economies AS e
    -- 3. Match on code fields
    ON c.code = e.code
-- 4. Focus on 2010
WHERE year = 2010;

-- convert this code to use RIGHT JOINs instead of LEFT JOINs
/*
SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM cities
  LEFT JOIN countries
    ON cities.country_code = countries.code
  LEFT JOIN languages
    ON countries.code = languages.code
ORDER BY city, language;
*/

SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
  RIGHT JOIN countries
    ON countries.code = languages.code
  RIGHT JOIN cities
    ON cities.country_code = countries.code
ORDER BY city, language;


SELECT name AS country, code, region, basic_unit
-- 3. From countries
FROM countries
  -- 4. Join to currencies
  FULL JOIN currencies
    -- 5. Match on code
    USING (code)
-- 1. Where region is North America or null
WHERE region = 'North America' OR region IS null
-- 2. Order by region
ORDER BY region;


SELECT countries.name, code, languages.name AS language
-- 3. From languages
FROM languages
  -- 4. Join to countries
  full JOIN countries
    -- 5. Match on code
    USING (code)
-- 1. Where countries.name starts with V or is null
WHERE countries.name LIKE 'V%' OR countries.name IS null
-- 2. Order by ascending countries.name
ORDER BY countries.name;

-- 7. Select fields (with aliases)
SELECT c1.name AS country, region, l.name AS language,
       basic_unit, frac_unit
-- 1. From countries (alias as c1)
FROM countries AS c1
  -- 2. Join with languages (alias as l)
  FULL JOIN languages  AS l
    -- 3. Match on code
    USING (code)
  -- 4. Join with currencies (alias as c2)
  FULL JOIN currencies AS c2
    -- 5. Match on code
    USING (code)
-- 6. Where region like Melanesia and Micronesia
WHERE region LIKE 'M%esia';


-- 4. Select fields
SELECT c.name AS city, l.name AS language
-- 1. From cities (alias as c)
FROM cities AS c        
  -- 2. Join to languages (alias as l)
  CROSS JOIN languages AS l
-- 3. Where c.name like Hyderabad
WHERE c.name LIKE 'Hyder%';


--Outer challenge
-- Select fields
select c.name as country, region, life_expectancy as life_exp
-- From countries (alias as c)
from countries as c
  -- Join to populations (alias as p)
  left join populations as p
    -- Match on country code
    on c.code = p.country_code
-- Focus on 2010
where year=2010
-- Order by life_exp
order by life_exp
-- Limit to 5 records
limit 5

--UNION
-- Select fields from 2010 table
select *
  -- From 2010 table
  from economies2010
	-- Set theory clause
	union
-- Select fields from 2015 table
select *
  -- From 2015 table
  from economies2015
-- Order by code and year
order by code, year;


-- Select field
select country_code
  -- From cities
  from cities
	-- Set theory clause
	union
-- Select field
select code as country_code
  -- From currencies
  from currencies
-- Order by country_code
order by country_code;

--union all
-- Select fields
SELECT code, year
  -- From economies
  FROM economies
	-- Set theory clause
	union all
-- Select fields
SELECT country_code as code, year
  -- From populations
  FROM populations
-- Order by code, year
ORDER BY code, year;


---intersect

-- Select fields
select code,year
  -- From economies
  from economies
	-- Set theory clause
	intersect
-- Select fields
select country_code as code, year
  -- From populations
  from populations
-- Order by code and year
order by code, year;


-- Select fields
select name 
  -- From countries
  from countries
	-- Set theory clause
	intersect
-- Select fields
select name
  -- From cities
  from cities;
  
---Except

-- Select field
SELECT name
  -- From cities
  FROM cities
	-- Set theory clause
	EXCEPT
-- Select field
SELECT capital as name
  -- From countries
  FROM countries
-- Order by result
ORDER BY name asc;

----Semi-join
-- Select code
select code
  -- From countries
  from countries
-- Where region is Middle East
where region = 'Middle East';

-- Select distinct fields
select distinct name
  -- From languages
  from languages
-- Where in statement
WHERE code IN
  -- Subquery
  (SELECT code
  FROM countries
WHERE region = 'Middle East')
-- Order by name
order by name;

---Diagnosing problems using anti-join
-- Select statement
select count(*)
  -- From countries
  from countries
-- Where continent is Oceania
where continent = 'Oceania';

-------Except (2)  
-- Select field
select capital
  -- From countries
  from countries
	-- Set theory clause
	except
-- Select field
select name as capital
  -- From cities
  from cities
-- Order by ascending capital
order by capital;

-- 5. Select fields (with aliases)
select c1.code,c1.name,basic_unit as currency
  -- 1. From countries (alias as c1)
  from countries as c1
  	-- 2. Join with currencies (alias as c2)
  	inner join currencies as c2
    -- 3. Match on code
    on c1.code = c2.code
-- 4. Where continent is Oceania
where continent = 'Oceania';

-- 3. Select fields
select code, name
  -- 4. From Countries
  from countries
  -- 5. Where continent is Oceania
  where continent = 'Oceania'
  	-- 1. And code not in
  	and code not in
  	-- 2. Subquery
  	(select code from currencies
  	 );
	 
---final capter 3
-- Select the city name
select name
  -- Alias the table where city name resides
  from cities AS c1
  -- Choose only records matching the result of multiple set theory clauses
  WHERE country_code IN
(
    -- Select appropriate field from economies AS e
    SELECT e.code
    FROM economies AS e
    -- Get all additional (unique) values of the field from currencies AS c2  
    union
    SELECT c2.code
    FROM currencies AS c2
    -- Exclude those appearing in populations AS p
    except
    SELECT p.country_code as code
    FROM populations AS p
);

----capter 4

-- Select average life_expectancy
select avg(life_expectancy)
  -- From populations
  from populations
-- Where year is 2015
where year = 2015

-- Select fields
select *
  -- From populations
  from populations
-- Where life_expectancy is greater than
where life_expectancy >
  -- 1.15 * subquery
  1.15 * (select avg(life_expectancy)
   from populations where year= 2015
   )
   and year = 2015;
   
   