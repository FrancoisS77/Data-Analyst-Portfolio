Use Sakila;
-- 1- Afficher les 5 premiers Records de la table Actor
 SELECT * FROM `actor` LIMIT 5;
-- 2- Récupérer dans une colonne Actor_Name le full_name des acteurs sous le format: first_name + " " + last_name
SELECT CONCAT(first_name, ' ', last_name) AS Actor_Name FROM actor;
SELECT CONCAT_WS(" ", `first_name`, `last_name`) AS `Actor_Name` from actor ;
-- 3- Récupérer dans une colonne Actor_Name le full_name des acteurs sous le format: first_name en minuscule + "." + last_name en majuscule
SELECT CONCAT(LOWER(first_name), ' ', last_name) AS Actor_Name FROM actor;
-- 4- Récupérer dans une colonne Actor_Name le full_name des acteurs sous le format: last_name en majuscule + "." + premiere lettre du first_name en majuscule
select concat(upper(actor.last_name), '.', left(actor.first_name,1) ,'', lower(right(actor.first_name,length(actor.first_name)-1)))  as Actor_Name from sakila.actor;
-- 5- Trouver le ou les acteurs appelé(s) "JENNIFER"
select actor.first_name,actor.last_name from sakila.actor where actor.first_name='JENNIFER';
-- 6- Trouver les acteurs ayant des prénoms de 3 charactères.
SELECT `first_name` FROM `actor` WHERE LENGTH(first_name) = 3;
SELECT `first_name` FROM `actor` WHERE `first_name` like '___';

-- 7- Afficher les acteurs (actor_id, first_name, last_name, nbre char first_name, nbre char last_name )par ordre décroissant de longueur de prénoms
SELECT  `actor_id` , 
                `first_name` , 
                `last_name` , 
                LENGTH(first_name) As nbre_char_first_name , 
                LENGTH(last_name) As nbre_char_last_name 
FROM `actor` 
ORDER BY CHAR_LENGTH(first_name) DESC;

-- 8- Afficher les acteurs (actor_id, first_name, last_name, nbre char first_name, nbre char last_name )par ordre décroissant de longueur de prénoms et croissant de longuer de noms
SELECT  `actor_id` , 
                `first_name` , 
                `last_name` , 
                LENGTH(first_name) As nbre_char_first_name , 
                LENGTH(last_name) As nbre_char_last_name 
FROM `actor` 
ORDER BY CHAR_LENGTH(first_name) DESC,
                CHAR_LENGTH(last_name) ASC;

-- 9- Trouver les acteurs ayant dans leurs last_names la chaine: "SON

SELECT `last_name` FROM `actor` WHERE `last_name` LIKE "%SON%";

-- 10- Trouver les acteurs ayant des last_names commençant par la chaine: "JOH"
SELECT `last_name` FROM `actor` WHERE `last_name` LIKE "JOH%";

-- 11- Afficher par ordre alphabétique croissant les last_names et les first_names des acteurs ayant dans leurs last_names la chaine "LI"
SELECT  `first_name` , 
                `last_name`
FROM `actor` 
WHERE `last_name` LIKE "%LI%"
ORDER BY first_name ASC;

