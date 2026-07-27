-- Project  1 - World Life Expectancy(Data Cleaning)

SELECT *
FROM world_life_expectancy;


SELECT country, Year, concat(country, year), count(concat(country, year))
FROM world_life_expectancy
GROUP BY Country, Year, concat(country, year)
HAVING count(concat(country, year)) > 1
;


SELECT *
FROM 	(
		SELECT
		ROW_ID,
		CONCAT(country, year),
		ROW_NUMBER() OVER (PARTITION BY CONCAT(country, year) ORDER BY CONCAT(country, year)) AS row_num
		FROM world_life_expectancy
		) AS row_table
WHERE row_num > 1
;


DELETE FROM world_life_expectancy
WHERE ROW_ID IN (
				SELECT ROW_ID
				FROM (
					SELECT
					ROW_ID,
					CONCAT(country, year),
					ROW_NUMBER() OVER (PARTITION BY CONCAT(country, year) ORDER BY CONCAT(country, year)) AS row_num
					FROM world_life_expectancy
					) AS row_table
				WHERE row_num > 1
)
;



SELECT *
FROM world_life_expectancy
WHERE Status = ''
;
SELECT *
FROM world_life_expectancy
;


SELECT DISTINCT Status
FROM world_life_expectancy
WHERE Status <> ''
;

SELECT DISTINCT country
FROM world_life_expectancy
WHERE Status = 'Developing'
;

UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN (
				SELECT DISTINCT country
				FROM world_life_expectancy
				WHERE Status = 'Developing')
;

UPDATE world_life_expectancy AS t1
JOIN world_life_expectancy AS t2
ON t1.country = t2.country
SET t1.Status = 'Developing'
WHERE t1.Status = '' AND t2.Status <> '' AND t2.Status = 'Developing'
;



SELECT DISTINCT country
FROM world_life_expectancy
WHERE Status = ''
;

SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America'
;

UPDATE world_life_expectancy AS t1
JOIN world_life_expectancy AS t2
ON t1.country = t2.country
SET t1.Status = 'Developed'
WHERE t1.Status = '' AND t2.Status <> '' AND t2.Status = 'Developed'
;


SELECT *
FROM world_life_expectancy
WHERE Status IS NULL
;

SELECT *
FROM world_life_expectancy
;

SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;


SELECT
	t1.Country, t1.Year, t1.`Life expectancy`,
	t2.Country, t2.Year, t2.`Life expectancy`,
    t3.Country, t3.Year, t3.`Life expectancy`,
    ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1) AS avg_life_expectancy
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;


UPDATE world_life_expectancy AS t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;

SELECT *
FROM world_life_expectancy
;


-- World Life Expectancy Exploratory Data Analysis

SELECT 
	Country,
	MAX(`Life expectancy`),
    MIN(`Life expectancy`),
    ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_In_15_years
FROM world_life_expectancy
GROUP BY Country
HAVING MAX(`Life expectancy`) <> 0 AND  MIN(`Life expectancy`) <> 0
ORDER BY Life_Increase_In_15_years DESC
;

SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;


SELECT *
FROM world_life_expectancy
;









SELECT Country, ROUND(AVG(`Life expectancy`),1) AS round_avg_life_expect, ROUND(AVG(GDP),1) AS round_avg_gdp
FROM world_life_expectancy
GROUP BY Country
HAVING round_avg_life_expect >  0 AND round_avg_gdp > 0
ORDER BY round_avg_gdp desc
;


SELECT *
FROM world_life_expectancy
ORDER BY GDP
;

SELECT
	SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Life_Expectancy,
    ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END),1) AS High_GDP_Count,
    SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Life_Expectancy,
    ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END),1) AS Low_GDP_Count
FROM world_life_expectancy
;



SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

SELECT Country,ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS avg_BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0 AND avg_BMI > 0
ORDER BY avg_BMI ASC
;

SELECT *
FROM world_life_expectancy
;

SELECT
	Country,
    Year,
    GDP,
    BMI,
    `infant deaths`,
    SUM(`infant deaths`) OVER(PARTITION BY Country ORDER BY Year)  AS Rolling_Infant_Deaths,
    `Life expectancy`,
    `Adult Mortality`,
    SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year)  AS Rolling_Total
FROM world_life_expectancy
HAVING Country = 'India'
;