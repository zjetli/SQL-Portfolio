-- Select the oldest and newest founding years from the businesses table
SELECT 
        min(year_founded) AS Oldest_founding_yr,
        max(year_founded) AS Newest_founding_yr
FROM businesses;

-- Get the count of rows in businesses where the founding year was before 1000
SELECT
    COUNT(*)
FROM businesses
WHERE year_founded < 1000;

-- Select all columns from businesses where the founding year was before 1000
-- Arrange the results from oldest to newest
SELECT *
FROM businesses
WHERE year_founded < 1000
ORDER BY year_founded;

-- Select business name, founding year, and country code from businesses; and category from categories
-- where the founding year was before 1000, arranged from oldest to newest

SELECT
    b.business as business_name,
    b.year_founded as founding_year,
    b.country_code as country_code,
    c.category as category
FROM businesses b 
LEFT JOIN categories c
ON b.category_code = c.category_code
WHERE b.year_founded < 1000
ORDER BY b.year_founded;

-- Select the category and count of category (as "n")
-- arranged by descending count, limited to 10 most common categories
WITH combined as(
    SELECT *
    FROM businesses b 
    INNER JOIN categories c
    ON b.category_code = c.category_code;
)

SELECT category, count(*) as n
FROM combined
GROUP BY category
ORDER BY n DESC
LIMIT 10;

-- Select the oldest founding year (as "oldest") from businesses, 
-- and continent from countries
-- for each continent, ordered from oldest to newest 
WITH result AS(
SELECT
    MIN(b.year_founded) as oldest,
    c.continent
FROM businesses b
LEFT JOIN countries c
ON b.country_code = c.country_code
GROUP BY c.continent;
)

SELECT * FROM result
ORDER BY oldest;


-- Select the business, founding year, category, country, and continent

SELECT 
    b.business,
    b.year_founded,
    ca.category,
    co.country,
    co.continent
FROM businesses b
LEFT JOIN categories ca
ON b.category_code = ca.category_code
LEFT JOIN countries co
ON b.country_code = co.country_code;


-- Count the number of businesses in each continent and category
WITH joined_data AS(
SELECT 
    b.business,
    b.year_founded as founding_year,
    ca.category,
    co.country,
    co.continent
FROM businesses b
LEFT JOIN categories ca
ON b.category_code = ca.category_code
LEFT JOIN countries co
ON b.country_code = co.country_code;
)

SELECT
    continent,
    category,
    count(*) as n
FROM joined_data
GROUP BY continent, category
ORDER BY continent, category;


-- Filtering for results having a count greater than 5
WITH result AS(
SELECT 
    co.continent,
    ca.category,
    count(*) as n    
FROM businesses b
LEFT JOIN categories ca
ON b.category_code = ca.category_code
LEFT JOIN countries co
ON b.country_code = co.country_code
GROUP BY co.continent, ca,category
)

SELECT * FROM result
WHERE n > 5
order by n DESC