-- 12- trouver dans la table country les countries "China", "Afghanistan", "Bangladesh"
SELECT `country` FROM `country` WHERE `country` LIKE 'China' OR `country` LIKE 'Afghanistan' OR `country` LIKE 'Bangladesh';
SELECT * FROM sakila.country where country in( "China " ,  "Afghanistan" ,"Bangladesh");
-- 13- Ajouter une colonne middle_name entre les colonnes first_name et last_name
ALTER TABLE `actor` ADD COLUMN `middle_name` VARCHAR(45) AFTER `first_name`;
-- 14- Changer le data type de la colonne middle_name au type blobs
ALTER TABLE `actor` MODIFY `middle_name` BLOB(50000);
-- 15- Supprimer la colonne middle_name
ALTER TABLE `actor` DROP `middle_name`;
-- 16- Trouver le nombre des acteurs ayant le meme last_name Afficher le resultat par ordre décroissant
SELECT `last_name`,	COUNT(`last_name`)
FROM `actor`
GROUP BY `last_name`
HAVING COUNT(`last_name`) > 1
ORDER BY COUNT(`last_name`) DESC;
-- 17- Trouver le nombre des acteurs ayant le meme last_name Afficher UNIQUEMENT les  last_names communs à au moins 3 acteurs Afficher par ordre alph. croissant
SELECT `last_name`
FROM `actor`
GROUP BY `last_name`
HAVING COUNT(`last_name`) > 2
ORDER BY `last_name` ASC;
-- 18- Trouver le nombre des acteurs ayant le meme first_name Afficher le resultat par ordre alph. croissant
SELECT `last_name`,COUNT(`first_name`)
FROM `actor`
GROUP BY `first_name`
HAVING COUNT(`first_name`) > 1
ORDER BY `first_name` ASC;
-- 19- Insérer dans la table actor ,un nouvel acteur , faites attention à l'id!
INSERT INTO `actor` (`first_name`,`last_name`) VALUES ('Julia','Roberts');
select * from `actor` ORDER BY `actor_id` DESC LIMIT 3;
select max(actor_id) from actor;
-- 20- Modifier le first_name du nouvel acteur à "Jean"
UPDATE `actor` SET `first_name` = 'Jean' WHERE actor_id = 201;
UPDATE `actor` SET `first_name` = 'Jean' WHERE `first_name` = 'Julia' AND `last_name` = 'Roberts';

select max(actor_id) from actor;
Update `actor` SET `first_name` = 'Jean' WHERE (actor_id = 201);

-- 21- Supprimer le dernier acteur inséré de la table actor
DELETE from `actor` ORDER BY `actor_id` DESC LIMIT 1;

-- 22-Corriger le first_name de l'acteur HARPO WILLIAMS qui était accidentellement inséré à GROUCHO WILLIAMS
UPDATE actor SET  first_name = 'HARPO' WHERE first_name='GROUCHO' AND last_name='WILLIAMS';

SELECT REPLACE('GROUCHO WILLIAMS','GROUCHO','HARPO'); 

-- SELECT * FROM actor WHERE first_name='HARPO' AND last_name='WILLIAMS';
-- 23- Mettre à jour le first_name dans la table actor pour l'actor_id 173 comme suit: si le first_name ="ALAN" alors remplacer le par "ALLAN" sinon par "MUCHO ALLAN"
UPDATE actor
SET first_name = IF(first_name="ALAN","ALLAN","MUCHO ALLAN") WHERE actor_id = 173;
-- ou--
UPDATE actor SET first_name=
case 
WHEN first_name = 'ALAN'
THEN 'ALLAN'
ELSE 'MUCHO ALLAN'
END
WHERE actor_id =173;

-- 24- Trouver les first_names,last names et l'adresse de chacun des membre staff RQ: utiliser join avec les tables staff & address:
SELECT first_name, last_name,address 
FROM staff as st
JOIN address ad on st.address_id=ad.address_id;
-- 25- Afficher pour chaque membre du staff ,le total de ses salaires depuis Aout 2005. RQ: Utiliser les tables staff & payment.
SELECT st.first_name,st.last_name,payment.amount,payment.payment_date,
SUM(payment.amount) AS 'Total'
FROM staff as st INNER JOIN payment ON st.staff_id=payment.staff_id
WHERE payment.payment_date>='2005-08-01'
GROUP BY st.staff_id;
-- 26- Afficher pour chaque film ,le nombre de ses acteurs
SELECT count(actor_id),title FROM film_actor
INNER JOIN film ON film.film_id = film_actor.film_id
GROUP BY title;

-- 27- Trouver le film intitulé "Hunchback Impossible"
SELECT  film_id FROM film
WHERE title='Hunchback Impossible';
-- 28- combien de copies exist t il dans le systme d'inventaire pour le film Hunchback Impossible
SELECT film_id, count(film_id) FROM inventory
WHERE film_id=439;

