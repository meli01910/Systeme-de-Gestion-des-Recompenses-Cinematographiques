--question 1

--Afficher tous les individue dont le nom se termine par "el" ou par "en".

--Cette requête est utile pour rechercher et afficher les individus dont le nom se termine par des caractères
--spécifiques, facilitant ainsi la recherche d'informations sur des groupes particuliers d'individus.*/

SELECT * FROM P02_individu WHERE individu_nom ~ '(el|en)$';
-------------------------------------------------------------------------------------------------------------------------------------------
--question 2
---------------------------------------------------------------------------------------------------------------------------------------------
--requete 1: Affiche les informations spécifiées pour les individus qui ont été nominés ou ont remporté le prix du meilleur acteur ou de la meilleure actrice.

---Syntaxe 1 de jointure interne(la syntaxe classique de jointure interne)*/
SELECT individu_prenom, individu_nom, recompense_nom,statut
FROM P02_individu
INNER JOIN P02_nomination ON P02_individu.individu_id = P02_nomination.individu_id
INNER JOIN P02_recompense ON P02_recompense.recompense_id = P02_nomination.recompense_id
WHERE recompense_nom IN ('meilleur acteur', 'meilleur actrice');

--Syntaxe 2 de jointure interne.
 --La jointure naturelle relie les colonnes portant le même nom automatiquement.

SELECT individu_prenom, individu_nom, recompense_nom,statut
FROM P02_individu
NATURAL JOIN P02_nomination
NATURAL JOIN P02_recompense
WHERE recompense_nom IN ('meilleur acteur', 'meilleur actrice');

-- Par jointure externe (FULL OUTER JOIN)
SELECT individu_prenom, individu_nom, recompense_nom,statut
FROM P02_individu
FULL OUTER JOIN P02_nomination ON P02_individu.individu_id = P02_nomination.individu_id
FULL OUTER JOIN P02_recompense ON P02_nomination.recompense_id = P02_recompense.recompense_id
WHERE recompense_nom IN ('meilleur acteur', 'meilleur actrice');

--Comparaison :
--La version avec jointure interne ne renverra que les individus qui ont remporté ou ont été nominés pour les récompenses meilleur acteur et actrice(les résultats correspondant à la condition de jointure)
--La version avec jointure externe renverra tous les individus de la table P02_individu, même ceux qui n'ont pas remporté de récompense ni été nominés, avec des valeurs NULL pour les colonnes de P02_nomination et P02_recompense.
--Alors non les résultats ne seront pas identiques.


--Par produit cartésien et restriction
select  individu_prenom,individu_nom,recompense_nom,statut
from P02_individu,P02_nomination ,P02_recompense
where P02_individu.individu_id = P02_nomination.individu_id and P02_nomination.recompense_id = P02_recompense.recompense_id and recompense_nom in('meilleur acteur','meilleur actrice')  ;


-------------------------------------------------------------------------------
--requete2:affiche toutes les récompenses des céremonies annuelle.

-- Syntaxe 1 de jointure interne
SELECT ceremonie_nom, recompense_nom, ceremonie_pays
FROM P02_recompense
INNER JOIN P02_ceremonie P02c ON P02_recompense.ceremonie_id = P02c.ceremonie_id
WHERE ceremonie_type = 'Annuelle';

-- Syntaxe 2 de jointure interne
SELECT ceremonie_nom, recompense_nom, ceremonie_pays
FROM P02_recompense
NATURAL JOIN P02_ceremonie
WHERE ceremonie_type = 'Annuelle';

-- Par jointure externe (FULL OUTER JOIN)
SELECT ceremonie_nom, recompense_nom, ceremonie_pays
FROM P02_recompense
FULL OUTER JOIN P02_ceremonie P02c ON P02_recompense.ceremonie_id = P02c.ceremonie_id
WHERE ceremonie_type = 'Annuelle';

--Comparaison : 
--La version avec jointure interne ne renverra que les récompenses décernées lors de cérémonies annuelles, avec les détails de la cérémonie.
--La version avec jointure externe renverra toutes les récompenses de la table P02_recompense,
--même celles qui ne sont pas associées à une cérémonie annuelle, avec des valeurs NULL pour les colonnes de P02_ceremonie


