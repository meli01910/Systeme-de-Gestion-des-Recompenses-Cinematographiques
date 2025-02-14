
/*creation de la table film*/
create  table  P02_film(film_id serial PRIMARY KEY,
                       film_nom varchar(100) not null,
                       film_annee integer not null
                       );
/*creation de la table individu*/

create  table  P02_individu(
			    individu_id serial PRIMARY KEY,
                            individu_nom varchar(30) not null ,
                            individu_prenom varchar(30) not null ,
                            individu_nationalite varchar(30) not null,
                            individu_naissance date
			 );

/*creation de la table ceremonie*/

create  table  P02_ceremonie(
			    ceremonie_id serial PRIMARY KEY,
                            ceremonie_nom varchar(100) not null ,
			    ceremonie_pays VARCHAR(30),
                            ceremonie_type varchar(30) not null check ( ceremonie_type in ('Festival','Annuelle') ),
                            ceremonie_description varchar(255) not null,
			    ceremonie_annee_creation integer
			   );

/*creation de la table recompense*/

create  table  P02_recompense(
			    recompense_id serial primary key ,
                            recompense_nom varchar(100) not null ,
                            ceremonie_id integer not null,
                            foreign key (ceremonie_id) references P02_ceremonie(ceremonie_id)
			   );

/*creation de la table nomination*/

create  table  P02_nomination(
			    nomination_id serial ,
                            film_id integer not null ,
                            individu_id integer not null ,
                            recompense_id integer not null,
			    annee_remise integer not null,
                            statut varchar(8) not null check (statut in ('nomme','gagnant')),
                            foreign key (film_id) references P02_film(film_id),
                            foreign key (individu_id) references P02_individu(individu_id),
                            foreign key (recompense_id) references P02_recompense(recompense_id)
			    );
--insertion des films
INSERT INTO P02_film(film_nom,film_annee)
              VALUES ('Titanic',1998),
                     ('Chicago',2002),
                     ('La Nuit du 12',2022),
                     ('Une place au soleil',1951),
                     ('Avtar',2022),
                     ('Boulevard du crépuscule',1950),
                     ('pour le pire et le meilleur',1997),
                     ('le loup de Wall Street',2013),
                     ('Mon trésor',2004),
                     ('Three Billboards',2017),
                     ('Amour',2012),
                     ('Joker',2019),
                     ('La bonne épouse',2020),
                     ('La douleur',2017);

--insertion des individus

INSERT  INTO P02_individu(individu_nom,individu_prenom,individu_nationalite,individu_naissance)
                VALUES('James','Cameron','Canadien','1954-08-16'),
                      ('Helen', 'Hunt','Américaine','1963-06-15'),
                      ('Zeta-Jones','Cathrine','Britanique','1969-09-25'),
                      ('Dominik','Moll','Allemande','1962-05-07'),
                      ('C.Mellor','William','Américain','1903-06-29'),
                      ('Franz','Waxman','Allemande','1906-12-24'),
                      ('Leonardo','Dicaprio','Américain','1974-11-11'),
                      ('McDonagh','Martin','britannique','1970-03-26'),
                      ('Yedaya','Keren','Américaine','1972-11-23'),
                      ('Michael','Haneke','Allemande','1942-03-23'),
                      ('Phillips','Todd','Américain','1970-12-20'),
                      ('Fontaine','Madeline','Française','1960-01-01'),
                      ('Ballo','Sergio','Italien','1965-02-21'),
                      ('Barthélémy','Michel','Française','1972-08-16');

--insertion des céremonies

INSERT INTO P02_ceremonie (ceremonie_nom,ceremonie_type, ceremonie_pays,ceremonie_description, ceremonie_annee_creation)
              VALUES('Oscar(Academy Awards)','Annuelle','Etats-Unis','Récompense d''excellence dans l''industrie du cinéma international',1929),
                    ('César','Annuelle','France','Récompense d''excellence des productions cinématographiques françaises',1976),
                    ('Bafta','Annuelle','Royaume-uni','British academy film and television arts',1947),
                    ('Golden Globe','Annuelle','Etats-Unis','Récompense des meilleures oeuvre et professionels du cinéma et de la télévision',1944),
                    ('Festival de Cannes','Festival','France','festival international du cinéma',1939),
                    ('Festival de Venise','Festival','Italie','nommé également ''Mostra de Venise'' ',1951);

--insertion des récompenses

