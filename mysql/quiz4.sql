
#--------------------------------------------------------------------------------------------------------------------
#[QUIZ4] -1. 가장 돈을 많이 지불한 상위 5명의 고객의 이름과 지불 금액 출력
#--------------------------------------------------------------------------------------------------------------------
USE sakila;


SELECT CONCAT(a.first_name, ' ', last_name) AS full_name, b.sales
	FROM customer AS a
JOIN
	(SELECT customer_id, sum(amount) AS SALES FROM payment
	GROUP BY customer_id) AS b
ON a.customer_id = b.customer_id
ORDER BY sales DESC
LIMIT 5;


#--------------------------------------------------------------------------------------------------------------------
#[QUIZ4] -2. 배우별 영화 출연 횟수 출력 (상위 10개)
#[STEP.1] 배우 id 별 FILM id count
#[STEP.2] 배우 ID와 이름 매칭
#[KEY] : actor_id
#--------------------------------------------------------------------------------------------------------------------


SELECT a.actor_id, b.full_name, a.count FROM
	
	(SELECT actor_id, count(film_id) AS COUNT 
	FROM film_actor
	GROUP BY actor_id
	) AS a

JOIN
	
	(SELECT actor_id, CONCAT(first_name, ' ', last_name) AS full_name
	FROM actor) AS b
ON
	a.actor_id = b.actor_id

ORDER BY COUNT DESC, full_name LIMIT 10;



#--------------------------------------------------------------------------------------------------------------------
#[QUIZ4] -3. 영화 카테고리별 수입 데이터를 내림차순으로 정렬 
## payment, rental, inventory, film_category, category 테이블 사용
### [SETP.1] : rental, inventory, payment를 통해 rental_id 별 film_id, payment 결합
### [KEY] : inventory_id, rental_id
#--------------------------------------------------------------------------------------------------------------------
SELECT RENT.rental_id, RENT.inventory_id, RENT.customer_id, RENT.film_id, pay.amount FROM
	(SELECT a.rental_id, a.inventory_id, a.customer_id, b.film_id 
	FROM rental AS a
	JOIN inventory AS b
	ON a.inventory_id  = b.inventory_id) AS RENT
JOIN payment AS pay
ON RENT.rental_id = pay.rental_id;


#--------------------------------------------------------------------------------------------------------------------
### [SETP.2] : film_category, cateogry 테이블에서 film_id, film_category, category_name 결합
### [KEY] : category_id
#--------------------------------------------------------------------------------------------------------------------

CREATE VIEW movies AS 
SELECT A.film_id, A.category_id, B.name 
	FROM film_category AS A
	JOIN category AS B
	ON A.category_id = B.category_id;


#--------------------------------------------------------------------------------------------------------------------
### [SETP.3] : rent별 film_id, amount가 담긴 rental view와 film_id 별 category name이 담긴 movies view join
### [KEY] : film_id
#--------------------------------------------------------------------------------------------------------------------


SELECT b.name, sum(a.amount) AS SALES 
	
	FROM RENTALS AS a
	JOIN movies AS b
	ON a.film_id = b.film_id

GROUP BY b.name
ORDER BY SALES DESC LIMIT 11;