--Par produit cartésien et restriction
select ceremonie_nom,recompense_nom,ceremonie_pays
from P02_recompense,P02_ceremonie
where P02_recompense.ceremonie_id = P02_ceremonie.ceremonie_id and ceremonie_type='Annuelle';
------------------------------------------------------------------------------------------------------

--requete3:affiche les meilleur films , le nom de la récompense dans quelle céremonie et l'année de remise

-- Syntaxe 1 de jointure interne
SELECT film_nom, annee_remise, recompense_nom, ceremonie_nom
FROM P02_film
INNER JOIN P02_nomination P02n ON P02_film.film_id = P02n.film_id
INNER JOIN P02_recompense P02r ON P02n.recompense_id = P02r.recompense_id
INNER JOIN P02_ceremonie P02c ON P02r.ceremonie_id = P02c.ceremonie_id
WHERE statut = 'gagnant' AND recompense_nom LIKE '%meilleur film%';

-- Syntaxe 2 de jointure interne
SELECT film_nom, annee_remise, recompense_nom, ceremonie_nom
FROM P02_film
NATURAL JOIN P02_nomination
NATURAL JOIN P02_recompense
NATURAL JOIN P02_ceremonie
WHERE statut = 'gagnant' AND recompense_nom LIKE '%meilleur film%';

-- Par jointure externe (FULL OUTER JOIN)
SELECT film_nom, annee_remise, recompense_nom, ceremonie_nom
FROM P02_film
FULL OUTER JOIN P02_nomination P02n ON P02_film.film_id = P02n.film_id
FULL OUTER JOIN P02_recompense P02r ON P02n.recompense_id = P02r.recompense_id
FULL OUTER JOIN P02_ceremonie P02c ON P02r.ceremonie_id = P02c.ceremonie_id
WHERE statut = 'gagnant' AND recompense_nom LIKE '%meilleur film%';

--Comparaison : 
--La version avec jointure interne ne renverra que les films ayant remporté le prix du meilleur film lors de cérémonies, avec les détails de la cérémonie et de la récompense.
--La version avec  jointure externe renverra tous les films de la table P02_film,
--même ceux qui n'ont pas remporté de récompense ni été nominés, avec des valeurs NULL pour les colonnes de P02_nomination, P02_recompense et P02_ceremonie.*/

--Par produit cartésien et restriction
select film_nom,annee_remise,recompense_nom,ceremonie_nom
from P02_film, P02_nomination ,P02_recompense ,P02_ceremonie
where  P02_film.film_id = P02_nomination.film_id and  P02_nomination.recompense_id = P02_recompense.recompense_id and  P02_recompense.ceremonie_id = P02_ceremonie.ceremonie_id and statut='gagnant' and recompense_nom like '%meilleur film%';
---------------------------------------------------------------------------------------------------------------------------------------------

--requete 4 :Affiche tous les participants du film "Une place au soleil"

-- Syntaxe 1 de jointure interne
SELECT individu_nom, individu_prenom, statut,recompense_nom,film_nom
FROM P02_individu
INNER JOIN P02_nomination P02n ON P02_individu.individu_id = P02n.individu_id
INNER JOIN P02_recompense P02r on P02r.recompense_id = P02n.recompense_id
INNER JOIN P02_film P02f on P02n.film_id = P02f.film_id
where film_nom='Une place au soleil';

-- Syntaxe 2 de jointure interne
SELECT individu_nom, individu_prenom, statut,recompense_nom,film_nom
FROM P02_individu
natural JOIN P02_nomination
natural JOIN P02_recompense
natural JOIN P02_film
where film_nom='Une place au soleil';

-- Par jointure externe (FULL OUTER JOIN)
SELECT individu_nom, individu_prenom, statut,recompense_nom,film_nom
FROM P02_individu
FULL OUTER JOIN  P02_nomination P02n ON P02_individu.individu_id = P02n.individu_id
FULL OUTER JOIN P02_recompense P02r on P02r.recompense_id = P02n.recompense_id
full outer join P02_film P02f on P02n.film_id = P02f.film_id
where film_nom='Une place au soleil';

