#--------------------------------------------------------------------------
# [QUIZ 2]Q1. country 테이블에서 몇개의 대륙이 있는지 조회하세요.

SELECT * FROM country LIMIT 5;
SELECT COUNT(DISTINCT(CONTINENT)) AS  NUM_CONTI
FROM country;

#--------------------------------------------------------------------------
# [QUIZ 2]Q2. country 테이블에서 Continent(대륙)별 몇개의 나라가 있는지 조회하세요.

SELECT Continent, COUNT(DISTINCT(CODE)) AS COUNT
FROM country
GROUP BY continent
ORDER BY COUNT DESC;


#--------------------------------------------------------------------------
# [QUIZ 2]Q3. city 테이블에서 국가코드(CountryCode) 별로 총인구가 몇명인지 조회하고 총인구 순으로 내림차순하세요.
#            		(총인구가 5천만 이상인 도시만 출력)


SELECT * FROM city LIMIT 5;

SELECT COUNTRYCODE, SUM(POPULATION) AS POPULATION
FROM city
GROUP BY COUNTRYCODE
HAVING POPULATION >5000*10000
ORDER BY POPULATION DESC;


#--------------------------------------------------------------------------
# [QUIZ 2]Q4.countrylanguage 테이블에서 언어별 사용하는 국가수를 조회하고 많이 사용하는 언어를 5위에서 10위까지 조회하세요.

SELECT * FROM countrylanguage LIMIT 5;

SELECT LANGUAGE, COUNT(COUNTRYCODE) AS COUNT
FROM countrylanguage
GROUP BY LANGUAGE
ORDER BY COUNT DESC LIMIT 4,6;


#--------------------------------------------------------------------------
# [QUIZ 2]Q5. countrylanguage 테이블에서 언어별 15개 국가 이상에서 사용되는 언어를 조회하고 언어별 국가수에 따라 내림차순하세요.


SELECT LANGUAGE, COUNT(COUNTRYCODE) AS COUNT
FROM countrylanguage
GROUP BY LANGUAGE
HAVING COUNT >= 15
ORDER BY COUNT DESC;


#--------------------------------------------------------------------------
# [QUIZ 2]Q6. country 테이블에서 대륙별 전체 표면적크기를 구하고 표면적 크기 순으로 내림차순하세요.

SELECT * FROM country LIMIT 5;

SELECT CONTINENT, SUM(SURFACEAREA) AS SURFACE
FROM country
GROUP BY CONTINENT
ORDER BY SURFACE DESC;