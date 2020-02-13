USE world;

SELECT * FROM country LIMIT 5;

#--------------------------------------------------------------------------
#[QUIZ1] - Q1. Countrty에서 중복을 제거한 Continent를 조회하세요.
SELECT DISTINCT Continent FROM country;

#--------------------------------------------------------------------------
#[QUIZ1] - Q2. 한국 도시중에 POP 100만이 넘는 도시를 조회하여 인구순으로 내림차순 하시오.
SELECT * FROM city LIMIT 5;
SELECT NAME, population FROM city
WHERE countrycode = 'KOR' AND POPULATION >= 100*10000
ORDER BY POPULATION DESC;


#--------------------------------------------------------------------------
#[QUIZ1] - Q3. City에서 POP 800만 1000만 사이의 도시 데이터를 인구순으로 내림차순 하시오.

SELECT * FROM city
WHERE population BETWEEN 800*10000 AND 1000*10000
ORDER BY population DESC;

#--------------------------------------------------------------------------
#[QUIZ1] - Q4. country 테이블에서 1940 ~ 1950년도 사이에 독립한 국가들을 조회하고 독립한 년도 순으로 오름차순하세요.

SELECT CODE, CONCAT(NAME, '(',INDEPYEAR,')') AS 'NAME_INDEPYEAR', CONTINENT, POPULATION
FROM country
WHERE INDEPYEAR BETWEEN 1940 AND 1950
ORDER BY INDEPYEAR ASC , population DESC;


#--------------------------------------------------------------------------
#[QUIZ1] - Q5. contrylanguage 테이블에서 스페인어, 한국어, 영어를 95% 이상 사용하는 국가 코드를 Percentage로 내림차순하여 아래와 같이 조회하세요.

SELECT countrycode, LANGUAGE, percentage
FROM countrylanguage
WHERE LANGUAGE IN ('Spanish', 'Korean', 'English') AND percentage >= 95
ORDER BY percentage DESC;


#--------------------------------------------------------------------------
#[QUIZ1] - Q6. country 테이블에서 Code가 A로 시작하고 GovernmentForm에 Republic이 포함되는 데이터를 아래와같이 조회하세요.
SELECT CODE, NAME, continent, governmentform, population
FROM country
WHERE CODE LIKE 'A%' AND governmentform LIKE'%Republic%';

