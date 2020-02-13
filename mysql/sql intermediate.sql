#--------------------------------------------------------------------------
#[SQL Intermediate] 1 : CEIL, TRUNCATE, ROUND
SELECT *
FROM country;
SELECT CODE, ROUND((GNP/POPULATION) * 1000,2) AS NUM
FROM country; 


#--------------------------------------------------------------------------
#[SQL Intermediate] 2: IF, IFNULL, CASE
# IF: IF(조건,참,거짓) / 도시의 인구가 100만 이상이면 BIG 아니면 SMALL
SELECT *
FROM country;
SELECT 
	CODE,
	population, 
	IF(POPULATION >= 100*10000, 'Big', 'Small') AS scale
FROM country
ORDER BY population DESC
LIMIT 10;


#--------------------------------------------------------------------------
#[SQL Intermediate] 2: IF, IFNULL, CASE
# IFNULL: IFNULL(DATA, Null일때 출력) / Country 테이블에서 독립년도가 없으면 0으로 출력되는 쿼리
SELECT
	CODE,
	NAME, IFNULL(indepyear, 0) AS indep_year
FROM country
ORDER BY indep_year;


#--------------------------------------------------------------------------
#[SQL Intermediate] 2: IF, IFNULL, CASE
# CASE WHEN (조건) THEN (실행) END AS (ALIAS) : 나라별 10억, 1억 이상 이하로 나누는 칼럼 작성
SELECT *
FROM country;

SELECT 
	NAME,
	POPULATION, 
	CASE 
		WHEN POPULATION >= 10*10000*10000 THEN 'O_1B' 
		WHEN POPULATION >= 1*10000*10000 THEN 'O_1M' 
		ELSE 'U_1M' END AS POP_SCALE
FROM country
ORDER BY POPULATION DESC; 


#--------------------------------------------------------------------------
#[SQL Intermediate] 3: DATE Foramt
# Sakila DB : Payment 테이블에서 월별 총 매출 출력
USE sakila;
SELECT *
FROM payment
LIMIT 5;


#--------------------------------------------------------------------------
# Sakila DB : Payment 테이블에서 월별 총 매출 출력
SELECT 
	
	DATE_FORMAT(payment_date, '%Y-%m') AS YM,
	sum(amount) AS 'SALES',
	COUNT(amount) AS 'CNT_PCH',
	TRUNCATE(sum(amount) / COUNT(amount), 2) AS 'SALES_PER_PCH' 
	
FROM payment
GROUP BY ym;

#--------------------------------------------------------------------------
# Sakila DB : Payment 테이블에서 시간별 총 매출 출력
SELECT
	DATE_FORMAT(payment_date, '%H') AS HR,
	sum(amount) AS 'SALES',
	COUNT(amount) AS 'CNT_PCH'
FROM payment
GROUP BY HR;


#--------------------------------------------------------------------------
#[SQL Intermediate] 4: Join
# Sakila DB : Table 생성
USE world;

CREATE TABLE user (
user_id int(11) unsigned NOT NULL AUTO_INCREMENT,
name varchar(30) DEFAULT NULL,
PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE addr (
id int(11) unsigned NOT NULL AUTO_INCREMENT,
addr varchar(30) DEFAULT NULL,
user_id int(11) DEFAULT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO user(name)
VALUES ("jin"),
("po"),
("alice"),
("petter");

INSERT INTO addr(addr, user_id)
VALUES ("seoul", 1),
("pusan", 2),
("deajeon", 3),
("deagu", 5),
("seoul", 6);


#--------------------------------------------------------------------------
#[SQL Intermediate] 4: Join
# WORLD DB : Inner Join

SELECT a.addr, a.user_id, b.name
FROM addr AS a
JOIN user AS b
ON a.user_id = b.user_id	
;
#--------------------------------------------------------------------------
#[SQL Intermediate] 4: Join
# WORLD DB : 도시 이름과 국가 이름을 동시에 출력

SELECT city.Name, country.Name 
FROM city
left JOIN country
ON city.CountryCode = country.Code
;



#--------------------------------------------------------------------------
#[SQL Intermediate] 4: Join
# WORLD DB : union ; SELECT 문의 결과를 합쳐주고 자동으로 중복을 제거함

SELECT addr.addr, addr.user_id, user.name
FROM addr
LEFT JOIN user
ON addr.user_id = user.user_id
UNION 
SELECT addr.addr, addr.user_id, user.name
FROM addr
RIGHT JOIN user
ON addr.user_id = user.user_id;



#--------------------------------------------------------------------------
#[SQL Intermediate] 5. sub-Query / 동시 SELECT 
# WORLD DB : 전체 나라, 도시, 언어 수 출력 (239 /4,079 /456)

SELECT 1,2,3;

SELECT
	(SELECT COUNT(*) FROM country) AS total_country,
	(SELECT COUNT(*) FROM city) AS total_city,
	(SELECT COUNT(DISTINCT(LANGUAGE)) FROM countrylanguage) AS totla_language
;


#--------------------------------------------------------------------------
#[SQL Intermediate] 5. sub-Query / FROM 
# WORLD DB : 800만 이상이 되는 도시의 국가 코드, 국가이름, 도시이름, 인구 출력

SELECT city.CountryCode, city.NAME, city.population FROM
 	(SELECT countrycode, NAME, population FROM city WHERE POPULATION >= 800*10000) AS city
JOIN country
ON city.CountryCode = country.code
ORDER BY population desc
;


#--------------------------------------------------------------------------
#[SQL Intermediate] 5. sub-Query / FROM 
# WORLD DB : 800만 이상 도시의 국가 코드, 국가 이름, 대통령 이름 출력

SELECT CODE, NAME, headofstate FROM country
WHERE code IN
	(SELECT distinct(countrycode) FROM city WHERE population >= 800*10000)
;