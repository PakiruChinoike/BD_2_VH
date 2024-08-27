-- Trabalho 27/08 VHF
USE sakila;


-- Obtém uma lista de filmes e as suas categorias
SELECT f.title, c.name FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
ORDER BY f.title;

-- Obtém uma lista de clientes e suas cidades
SELECT CONCAT(c.first_name, " ", c.last_name) AS name, ci.city FROM customer AS c
JOIN address AS a ON a.address_id = c.address_id
JOIN city AS ci ON ci.city_id = a.city_id
ORDER BY name;

-- Obtém uma lista de funcionários e o ID de suas lojas
SELECT CONCAT(s.first_name, " ", s.last_name) AS name, s.store_id FROM staff AS s
JOIN store AS st ON st.store_id = s.store_id
ORDER BY name;

-- Obtém todos os filmes alugados entre 01/01/2006 e 01/03/2006, com o nome do cliente que realizou o aluguel
SELECT f.title, r.rental_date, CONCAT(c.first_name, " ", c.last_name) AS name FROM rental AS r
JOIN customer AS c ON r.customer_id = c.customer_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON f.film_id = i.film_id
WHERE r.rental_date BETWEEN '2006-01-01' AND '2006-03-01'
ORDER BY f.title;

-- Obtém o nome do ator e a receita total gerada por ele
SELECT CONCAT(a.first_name, " ", a.last_name) AS name, SUM(p.amount*f.rental_rate) AS total FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON f.film_id = fa.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY name
ORDER BY total;