--Comparaison : 
--La version avec jointure interne ne renverra que les participants du film "Une place au soleil" avec des détails sur les récompenses qu'ils ont reçues.
--La version avec UNION (simulant une jointure externe) renverra tous les individus de la table P02_individu,
--même ceux qui n'ont pas participé au film "Une place au soleil", avec des valeurs NULL pour les colonnes de P02_nomination, P02_recompense et P02_film*/

--Par produit cartésien et restriction
select individu_nom, individu_prenom, statut,recompense_nom,film_nom
from P02_individu,P02_nomination,P02_recompense ,P02_film
where P02_individu.individu_id = P02_nomination.individu_id and P02_recompense.recompense_id = P02_nomination.recompense_id and P02_nomination.film_id = P02_film.film_id and film_nom='Une place au soleil';


--En résumé, la jointure interne retournera uniquement les résultats correspondant à la condition de jointure, 
--tandis que la jointure externe retournera tous les lauréat avec des valeurs NULL pour les colonnes des tables non correspondantes.

---Comparaison de temp d'execution :


--Jointure Interne (Syntaxe 1) :
--Cette version utilise des jointures internes explicites, ce qui permet à l'optimiseur de requêtes de prendre des décisions plus informées sur l'exécution de la requête.
--La syntaxe explicite pourrait aider l'optimiseur à choisir les indexes appropriés et à générer un plan d'exécution plus efficace.

--Jointure Naturelle (Syntaxe 2) :
--La jointure naturelle automatique peut être efficace dans de nombreux cas, mais elle dépend de la structure des tables et peut parfois être moins prédictible pour l'optimiseur.

--Jointure Externe :
--Les jointures externes, ont une complexité plus élevée que les jointures internes.
--Elles peuvent nécessiter le traitement de plus de données, surtout si la plupart des lignes des tables ne correspondent pas.

--Produit Cartésien avec Restriction :
--Normalement le produit cartésien a une complexité élevée car il produit toutes les combinaisons possibles de lignes entre les tables.
--Bien que la restriction réduise le nombre de résultats
--Dans notre cas on a trouvé que la moyenne du temp d'éxecution des requetes du produit cartésien avec restriction est le minimale 

---------------------------------------------------------------------------------------------------------------------
--question 3

--requete Union : Afficher les récompenses du Festival de Cannes et du Festival de Venise :

--Utilité : Elle est utile pour obtenir une vue consolidée des récompenses remises lors de ces deux festivals, ce qui peut être 
--important pour les analyses comparatives et l'évaluation des performances des participants.

    select recompense_nom,ceremonie_nom,ceremonie_pays,ceremonie_description
    from P02_recompense natural join P02_ceremonie
    where ceremonie_nom='Festival de Cannes'
    UNION
    select recompense_nom,ceremonie_nom,ceremonie_pays,ceremonie_description
    from P02_recompense natural join P02_ceremonie
    where ceremonie_nom='Festival de Venise';

--requete Intersect : Afficher les individus qui ont remporté à la fois un Oscar et un Golden Globe. Dans le cas d'un réalisateur, cela inclut la possibilité que le film lui-même ait remporté la catégorie "Meilleur film"

--Utilité : Elle est utile pour identifier les individus ayant reçu des récompenses prestigieuses à la fois aux Oscars et aux Golden Globes. 
--Cela pourrait être pertinent pour évaluer la reconnaissance et le succès des participants dans différentes cérémonies.*/

SELECT individu_nom, individu_prenom
FROM P02_individu natural join P02_nomination natural join P02_recompense natural join P02_ceremonie
WHERE ceremonie_nom='Oscar(Academy Awards)' and statut='gagnant'
INTERSECT
SELECT individu_nom, individu_prenom
FROM P02_individu natural join P02_nomination natural join P02_recompense natural join P02_ceremonie
WHERE ceremonie_nom='Golden Globe'and statut='gagnant' ;

