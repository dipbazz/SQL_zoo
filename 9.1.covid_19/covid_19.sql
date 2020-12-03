-- 1.
SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn;

-- 2. The LAG function is used to show data from the preceding row or the table.
--    When lining up rows the data is partitioned by country name and ordered by the data whn.
--    That means that only data from Italy is considered.
SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS dbf
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn;

-- 3. Show the number of new cases for each day, for Italy, for March.
SELECT name, DAY(whn),
   confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) as 'new cases'
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn;

-- 4. Show the number of new cases in Italy for each week - show Monday only.
SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'),
   confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) as weekly
 FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0
ORDER BY whn;

-- 5. Show the number of new cases in Italy for each week - show Monday only. using JOIN
SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'),
 tw.confirmed-lw.confirmed
 FROM covid tw LEFT JOIN covid lw ON
  DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
   AND tw.name=lw.name
WHERE tw.name = 'Italy'
  AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;

-- 6. Include the ranking for the number of deaths in the table.
SELECT
   name,
   confirmed,
   RANK() OVER (ORDER BY confirmed DESC) rc,
   deaths,
   RANK() OVER (ORDER BY deaths DESC) dr
  FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC

-- 7. Show the infect rate ranking for each country. Only include countries with a population of at least 10 million.
SELECT
   world.name,
   ROUND(100000*confirmed/population,0),
   RANK() OVER (ORDER BY 100000*confirmed/population) as rank
  FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population >= 10000000
ORDER BY population DESC;
-- this isn't solved properly.

-- 8. Couln't solve
