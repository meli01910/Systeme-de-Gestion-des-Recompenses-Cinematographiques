-------------------------- étape 04 (ORACLE)-----------------------------
--------VUES-------

--Vue 1
-- Création de la vue P02_Les_gagnants
--Cette vue extrait des informations sur les individus gagnants de récompenses, à l'exception de celles liées au "meilleur film".

create view P02_Les_gagnants(individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut) AS
    select individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut
from P02_Individu inner join P02_Nomination on P02_Individu.individu_id = P02_Nomination.individu_id
    inner join P02_FILM on P02_Nomination.film_id = P02_FILM.film_id
    inner join P02_Recompense on P02_Nomination.recompense_id = P02_Recompense.recompense_id
    inner join P02_Ceremonie on P02_Recompense.ceremonie_id = P02_Ceremonie.ceremonie_id
where recompense_nom not like '%meilleur film%' and statut='gagnant'
order by annee_remise ASC;
select* from P02_Les_gagnants;



--Vue 2 : Création de la vue P02_Nomination_film.
--La vue P02_Nomination_film fournit une perspective focalisée sur les films ayant remporté le prix du "meilleur film" lors de cérémonies spécifiques.

create view P02_Nomination_film(film_nom,realisateur_nom,realisateur_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut) As
    select film_nom,individu_nom,individu_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut
from P02_FILM inner join P02_Nomination on P02_FILM.film_id = P02_Nomination.film_id
inner join P02_individu on P02_Nomination.individu_id = P02_individu.individu_id
inner join P02_Recompense on P02_Nomination.recompense_id = P02_Recompense.recompense_id
inner join P02_ceremonie on P02_Recompense.ceremonie_id = P02_ceremonie.ceremonie_id
where recompense_nom like '%meilleur film%' ;

 select * from P02_Nomination_film;

--Vue 3 :  Création de la vue P02_PrixByCeremonie
--la vue P02_PrixByCeremonie offre un apperçu des recompenses de chaque céremonie

create view P02_PrixByCeremonie(NomPrix,NomCeremonie,PremiereEdition,Type,Pays) AS
    select recompense_nom,ceremonie_nom,ceremonie_annee_creation,ceremonie_type,ceremonie_pays
from P02_Recompense inner join P02_CEREMONIE on P02_Recompense.ceremonie_id = P02_CEREMONIE.ceremonie_id;

select * from P02_PrixByCeremonie;


---------------------FONCTIONS ET PROCEDURES PL/SQL------------------

--1 :une procédure permettant l'édition de données en fonctions de paramètres d'entrée
-- La procédure P02_RenommerIndividu permet de renommer un individu dans la table P02_INDIVIDU


CREATE OR REPLACE PROCEDURE P02_RenommerIndividu(
    AncienNom VARCHAR,
    AncienPrenom VARCHAR,
    NouveauNom VARCHAR,
    NouveauPrenom VARCHAR
) AS $$
DECLARE
    individu P02_Individu%ROWTYPE;
BEGIN

    SELECT * INTO individu
    FROM P02_Individu
    WHERE individu_nom = AncienNom AND individu_prenom = AncienPrenom;


    IF FOUND THEN
        EXECUTE 'UPDATE P02_Individu SET individu_nom = $1, individu_prenom = $2 ' ||
                'WHERE individu_nom = $3 AND individu_prenom = $4'
        USING NouveauNom, NouveauPrenom, AncienNom, AncienPrenom;
        RAISE NOTICE 'Mise à jour effectuée avec succès.';
    ELSE
        RAISE NOTICE 'Les anciens nom et prénom indiqués sont mal écrits ou n''existent pas.';
    END IF;
END;
$$ LANGUAGE plpgsql;

    call P02_RenommerIndividu('brad','pitt','Angelina','Jolie');

--2 : Une fonction qui retourne une valeur simple.
-- La fonction P02_Nombre_Gagne retourne le nombre de récompenses gagnés par l'individu dont le nom est passé en paramètres

CREATE OR REPLACE FUNCTION P02_Nombre_Gagne(nom VARCHAR, prenom VARCHAR) RETURNS INT AS $$
DECLARE
  nbGagne INT := 0;
BEGIN

  SELECT count(*) INTO nbGagne FROM P02_Les_gagnants WHERE individu_nom = nom AND individu_prenom = prenom;


  IF nbGagne = 0 THEN
    RAISE EXCEPTION 'Individu Absent';
  END IF;

  RETURN nbGagne;
END;
$$ LANGUAGE plpgsql;

select P02_Nombre_Gagne('Helen','Hunt') ;


--3 :une fonction qui retourne un ensemble de valeurs.
--La fonction P02_RecompenseOfCeremonie retourne les recompenses attribuées lors de la céremonie passé en paramétre

CREATE TYPE P02_recompenseObjet AS (
    recompense_nom VARCHAR(100),
    ceremonie_nom VARCHAR(100)
);

CREATE OR REPLACE FUNCTION P02_RecompenseOfCeremonie(ceremonieNom VARCHAR(100))
RETURNS SETOF P02_recompenseObjet
AS $$
DECLARE
    varRecompense P02_recompenseObjet;
    i INT;
