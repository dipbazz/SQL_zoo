-- 1. How many stops are there in database.
SELECT COUNT(*) FROM stops;

-- 2. Find the id value for the stop 'Craiglockhart'
SELECT id FROM stops
WHERE name='Craiglockhart';

-- 3. Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name
FROM stops
JOIN route ON stop = id
WHERE num = 4 AND company = 'LRT'
ORDER BY pos;

-- 4. The query shown gives the number of routes that visit either London Road (149) or
--    Craiglockhart (53). Run the query and notice the two services that link these stops
--    have a count of 2. Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2;

-- 5. Execute the self join shown and observe that b.stop gives all the places you can get
--    to from Craiglockhart, without changing routes. Change the query so that it shows the
--    services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149;

-- 6. same as 5 but with name instead of id.
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road';

-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
--
--    with id
SELECT DISTINCT route1.company, route2.num FROM route route1
JOIN route route2 ON
(route1.company = route2.company AND route1.num = route2.num)
WHERE route1.stop = 115 AND route2.stop = 137;
--
--   with name
SELECT DISTINCT route1.company, route2.num FROM route route1
JOIN route route2 ON
(route1.company = route2.company AND route1.num = route2.num)
JOIN stops stop1 ON route1.stop = stop1.id
JOIN stops stop2 ON route2.stop = stop2.id
WHERE stop1.name = 'Haymarket' AND stop2.name = 'Leith';

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
-- with id
SELECT DISTINCT route1.company, route2.num FROM route route1
JOIN route route2 ON
(route1.company = route2.company AND route1.num = route2.num)
WHERE route1.stop = 53 AND route2.stop = 230;
-- with name
SELECT DISTINCT route1.company, route2.num FROM route route1
JOIN route route2 ON
(route1.company = route2.company AND route1.num = route2.num)
JOIN stops stop1 ON route1.stop = stop1.id
JOIN stops stop2 ON route2.stop = stop2.id
WHERE stop1.name = 'Craiglockhart' AND stop2.name = 'Tollcross';

-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by
--    taking one bus, including 'Craiglockhart' itself, offered by the LRT company.
--    Include the company and bus no. of the relevant services.
SELECT DISTINCT stopb.name, a.company, a.num
FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN stops stopb ON (b.stop = stopb.id)
WHERE a.company = 'LRT' AND a.stop = 53;

-- 10.
-- I will solve later couldn't solve it now.
