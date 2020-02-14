#--------------------------------------------------------------------------------------------------------------------
#[PREPARE] - 앞으로도 계속 사용할 CITY와 COUNTRY의 JOIN TABLE을 VIEW로 만든다.
#           Name 칼럼의 중복 방지를 위해 city.Name city로 변환
#--------------------------------------------------------------------------------------------------------------------

CREATE VIEW test AS
SELECT NAME AS city, countrycode, population AS city_population
FROM city;

CREATE TABLE whole
SELECT * FROM country
LEFT JOIN test
ON country.code = test.countrycode;


SELECT * FROM whole;



#--------------------------------------------------------------------------------------------------------------------
#[QUIZ3] - 1. 멕시코(Mexico)보다 인구가 많은 나라이름과 인구수를 조회하시고 인구수 순으로 내림차순하세요.
#--------------------------------------------------------------------------------------------------------------------

USE world;
SELECT NAME, POPULATION FROM country
WHERE POPULATION >= (
							SELECT POPULATION FROM country WHERE NAME LIKE '%Mexico%')
ORDER BY POPULATION DESC;


#--------------------------------------------------------------------------------------------------------------------
#[QUIZ3] - 2. 국가별 몇개의 도시가 있는지 조회하고 도시수 순으로 10위까지 내림차순하세요.
#--------------------------------------------------------------------------------------------------------------------

SELECT B.NAME, A.CNT

FROM 
	(SELECT COUNTRYCODE, COUNT(DISTINCT(NAME)) AS CNT
	FROM city
	GROUP BY COUNTRYCODE) AS A

JOIN country AS B
ON B.CODE = A.COUNTRYCODE	
ORDER BY CNT DESC;

#--------------------------------------------------------------------------------------------------------------------
#[QUIZ3] - 3. 언어별 사용인구를 출력하고 언어 사용인구 순으로 10위까지 내림차순하세요.
#--------------------------------------------------------------------------------------------------------------------


CREATE VIEW LAN AS
SELECT A.LANGUAGE AS LANGUAGE, TRUNCATE((A.Percentage * B.POPULATION),0) AS POPULATION 
FROM countrylanguage AS A
LEFT JOIN country AS B
ON A.CountryCode = B.CODE
ORDER BY POPULATION DESC LIMIT 10 ;


#--------------------------------------------------------------------------------------------------------------------
#[QUIZ3] - 4. 나라 전체 인구의 10%이상인 도시에서 도시인구가 500만이 넘는 도시를 아래와 같이 조회 하세요.
#--------------------------------------------------------------------------------------------------------------------


SELECT NAME, countrycode, city, truncate(city_population/population*100,2) AS PCT
FROM whole
WHERE city IN 
					(
					SELECT city FROM whole
					 WHERE city_population >= 0.1*population AND city_population >= 500*10000
					 )
ORDER BY pct DESC;


#--------------------------------------------------------------------------------------------------------------------
#[QUIZ3] - 5. 면적이 10000km^2 이상인 국가의 인구밀도(1km^2 당 인구수)를 구하고 인구밀도가 200이상인
#				국가들의 사용하고 있는 언어수가 5가지 이상인 나라를 조회 하세요..
#--------------------------------------------------------------------------------------------------------------------


SELECT * FROM 
	(SELECT distinct(CODE) , name, truncate(population/surfacearea,0) AS density
	FROM whole
	WHERE NAME IN 
				(SELECT distinct(NAME) FROM whole WHERE surfacearea >= 10000)
	HAVING density >= 200
	ORDER BY density DESC) AS a

JOIN 
	(SELECT countrycode, count(LANGUAGE) AS language_cnt FROM countrylanguage
	GROUP BY countrycode
	HAVING language_cnt >= 5) AS b
ON a.code = b.countrycode
ORDER BY language_cnt desc;



#--------------------------------------------------------------------------------------------------------------------
#[QUIZ3] -6. 사용하는 언어가 3가지 이하인 국가중 도시인구가 300만 이상인 도시를 아래와 같이 조회하세요.
#[STEP.1] 사용하는 언어가 3개 이하인 국가를 VIEW CNT_UN_L3로 생성
#--------------------------------------------------------------------------------------------------------------------


CREATE VIEW CNT_UN_L3 AS 
SELECT countrycode, COUNT(LANGUAGE) AS lan_cnt, GROUP_CONCAT(LANGUAGE,' ') AS languages
FROM countrylanguage
WHERE city_population >= 300*10000
GROUP BY countrycode
HAVING lan_cnt <= 3
;
SELECT * FROM CNT_UN_L3;

#--------------------------------------------------------------------------------------------------------------------
#[STEP.2] 도시인구가 300만 이상인 도시를 VIEW CITY_UP_P3M
#--------------------------------------------------------------------------------------------------------------------


CREATE VIEW CITY_UP_P3M AS
SELECT CODE, CITY, NAME, city_population AS population
	FROM whole
	HAVING city_population >= 300*10000
	ORDER BY city_population DESC;

SELECT * FROM CITY_UP_P3M;

#--------------------------------------------------------------------------------------------------------------------
#[STEP.3] 도시인구가 300만 이상인 도시를 VIEW CNT_UN_L3
#--------------------------------------------------------------------------------------------------------------------


SELECT A.COUNTRYCODE, B.CITY AS CITY_NAMES, B.POPULATION, A.LAN_CNT AS LANGUAGE_COUNT, A.LANGUAGES
FROM CNT_UN_L3 AS A
INNER JOIN CITY_UP_P3M AS B
ON A.countrycode = B.CODE
ORDER BY POPULATION DESC
;


