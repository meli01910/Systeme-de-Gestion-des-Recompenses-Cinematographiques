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



--Vue 2 : Création de la vue P02_Nomination_film.
--La vue P02_Nomination_film fournit une perspective focalisée sur les films ayant remporté le prix du "meilleur film" lors de cérémonies spécifiques.

create view P02_Nomination_film(film_nom,realisateur_nom,realisateur_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut) As
    select film_nom,individu_nom,individu_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut
from P02_FILM inner join P02_Nomination on P02_FILM.film_id = P02_Nomination.film_id
inner join P02_individu on P02_Nomination.individu_id = P02_individu.individu_id
inner join P02_Recompense on P02_Nomination.recompense_id = P02_Recompense.recompense_id
inner join P02_ceremonie on P02_Recompense.ceremonie_id = P02_ceremonie.ceremonie_id
where recompense_nom like '%meilleur film%' ;



--Vue 3 :  Création de la vue P02_PrixByCeremonie
--la vue P02_PrixByCeremonie offre un apperçu des recompenses de chaque céremonie

create view P02_PrixByCeremonie(NomPrix,NomCeremonie,PremiereEdition,Type,Pays) AS
    select recompense_nom,ceremonie_nom,ceremonie_annee_creation,ceremonie_types,ceremonie_pays
from P02_Recompense inner join P02_CEREMONIE on P02_Recompense.ceremonie_id = P02_CEREMONIE.ceremonie_id;

---------------------FONCTIONS ET PROCEDURES PL/SQL------------------

--1 :une procédure permettant l'édition de données en fonctions de paramètres d'entrée
-- La procédure P02_RenommerIndividu permet de renommer un individu dans la table P02_INDIVIDU
    CREATE OR REPLACE PROCEDURE P02_RenommerIndividu(AncienNom VARCHAR,AncienPrenom VARCHAR,NouveauNom VARCHAR,NouveauPrenom VARCHAR) IS
    individu P02_INDIVIDU%rowtype;
BEGIN
    select *  into individu from P02_individu where individu_nom =AncienNom and individu_prenom = AncienPrenom;

  EXECUTE IMMEDIATE
    'UPDATE P02_INDIVIDU SET individu_nom = :new_nom, individu_prenom = :new_prenom ' ||
    'WHERE individu_nom = :ancien_nom AND individu_prenom = :ancien_prenom'
    USING NouveauNom, NouveauPrenom, AncienNom, AncienPrenom;
    EXCEPTION
when no_data_found then
	dbms_output.put_line('les anciens nom et prenom indiqué sont mal écrit ou n''existe pas ');
END;
    --Appelle de la procédure
    call P02_RenommerIndividu('brad','pitt','Angelina','Jolie');

--2 : Une fonction qui retourne une valeur simple.
-- La fonction P02_Nombre_Gagne retourne le nombre de récompenses gagnés par l'individu dont le nom est passé en paramètres

CREATE OR REPLACE FUNCTION P02_Nombre_Gagne(nom VARCHAR, prenom VARCHAR) RETURN INT IS
  absence EXCEPTION;
  nbGagne INT := 0;

BEGIN
  SELECT count(*) into nbGagne FROM P02_Les_gagnants WHERE individu_nom = nom AND individu_prenom = prenom ;
 if (nbGagne=0) then  raise absence; end if;
  return nbGagne;

EXCEPTION
  WHEN absence THEN
    DBMS_OUTPUT.PUT_LINE('Individu Absent');
    RETURN nbGagne;
END;
--Appel de la fonction
select P02_Nombre_Gagne('James','Cameron') from dual;


--3 :une fonction qui retourne un ensemble de valeurs.
--La fonction P02_RecompenseOfCeremonie retourne les recompenses attribuées lors de la céremonie passé en paramétre



 CREATE OR REPLACE  TYPE P02_recompenseObjet AS OBJECT(recompense_nom varchar2(100),ceremonie_nom varchar2(100));
CREATE OR REPLACE  TYPE P02_RECOMPENSESTABLE as TABLE OF P02_recompenseObjet;

create or replace function P02_RecompenseOfCeremonie(ceremonieNom varchar2) return P02_RECOMPENSESTABLE PIPELINED
IS
varRecompense P02_recompenseObjet:= P02_recompenseObjet(null, null);
invalid Exception ;
i int;
    Begin
        select count(*) into i from P02_PRIXBYCEREMONIE  where NomCeremonie=ceremonieNom;
        if i=0 then raise invalid;
        else
         FOR ligne IN (SELECT NomPrix,NomCeremonie FROM P02_PrixByCeremonie  WHERE NomCeremonie=ceremonieNom) LOOP
        varRecompense.recompense_nom := ligne.NomPrix;
        varRecompense.ceremonie_nom := ligne.NomCeremonie;
    PIPE ROW (varRecompense);
  END LOOP;
         end if;
         return ;
        EXCEPTION
    when invalid then
        DBMS_OUTPUT.PUT_LINE('Le nom de ceremonie passé en paramétre invalide ');