--requete Except : Liste des récompenses anuelles attribuées au cours des cérémonies en France

--Utilité : Elle est utile pour isoler les récompenses attribuées lors des cérémonies annuelles en France, 
--fournissant une vue spécifique des distinctions décernées dans ce contexte.

SELECT recompense_nom, ceremonie_nom
FROM P02_recompense NATURAL JOIN P02_ceremonie
where ceremonie_pays='France'
EXCEPT
SELECT recompense_nom, ceremonie_nom
FROM P02_recompense NATURAL JOIN P02_ceremonie
WHERE ceremonie_type = 'Festival';
-------------------------------------------------------------------------------------------
--question 4

--a-Une sous-requête dans la clause WHERE via l'opérateur =
--Affiche une liste des récompences attribuées lors de la céremonie Bafta

select * from P02_recompense
where ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Bafta');

--b-une sous-requête dans la clause WHERE via l'opérateur IN (et nécessitant cet opérateur)
--Affiche une liste de tous les realisiteurs qui sont nominés

select * from P02_individu
where individu_id in(select individu_id from P02_nomination natural join P02_recompense where recompense_nom='meilleur realisateur');

--c-une sous requête dans la clause FROM
--Affiche les individus ayant été nominés pour des récompenses individuelles.

select distinct individu_nom,individu_prenom,recompense_nom,ceremonie_nom,statut,annee_remise
from (select individu_nom,individu_prenom,recompense_nom,ceremonie_nom,statut,annee_remise
      from P02_nomination natural join P02_individu natural join P02_recompense natural join P02_ceremonie
       where recompense_nom not like '%meilleur film%')
       as maTable;

--d-une sous requete imbrique
--  Affiche les informations des nominés pour une récompence dont le nom commence par meilleur actrice (comme meilleur actrice second role)

select   * from P02_individu
where individu_id in (select individu_id from P02_nomination where recompense_id in (select recompense_id from P02_recompense where recompense_nom like 'meilleur actrice%'));
-

--e-Une sous-requête synchronisée
--affiche tous les individus gagnants en 2017

SELECT individu_id, individu_nom, individu_prenom
FROM P02_individu
WHERE EXISTS (
    SELECT 1
    FROM P02_nomination
    WHERE P02_nomination.individu_id = P02_individu.individu_id
    AND statut = 'gagnant' and annee_remise =2017
);
--f-une sous-requêtes utilisant un opérateur de comparaison combiné ANY
-- Affiche les films qui ont gagné des récompense la meme année de leur création.

SELECT distinct  film_nom, film_annee,annee_remise
FROM P02_film natural join P02_nomination
WHERE film_annee =ANY (
    SELECT DISTINCT annee_remise
    FROM P02_nomination
    WHERE P02_nomination.film_id = P02_film.film_id) and recompense_id IN (select recompense_id from P02_recompense where recompense_nom like '%meilleur film%');

-- g Une sous-requête utilisant un opérateur de comparaison combiné ALL
-- Affiche l'individu le plus jeune enregistré dans notre base de données

select individu_prenom,individu_nom,individu_naissance
from P02_individu i1
where i1.individu_naissance > All (select individu_naissance from P02_individu i2 where i1.individu_naissance<>i2.individu_naissance);
-----------------------------------------------------------------------------------------------------------------------

--question 5 

--Affiche la liste des individus qui ont déja gagné le prix du meilleur costume de César

--Par jointure
select individu_nom,individu_prenom
from P02_individu
join P02_nomination P02n on P02_individu.individu_id = P02n.individu_id
join P02_recompense P02r on P02n.recompense_id = P02r.recompense_id
join P02_ceremonie P02c on P02c.ceremonie_id = P02r.ceremonie_id
where  recompense_nom='meilleur costume' and ceremonie_nom='César' and statut='gagnant';

--Par sous requete
select individu_nom,individu_prenom
from P02_individu where individu_id in(select individu_id
   from P02_nomination where statut='gagnant' and recompense_id=(select recompense_id
         from P02_recompense where recompense_nom='meilleur costume' and ceremonie_id=(select ceremonie_id
           from P02_ceremonie where ceremonie_nom='César')));

