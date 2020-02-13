#--------------------------------------------------------------------------
# Q1. city에서 나라별 도시의 개수를 출력하세요.

SELECT countrycode, COUNT(DISTINCT(NAME)) AS Num_city
FROM city
GROUP BY countrycode
ORDER BY num_city DESC;

#--------------------------------------------------------------------------
# Q2. Countrtylanguage에서 언어의 개수를 count 하세요.

SELECT * FROM countrylanguage LIMIT 5;

SELECT COUNT(DISTINCT(LANGUAGE)) AS NUM_language FROM countrylanguage;



#--------------------------------------------------------------------------
# Q3. 대륙별 인구수와 gnp의 최대값을 출력

SELECT 
	Continent, 
	sum(Population) AS Continent_pop, 
	max(GNP) AS Continent_max_gnp, 
	round(SUM(gnp) / sum(Population),3) AS D_per_p

FROM country
GROUP BY continent
ORDER BY D_per_p DESC;


#--------------------------------------------------------------------------
# Q4. 대륙별 전체 인구와 5억 이상인 대륙만 출력

SELECT Continent, SUM(population) AS Population
FROM country
GROUP BY Continent
HAVING Population > 500000000
ORDER BY Population desc;