return ;
    end;


 select P02_RecompenseOfCeremonie('César') from dual;
--4 : Une procédure mettant en œuvre un curseur paramétrique.
--la procédure P02_FilmEntre affiche la liste des film dont l'année de sortie est entre les deux année passé en paramètres

create or replace PROCEDURE P02_FilmEntre(anneeInf Number,anneeSup Number)  IS
   NomFilm  P02_FILM.film_nom%type;
    Invalid Exception;
    nbFilm int;
    CURSOR curseur (annee1Film Number,annee2Film Number ) is select film_nom from P02_FILM where film_annee between annee1Film and annee2Film;     BEGIN
         select count(*) into nbFilm from P02_FILM where film_annee between anneeInf and anneeSup;
         if(anneeInf >anneeSup) then raise Invalid;

         else
             if(nbFilm=0) then
                  DBMS_OUTPUT.PUT_LINE('aucun film  ');
                 else
             open curseur(anneeInf,anneeSup);
             LOOP
                 fetch curseur into Nomfilm;

                exit when(curseur%notfound);
                  DBMS_OUTPUT.PUT_LINE(NomFilm ||'  ');
            END LOOP;
              close curseur;
             end if;
         end if;
    EXCEPTION
     WHEN Invalid then
    DBMS_OUTPUT.PUT_LINE('Les années passées en paramètres sont érronées');

     end;

    call P02_FilmEntre(2000,2017);

---------------------------TRIGGERS----------------------------------

--1-- Le trigger P02_trg_Majuscule met les noms en majuscule après insertion ou modifications
CREATE OR REPLACE TRIGGER P02_trg_Majuscule
BEFORE INSERT OR UPDATE ON P02_INDIVIDU
FOR EACH ROW
DECLARE
BEGIN

    IF INSERTING AND :new.individu_nom IS NOT NULL AND UPPER(:new.individu_nom) != :new.individu_nom THEN
        :new.individu_nom := UPPER(:new.individu_nom);
    ELSIF UPDATING AND :new.individu_nom IS NOT NULL AND UPPER(:new.individu_nom) != :new.individu_nom THEN
        :new.individu_nom := UPPER(:new.individu_nom);
    END IF;

    IF INSERTING AND :new.individu_prenom IS NOT NULL AND UPPER(:new.individu_prenom) != :new.individu_prenom THEN
        :new.individu_prenom := UPPER(:new.individu_prenom);
    ELSIF UPDATING AND :new.individu_prenom IS NOT NULL AND UPPER(:new.individu_prenom) != :new.individu_prenom THEN
        :new.individu_prenom := UPPER(:new.individu_prenom);
    END IF;
END;

--2--Le trigger P02_trg_nombre_nominations a pour objectif de calculer et d'afficher le nombre total de nominations pour chaque individu après une mise à jour dans la table P02_Nomination.
-- Le déclencheur est conçu pour être exécuté pour chaque instruction de mise à jour (FOR EACH STATEMENT) sur la table.

CREATE OR REPLACE TRIGGER P02_trg_nombre_nominations
AFTER UPDATE ON P02_Nomination
FOR EACH STATEMENT
DECLARE
    TYPE individu_id_list IS TABLE OF P02_Nomination.individu_id%TYPE;
    v_individu_ids individu_id_list := individu_id_list();
    v_individu_id P02_Nomination.individu_id%TYPE;
    v_nombre_nominations NUMBER;
    nom P02_INDIVIDU.individu_nom%type;
    prenom P02_INDIVIDU.individu_prenom%type;
BEGIN
    -- Stocke les individu_id affectés dans la variable de collection
    FOR rec IN (SELECT DISTINCT individu_id FROM P02_Nomination WHERE statut = 'gagnant') LOOP
        v_individu_ids.EXTEND;
        v_individu_ids(v_individu_ids.LAST) := rec.individu_id;
    END LOOP;

    -- Utilise la variable de collection pour accéder aux valeurs
    FOR i IN 1..v_individu_ids.COUNT LOOP
        v_individu_id := v_individu_ids(i);

        -- Obtient le nombre total de nominations pour l'individu
        SELECT COUNT(*) INTO v_nombre_nominations FROM P02_Nomination WHERE  individu_id = v_individu_id and recompense_id not in (select recompense_id from P02_Recompense where recompense_nom like '%meilleur film%');

        -- Affiche le nombre total de nominations pour l'individu
        select individu_nom,individu_prenom into nom,prenom from P02_Individu where individu_id=v_individu_id;
        DBMS_OUTPUT.PUT_LINE('Nombre de nominations pour ' || nom||' '||prenom || ' : ' || v_nombre_nominations);
    END LOOP;
END;