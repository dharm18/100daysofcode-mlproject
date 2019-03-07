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