BEGIN
    SELECT COUNT(*) INTO i FROM P02_PrixByCeremonie WHERE NomCeremonie = ceremonieNom;

    IF i = 0 THEN
        RAISE EXCEPTION 'Le nom de ceremonie passé en paramètre est invalide';
    ELSE
        FOR varRecompense IN
            SELECT NomPrix, NomCeremonie
            FROM P02_PrixByCeremonie
            WHERE NomCeremonie = ceremonieNom
        LOOP
            RETURN NEXT varRecompense;
        END LOOP;
    END IF;

    RETURN;
END;
$$ LANGUAGE plpgsql;

select  P02_RecompenseOfCeremonie('César');


--4 : Une procédure mettant en œuvre un curseur paramétrique.
--la procédure P02_FilmEntre affiche la liste des film dont l'année de sortie est entre les deux année passé en paramètres


CREATE OR REPLACE FUNCTION P02_film_entre(annee_inf INTEGER, annee_sup INTEGER)
RETURNS SETOF P02_FILM AS $$
DECLARE
    film_cursor CURSOR FOR
        SELECT * FROM P02_FILM WHERE film_annee BETWEEN annee_inf AND annee_sup;
    film_record P02_FILM;
BEGIN

    IF annee_inf > annee_sup THEN
        RAISE EXCEPTION 'Les années passées en paramètres sont erronées';
    END IF;


    OPEN film_cursor;

    LOOP
        FETCH film_cursor INTO film_record;
        EXIT WHEN NOT FOUND;
        RETURN NEXT film_record;
    END LOOP;

    CLOSE film_cursor;
END;
$$ LANGUAGE plpgsql;

select P02_film_entre(2002,2010);

---------------------------TRIGGERS----------------------------------

--1-- Le trigger P02_Majuscule met les noms en majuscule après insertion ou modifications
CREATE OR REPLACE FUNCTION P02_Majuscule()
RETURNS TRIGGER AS $$
BEGIN

    IF TG_OP = 'INSERT' AND NEW.individu_nom IS NOT NULL AND UPPER(NEW.individu_nom) != NEW.individu_nom THEN
        NEW.individu_nom := UPPER(NEW.individu_nom);
    ELSIF TG_OP = 'UPDATE' AND NEW.individu_nom IS NOT NULL AND UPPER(NEW.individu_nom) != NEW.individu_nom THEN
        NEW.individu_nom := UPPER(NEW.individu_nom);
    END IF;

    -- Vérifier et mettre en majuscules si nécessaire pour individu_prenom
    IF TG_OP = 'INSERT' AND NEW.individu_prenom IS NOT NULL AND UPPER(NEW.individu_prenom) != NEW.individu_prenom THEN
        NEW.individu_prenom := UPPER(NEW.individu_prenom);
    ELSIF TG_OP = 'UPDATE' AND NEW.individu_prenom IS NOT NULL AND UPPER(NEW.individu_prenom) != NEW.individu_prenom THEN
        NEW.individu_prenom := UPPER(NEW.individu_prenom);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or replace TRIGGER P02_trg_Majuscule
BEFORE INSERT OR UPDATE ON P02_INDIVIDU
FOR EACH ROW
EXECUTE FUNCTION P02_Majuscule();

--2--Le trigger P02_trg_nombre_nominations a pour objectif de calculer et d'afficher le nombre total de nominations pour chaque individu après une mise à jour dans la table P02_Nomination.
-- Le déclencheur est conçu pour être exécuté pour chaque instruction de mise à jour (FOR EACH STATEMENT) sur la table.

CREATE OR REPLACE FUNCTION trg_nombre_nominations()
RETURNS TRIGGER AS $$
DECLARE
    v_individu_id INTEGER;
    v_nombre_nominations INTEGER;
    nom P02_INDIVIDU.individu_nom%TYPE;
    prenom P02_INDIVIDU.individu_prenom%TYPE;
    rec_temp RECORD;
BEGIN
    -- Stocke les individu_id affectés dans une table temporaire
    CREATE TEMP TABLE temp_individu_ids ON COMMIT DROP AS
    SELECT DISTINCT individu_id FROM P02_Nomination WHERE statut = 'gagnant';

    -- Utilise la table temporaire pour accéder aux valeurs
    FOR rec_temp IN SELECT * FROM temp_individu_ids LOOP
        v_individu_id := rec_temp.individu_id;

        -- Obtient le nombre total de nominations pour l'individu
        SELECT COUNT(*) INTO v_nombre_nominations FROM P02_Nomination
        WHERE individu_id = v_individu_id AND recompense_id NOT IN (SELECT recompense_id FROM P02_Recompense WHERE recompense_nom LIKE '%meilleur film%');

        -- Obtient le nom et le prénom de l'individu
        SELECT individu_nom, individu_prenom INTO nom, prenom FROM P02_Individu WHERE individu_id = v_individu_id;

        -- Affiche le nombre total de nominations pour l'individu
        RAISE NOTICE 'Nombre de nominations pour % % : %', nom, prenom, v_nombre_nominations;
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER P02_trg_nombre_nominations
AFTER UPDATE ON P02_Nomination
FOR EACH STATEMENT
EXECUTE FUNCTION trg_nombre_nominations();