SELECT film.film_id, count(inventory.film_id) FROM inventory INNER JOIN film on film.film_id=inventory.film_id
where film.title='Hunchback Impossible';

SELECT inventory.film_id, count(inventory.film_id) FROM inventory WHERE film_id IN (
SELECT film_id FROM film
where film.title='Hunchback Impossible');

-- 29- Afficher les titres des films en anglais commençant par 'K' ou 'Q'
SELECT title FROM film
WHERE title LIKE 'k%'
OR title LIKE 'Q%'
AND language_id=1;

SELECT title FROM film
WHERE title LIKE 'k%'
OR title LIKE 'Q%'
AND language_id= (SELECT language_id FROM language WHERE name='english');

SELECT title FROM film INNER JOIN language on film.language_id=language.language_id
WHERE title LIKE 'k%'
OR title LIKE 'Q%'
AND language_name='english';

-- 30- Afficher les first et last names des acteurs qui ont participé au film intitulé 'ACADEMY DINOSAUR'

SELECT actor.actor_id, actor.first_name, actor.last_name, film.title 
FROM film JOIN film_actor ON film.film_id = film_actor.film_id JOIN actor 
ON actor.actor_id = film_actor.actor_id WHERE film.title = 'ACADEMY DINOSAUR';

SELECT 
    a.actor_id, first_name, last_name
FROM
    actor a
        INNER JOIN
    film_actor f ON a.actor_id = f.actor_id
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film
        WHERE
title = 'ACADEMY DINOSAUR');
-- 31- Trouver la liste des film catégorisés comme family films.
select category.name ,
        film.title
from  film_category
inner join film on film.film_id = film_category.film_id
inner join category on category.category_id = film_category.category_id
where category.name = 'family';
-- 32- Afficher le top 5 des films les plus loués par ordre decroissant
SELECT film.title, COUNT(rental.inventory_id) AS Count_of_Rented_Movies
 FROM film 
 JOIN inventory ON film.film_id = inventory.film_id 
 JOIN rental ON inventory.inventory_id = rental.inventory_id 
 GROUP BY film.film_id 
 ORDER BY 2 DESC LIMIT 5;
-- 33- Afficher la liste des stores : store ID, city, country
SELECT store_id, city, country 
FROM store 
JOIN address ON address.address_id = store.address_id 
JOIN city ON city.city_id = address.city_id 
JOIN country ON country.country_id = city.country_id;
-- 34- Afficher le chiffre d'affaire par store. RQ: le chiffre d'affaire = somme (amount)
SELECT store.store_id, SUM(payment.amount) 
FROM store 
JOIN staff ON store.store_id = staff.store_id 
JOIN payment ON payment.staff_id = staff.staff_id 
GROUP BY store.store_id;

-- 35- Lister par ordre décroissant le top 5 des catégories ayant le plus des revenues. RQ utiliser les tables : category, film_category, inventory, payment, et rental.
SELECT name AS "Top Five", SUM(amount) AS "Gross" 
FROM category 
INNER JOIN film_category ON category.category_id = film_category.category_id 
INNER JOIN inventory ON inventory.film_id=film_category.film_id 
INNER JOIN rental ON rental.inventory_id=inventory.inventory_id 
INNER JOIN payment ON payment.rental_id=rental.rental_id 
GROUP BY name 
ORDER BY sum(amount) DESC limit 5;
-- 36- Créer une view top_five_genres avec les résultat de la requete precedante.
CREATE VIEW top_five_genres AS 
SELECT name AS "Top Five", SUM(amount) AS "Gross" 
FROM category 
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory ON inventory.film_id=film_category.film_id 
INNER JOIN rental ON rental.inventory_id=inventory.inventory_id 
INNER JOIN payment ON payment.rental_id=rental.rental_id 
GROUP BY name 
ORDER BY sum(amount) DESC limit 5;

SELECT * FROM top_five_genres;
-- 37- Supprimer la table top_five_genres

DROP VIEW IF EXISTS top_five_genres;