--Les deux requêtes sont équivalentes en termes de résultats
--mais la première requête avec la jointure est  plus efficace en termes de performances car la sous-requête doit être évaluée pour chaque ligne retournée
-----------------------------------------------------------------------------------------------

--question 6- Deux requêtes différentes utilisant les fonctions d'agrégation SQL

--requete1 : Affiche le nombre des films dont la date de sortie est entre 2000 et 2015

    select count(*) from P02_film where film_annee between 2000 and 2015;

--requete2 :Affiche la moyenne d'age des individus 

SELECT AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM individu_naissance)) AS moyenne_age
FROM P02_individu;
------------------------------------------------------------------------------------------------------
--question 7-Deux Requêtes avec les Fonctions d'Agrégation et la Clause GROUP BY

--Requete 1 : Affiche le nombre de nominations par film

SELECT P02_film.film_nom, COUNT(P02_nomination.film_id) AS NombreDeNominations
FROM P02_film
LEFT JOIN P02_nomination ON P02_film.film_id = P02_nomination.film_id
where recompense_id in (select recompense_id from P02_recompense where recompense_nom like '%meilleur film%')
GROUP BY P02_film.film_nom;

--Requete 2 :Affiche a première année et la dérnière année d'organisation de chaque céremonie .

SELECT P02_ceremonie.ceremonie_nom, MIN(P02_nomination.annee_remise) AS MinAnneeRemise, MAX(P02_nomination.annee_remise) AS MaxAnneeRemise
FROM P02_nomination
JOIN P02_recompense ON P02_nomination.recompense_id = P02_recompense.recompense_id
JOIN P02_ceremonie ON P02_recompense.ceremonie_id = P02_ceremonie.ceremonie_id
GROUP BY P02_ceremonie.ceremonie_id, P02_ceremonie.ceremonie_nom;
-----------------------------------------------------------------------------------------

--question 8-Deux Exemples de Mise en Œuvre de la Clause HAVING

-- Requete 1 : Affiche une liste des céremonie qui ont au moins trois récompenses


SELECT P02_ceremonie.ceremonie_nom, COUNT(P02_recompense.recompense_id) AS NombreDeRecompense
FROM P02_ceremonie
LEFT JOIN P02_recompense ON P02_ceremonie.ceremonie_id = P02_recompense.ceremonie_id
GROUP BY P02_ceremonie.ceremonie_nom
HAVING COUNT(P02_recompense.recompense_id) > 3;

--Requête 2- Affiche les catégories de Récompenses avec Plus de Deux Lauréats

SELECT P02_recompense.recompense_nom, COUNT(DISTINCT P02_nomination.individu_id) + COUNT(DISTINCT P02_nomination.film_id) AS NombreDeLauréats
FROM P02_recompense
LEFT JOIN P02_nomination ON P02_recompense.recompense_id = P02_nomination.recompense_id
WHERE P02_nomination.statut = 'gagnant'
GROUP BY P02_recompense.recompense_nom
HAVING COUNT(DISTINCT P02_nomination.individu_id) + COUNT(DISTINCT P02_nomination.film_id) > 2;

--------------------------------------------------------------------------------------------------------------------------------------
--question 9 :  Requête Associant des Informations de Deux Enregistrements Différents d'une Même Table

--nous allons utiliser une jointure autorejointe.Nous associerons sur la même ligne les informations de deux individus ayant la même nationalité
--Dans cette requête, la table P02_Individu est jointe à elle-même (a et b sont des alias pour deux occurrences différentes de la même table) sur la base de la colonne individu_nationalite. 
--La condition a.individu_id < b.individu_id est utilisée pour éviter les doublons et l'auto-association

SELECT a.individu_nom AS nom_1,
    a.individu_prenom AS prenom_1,
    a.individu_nationalite AS nationalite,
    b.individu_nom AS nom_2,
    b.individu_prenom AS prenom_2
FROM
    P02_individu a
JOIN
    P02_individu b ON a.individu_nationalite = b.individu_nationalite
WHERE
    a.individu_id < b.individu_id;

