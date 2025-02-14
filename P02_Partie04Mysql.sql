/*-------------------------- étape 04 (ORACLE)-----------------------------*/
/*--------VUES-------*/

/*Vue 1*/
/* Création de la vue P02_Les_gagnants*/
/*Cette vue extrait des informations sur les individus gagnants de récompenses, à l'exception de celles liées au "meilleur film".*/

create view P02_Les_gagnants(individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut) AS
    select individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut
from P02_individu inner join P02_nomination on P02_individu.individu_id = P02_nomination.individu_id
    inner join P02_film on P02_nomination.film_id = P02_film.film_id
    inner join P02_recompense on P02_nomination.recompense_id = P02_recompense.recompense_id
    inner join P02_ceremonie on P02_recompense.ceremonie_id = P02_ceremonie.ceremonie_id
where recompense_nom not like '%meilleur film%' and statut='gagnant'
order by annee_remise ASC;
select* from Les_gagnants;

/*Vue 2 : Création de la vue P02_Nomination_film.
La vue P02_Nomination_film fournit une perspective focalisée sur les films ayant remporté le prix du "meilleur film" lors de cérémonies spécifiques.*/

create view P02_Nomination_film(film_nom,realisateur_nom,realisateur_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut) As
    select film_nom,individu_nom,individu_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut
from P02_film inner join P02_nomination on P02_film.film_id = P02_nomination.film_id
inner join P02_individu on P02_nomination.individu_id = P02_individu.individu_id
inner join P02_recompense on P02_nomination.recompense_id = P02_recompense.recompense_id
inner join P02_ceremonie on P02_recompense.ceremonie_id = P02_ceremonie.ceremonie_id
where recompense_nom like '%meilleur film%' ;

/*Vue 3 :  Création de la vue P02_PrixByCeremonie*/
/*la vue P02_PrixByCeremonie offre un apperçu des recompenses de chaque céremonie*/

create view P02_PrixByCeremonie(NomPrix,NomCeremonie,PremiereEdition,Type,Pays) AS
    select recompense_nom,ceremonie_nom,ceremonie_annee_creation,ceremonie_type,ceremonie_pays
from P02_recompense inner join P02_ceremonie on P02_recompense.ceremonie_id = P02_ceremonie.ceremonie_id;