Insert Into P02_recompense (recompense_nom, ceremonie_id)
            VALUES ('meilleur film',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)')),
                   ('meilleur realisateur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)')),
                   ('meilleur actrice',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)')),
                   ('meilleur acteur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)')),
                   ('meilleur photographie',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)')),
                   ('meilleur musique',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)')),
                   ('meilleur film',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César')),
                   ('meilleur realisateur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César')),
                   ('meilleur film',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Golden Globe')),
                   ('meilleur actrice',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Golden Globe')),
                   ('meilleur musique',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Golden Globe')),
                   ('meilleur realisateur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Golden Globe')),
                   ('meilleur actrice second role',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Bafta')),
                   ('meilleur acteur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Bafta')),
                   ('Palme d''Or (meilleur film)',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Cannes')),
                   ('Camera d''Or',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Cannes')),
                   ('Prix Orsella (meilleur scénario)',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Venise')),
                   ('Lion d''Or (meilleur film)',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Venise')),
                   ('meilleur realisateur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Bafta')),
                   ('meilleur costume',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César')),
                   ('meilleur décor',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César'));

-- insertion des nominations
Insert into P02_nomination(film_id, individu_id, recompense_id, annee_remise,statut)
                  VALUES((select film_id from P02_film where film_nom='Titanic'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur film' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1998,'gagnant'),
                        ((select film_id from P02_film where film_nom='Titanic'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur film' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),1998,'gagnant'),
                        ((select film_id from P02_film where film_nom='Titanic'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1998,'gagnant'),
                        ((select film_id from P02_film where film_nom='Titanic'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),1998,'gagnant'),
                        ((select film_id from P02_film where film_nom='Avtar'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),2023,'nomme'),
                        ((select film_id from P02_film where film_nom='pour le pire et le meilleur'),(select individu_id from P02_individu where individu_nom='Helen' and individu_prenom='Hunt'),(select recompense_id from P02_recompense where recompense_nom='meilleur actrice' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1998,'gagnant'),
                        ((select film_id from P02_film where film_nom='Chicago'),(select individu_id from P02_individu where individu_nom='Zeta-Jones' and individu_prenom='Cathrine'),(select recompense_id from P02_recompense where recompense_nom='meilleur actrice second role' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Bafta')),2003,'gagnant'),
                        ((select film_id from P02_film where film_nom='Chicago'),(select individu_id from P02_individu where individu_nom='Zeta-Jones' and individu_prenom='Cathrine'),(select recompense_id from P02_recompense where recompense_nom='meilleur actrice' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),2003,'nomme'),
                        ((select film_id from P02_film where film_nom='La Nuit du 12'),(select individu_id from P02_individu where individu_nom='Dominik' and individu_prenom='Moll'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2023,'nomme'),
                        ((select film_id from P02_film where film_nom='La Nuit du 12'),(select individu_id from P02_individu where individu_nom='Dominik' and individu_prenom='Moll'),(select recompense_id from P02_recompense where recompense_nom='meilleur film' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2023,'gagnant'),
                        ((select film_id from P02_film where film_nom='Une place au soleil'),(select individu_id from P02_individu where individu_nom='C.Mellor' and individu_prenom='William'),(select recompense_id from P02_recompense where recompense_nom='meilleur photographie' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1952,'gagnant'),
                        ((select film_id from P02_film where film_nom='Boulevard du crépuscule'),(select individu_id from P02_individu where individu_nom='Franz' and individu_prenom='Waxman'),(select recompense_id from P02_recompense where recompense_nom='meilleur musique' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),1951,'gagnant'),
                        ((select film_id from P02_film where film_nom='Une place au soleil'),(select individu_id from P02_individu where individu_nom='Franz' and individu_prenom='Waxman'),(select recompense_id from P02_recompense where recompense_nom='meilleur musique' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1952,'gagnant'),
                        ((select film_id from P02_film where film_nom='le loup de Wall Street'),(select individu_id from P02_individu where individu_nom='Leonardo' and individu_prenom='Dicaprio'),(select recompense_id from P02_recompense where recompense_nom='meilleur acteur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),2014,'nomme'),
                        ((select film_id from P02_film where film_nom='Three Billboards'),(select individu_id from P02_individu where individu_nom='McDonagh' and individu_prenom='Martin'),(select recompense_id from P02_recompense where recompense_nom='Prix Orsella (meilleur scénario)' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Venise')),2017,'gagnant'),
                        ((select film_id from P02_film where film_nom='Mon trésor'),(select individu_id from P02_individu where individu_nom='Yedaya' and individu_prenom='Keren'),(select recompense_id from P02_recompense where recompense_nom='Camera d''Or' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Cannes')),2004,'gagnant'),
                        ((select film_id from P02_film where film_nom='Amour'),(select individu_id from P02_individu where individu_nom='Michael' and individu_prenom='Haneke'),(select recompense_id from P02_recompense where recompense_nom='Palme d''Or (meilleur film)' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Cannes')),2012,'gagnant'),
                        ((select film_id from P02_film where film_nom='Joker'),(select individu_id from P02_individu where individu_nom='Phillips' and individu_prenom='Todd'),(select recompense_id from P02_recompense where recompense_nom='Lion d''Or (meilleur film)' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Venise')),2019,'gagnant'),
                        ((select film_id from P02_film where film_nom='Joker'),(select individu_id from P02_individu where individu_nom='Phillips' and individu_prenom='Todd'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Bafta')),2020,'nomme'),
                        ((select film_id from P02_film where film_nom='La bonne épouse'),(select individu_id from P02_individu where individu_nom='Fontaine' and individu_prenom='Madeline'),(select recompense_id from P02_recompense where recompense_nom='meilleur costume' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2021,'gagnant'),
                        ((select film_id from P02_film where film_nom='La douleur'),(select individu_id from P02_individu where individu_nom='Ballo' and individu_prenom='Sergio'),(select recompense_id from P02_recompense where recompense_nom='meilleur costume' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2019,'nomme'),
                        ((select film_id from P02_film where film_nom='La Nuit du 12'),(select individu_id from P02_individu where individu_nom='Barthélémy' and individu_prenom='Michel'),(select recompense_id from P02_recompense where recompense_nom='meilleur décor' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2023,'nomme');
--Création de la première vue

create view P02_Les_gagnants(individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut) AS
    select individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut
from P02_Individu inner join P02_Nomination on P02_Individu.individu_id = P02_Nomination.individu_id
    inner join P02_FILM on P02_Nomination.film_id = P02_FILM.film_id
    inner join P02_Recompense on P02_Nomination.recompense_id = P02_Recompense.recompense_id
    inner join P02_Ceremonie on P02_Recompense.ceremonie_id = P02_Ceremonie.ceremonie_id
where recompense_nom not like '%meilleur film%' and statut='gagnant'
order by annee_remise ASC;
select* from P02_Les_gagnants;

--Création de la deuxième vue

create view P02_Nomination_film(film_nom,realisateur_nom,realisateur_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut) As
    select film_nom,individu_nom,individu_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut
from P02_FILM inner join P02_Nomination on P02_FILM.film_id = P02_Nomination.film_id
inner join P02_individu on P02_Nomination.individu_id = P02_individu.individu_id
inner join P02_Recompense on P02_Nomination.recompense_id = P02_Recompense.recompense_id
inner join P02_ceremonie on P02_Recompense.ceremonie_id = P02_ceremonie.ceremonie_id
where recompense_nom like '%meilleur film%' ;

--Création de la troisième vue

create view P02_PrixByCeremonie(NomPrix,NomCeremonie,PremiereEdition,Type,Pays) AS
    select recompense_nom,ceremonie_nom,ceremonie_annee_creation,ceremonie_type,ceremonie_pays
from P02_Recompense inner join P02_CEREMONIE on P02_Recompense.ceremonie_id = P02_CEREMONIE.ceremonie_id;

--Procedure
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
--Fonction

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
--Type(objet contenant le nom d'une recompense et la ceremonie 

CREATE TYPE P02_recompenseObjet AS (
    recompense_nom VARCHAR(100),
    ceremonie_nom VARCHAR(100)
);

--Function
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

--Function

CREATE OR REPLACE FUNCTION P02_film_entre(annee_inf INTEGER, annee_sup INTEGER)
RETURNS SETOF P02_FILM AS $$
DECLARE
    film_cursor CURSOR FOR
        SELECT * FROM P02_FILM WHERE film_annee BETWEEN annee_inf AND annee_sup;
    film_record P02_FILM;
BEGIN
    -- Vérifie si les années sont valides
    IF annee_inf > annee_sup THEN
        RAISE EXCEPTION 'Les années passées en paramètres sont erronées';
    END IF;

    -- Ouvre le curseur
    OPEN film_cursor;

    -- Itère à travers les résultats et renvoie chaque enregistrement
    LOOP
        FETCH film_cursor INTO film_record;
        EXIT WHEN NOT FOUND;

        -- Retourne l'enregistrement
        RETURN NEXT film_record;
    END LOOP;

    -- Ferme le curseur
    CLOSE film_cursor;
END;
$$ LANGUAGE plpgsql;

--Trigger1
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

CREATE TRIGGER P02_Majuscule
BEFORE INSERT OR UPDATE ON P02_INDIVIDU
FOR EACH ROW
EXECUTE FUNCTION P02_Majuscule();
--trigger2
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