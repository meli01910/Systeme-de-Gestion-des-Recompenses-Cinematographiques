-- Création des séquences pour les ID des tables Film, Individu, Recompense et Ceremonie
CREATE SEQUENCE film_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE individu_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE recompense_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE ceremonie_id_seq START WITH 1 INCREMENT BY 1;

-- Création de la table Film
CREATE TABLE P02_Film (
    film_id Integer  DEFAULT film_id_seq.nextval PRIMARY KEY,
    film_nom VARCHAR(100) NOT NULL,
    film_annee NUMBER NOT NULL
);
-- Création de la table Individu
CREATE TABLE P02_Individu (
    individu_id Integer DEFAULT individu_id_seq.NEXTVAL PRIMARY KEY,
    individu_nom VARCHAR(30) NOT NULL,
    individu_prenom VARCHAR(30) NOT NULL,
    individu_nationalite VARCHAR2(30),
    individu_naissance DATE
);

-- Création de la table Ceremonie
CREATE TABLE P02_Ceremonie (
    ceremonie_id integer DEFAULT ceremonie_id_seq.NEXTVAL PRIMARY KEY,
    ceremonie_nom VARCHAR(100) NOT NULL,
    ceremonie_pays VARCHAR(30),
    ceremonie_types VARCHAR(14) NOT NULL CHECK (ceremonie_types IN ('Festival', 'Annuelle')),
    ceremonie_description VARCHAR2(255),
    ceremonie_annee_creation NUMBER
);

-- Création de la table Recompense
CREATE TABLE P02_Recompense (
    recompense_id integer DEFAULT recompense_id_seq.NEXTVAL PRIMARY KEY,
    recompense_nom VARCHAR(100) NOT NULL,
    ceremonie_id integer NOT NULL,
    FOREIGN KEY (ceremonie_id) REFERENCES P02_Ceremonie(ceremonie_id)
);

-- Création de la table Nomination
CREATE TABLE P02_Nomination (
    recompense_id integer,
    film_id integer,
    individu_id integer,
    annee_remise NUMBER NOT NULL,
    statut VARCHAR2(8) NOT NULL CHECK (statut IN ('nomme', 'gagnant')),
    PRIMARY KEY (recompense_id, film_id, individu_id),
    FOREIGN KEY (recompense_id) REFERENCES P02_Recompense(recompense_id),
    FOREIGN KEY (film_id) REFERENCES P02_Film(film_id),
    FOREIGN KEY (individu_id) REFERENCES P02_Individu(individu_id)
);

--insertion des film

INSERT INTO P02_film(film_nom, film_annee) VALUES ( 'Titanic', 1998);
INSERT INTO P02_film(film_nom, film_annee) VALUES ( 'Chicago', 2002);
INSERT INTO P02_film(film_nom, film_annee) VALUES ( 'La Nuit du 12', 2022);
INSERT INTO P02_film(film_nom, film_annee) VALUES ( 'Une place au soleil', 1951);
INSERT INTO P02_film(film_nom, film_annee) VALUES ('Avtar', 2022);
INSERT INTO P02_film (film_nom, film_annee)VALUES ( 'Boulevard du crépuscule', 1950);
INSERT INTO P02_film (film_nom, film_annee)VALUES ('pour le pire et le meilleur', 1997);
INSERT INTO P02_film (film_nom, film_annee)VALUES ('le loup de Wall Street', 2013);
INSERT INTO P02_film (film_nom, film_annee)VALUES ('Mon trésor', 2004);
INSERT INTO P02_film (film_nom, film_annee)VALUES ('Three Billboards', 2017);
INSERT INTO P02_film(film_nom, film_annee) VALUES ('Amour', 2012);
INSERT INTO P02_film(film_nom, film_annee) VALUES('Joker',2019);
INSERT INTO P02_film(film_nom, film_annee)VALUES('La bonne épouse',2020);
INSERT INTO P02_film(film_nom, film_annee)VALUES ('La douleur',2017);

--insertion des individus

INSERT INTO P02_Individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance) VALUES('James','Cameron','Canadien',TO_DATE('1954-08-16', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES('Helen', 'Hunt','Américaine',TO_DATE('1963-06-15', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES('Zeta-Jones','Cathrine','Britanique',TO_DATE('1969-09-25', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES('Dominik','Moll','Allemande',TO_DATE('1962-05-07', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES('C.Mellor','William','Américain',TO_DATE('1903-06-29', 'YYYY-MM-DD'));
INSERT INTO P02_individu(individu_nom, individu_prenom, individu_nationalite, individu_naissance) VALUES('Franz','Waxman','Allemande',TO_DATE('1906-12-24', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES   ('Leonardo','Dicaprio','Américain',TO_DATE('1974-11-11', 'YYYY-MM-DD'));
INSERT INTO P02_individu(individu_nom, individu_prenom, individu_nationalite, individu_naissance) VALUES('McDonagh','Martin','britannique',TO_DATE('1970-03-26', 'YYYY-MM-DD'));
INSERT INTO P02_individu(individu_nom, individu_prenom, individu_nationalite, individu_naissance) VALUES ('Yedaya','Keren','Américaine',TO_DATE('1972-11-23', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES('Michael','Haneke','Allemande',TO_DATE('1942-03-23', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES('Phillips','Todd','Américain',TO_DATE('1970-12-20', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES ('Fontaine','Madeline','Française',TO_DATE('1960-01-01', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES('Ballo','Sergio','Italien',TO_DATE('1965-02-21', 'YYYY-MM-DD'));
INSERT INTO P02_individu (individu_nom, individu_prenom, individu_nationalite, individu_naissance)VALUES('Barthélémy','Michel','Française',TO_DATE('1972-08-16', 'YYYY-MM-DD'));

--insertion des ceremonies

INSERT INTO P02_ceremonie(ceremonie_nom, ceremonie_types, ceremonie_pays, ceremonie_description, ceremonie_annee_creation) VALUES('Oscar(Academy Awards)','Annuelle','Etats-Unis','Récompense d''excellence dans l''industrie du cinéma international',1929);
INSERT INTO P02_ceremonie(ceremonie_nom, ceremonie_types, ceremonie_pays, ceremonie_description, ceremonie_annee_creation)  VALUES('César','Annuelle','France','Récompense d''excellence des productions cinématographiques françaises',1976);
INSERT INTO P02_ceremonie (ceremonie_nom, ceremonie_types, ceremonie_pays, ceremonie_description, ceremonie_annee_creation) VALUES ('Bafta','Annuelle','Royaume-uni','British academy film and television arts',1947);
INSERT INTO P02_ceremonie(ceremonie_nom, ceremonie_types, ceremonie_pays, ceremonie_description, ceremonie_annee_creation)  VALUES ('Golden Globe','Annuelle','Etats-Unis','Récompense des meilleures oeuvre et professionels du cinéma et de la télévision',1944);
INSERT INTO P02_ceremonie (ceremonie_nom, ceremonie_types, ceremonie_pays, ceremonie_description, ceremonie_annee_creation)VALUES  ('Festival de Cannes','Festival','France','festival international du cinéma',1939);
INSERT INTO P02_ceremonie(ceremonie_nom, ceremonie_types, ceremonie_pays, ceremonie_description, ceremonie_annee_creation) VALUES  ('Festival de Venise','Festival','Italie','nommé également ''Mostra de Venise'' ',1951);

--insertion des récompenses

Insert Into P02_recompense( recompense_nom, ceremonie_id)  VALUES ('meilleur film',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)'));
Insert Into P02_recompense( recompense_nom, ceremonie_id)  VALUES  ('meilleur realisateur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)'));
Insert Into P02_recompense( recompense_nom, ceremonie_id)   VALUES ('meilleur actrice',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id) VALUES ('meilleur acteur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)'));
Insert Into P02_recompense( recompense_nom, ceremonie_id)  VALUES  ('meilleur photographie',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id)  VALUES  ('meilleur musique',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Oscar(Academy Awards)'));
Insert Into P02_recompense( recompense_nom, ceremonie_id)  VALUES  ('meilleur film',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id) VALUES  ('meilleur realisateur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id)  VALUES ('meilleur film',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Golden Globe'));
Insert Into P02_recompense  ( recompense_nom, ceremonie_id) VALUES ('meilleur actrice',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Golden Globe'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id) VALUES('meilleur musique',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Golden Globe'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id)  VALUES('meilleur realisateur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Golden Globe'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id) VALUES('meilleur actrice second role',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Bafta'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id)  VALUES ('meilleur acteur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Bafta'));
Insert Into P02_recompense  ( recompense_nom, ceremonie_id) VALUES  ('Palme d''Or (meilleur film)',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Cannes'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id)  VALUES ('Camera d''Or',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Cannes'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id) VALUES ('Prix Orsella (meilleur scénario)',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Venise'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id) VALUES('Lion d''Or (meilleur film)',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Venise'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id) VALUES('meilleur realisateur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Bafta'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id) VALUES('meilleur costume',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César'));
Insert Into P02_recompense ( recompense_nom, ceremonie_id) VALUES('meilleur décor',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César'));

--insertion des nominations

Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES((select film_id from P02_film where film_nom='Titanic'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur film' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1998,'gagnant');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES ((select film_id from P02_film where film_nom='Titanic'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur film' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),1998,'gagnant');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES((select film_id from P02_film where film_nom='Titanic'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1998,'gagnant');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES((select film_id from P02_film where film_nom='Titanic'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),1998,'gagnant');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES((select film_id from P02_film where film_nom='Avtar'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),2023,'nomme');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES ((select film_id from P02_film where film_nom='pour le pire et le meilleur'),(select individu_id from P02_individu where individu_nom='Helen' and individu_prenom='Hunt'),(select recompense_id from P02_recompense where recompense_nom='meilleur actrice' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1998,'gagnant');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES((select film_id from P02_film where film_nom='Chicago'),(select individu_id from P02_individu where individu_nom='Zeta-Jones' and individu_prenom='Cathrine'),(select recompense_id from P02_recompense where recompense_nom='meilleur actrice second role' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Bafta')),2003,'gagnant');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES ((select film_id from P02_film where film_nom='Chicago'),(select individu_id from P02_individu where individu_nom='Zeta-Jones' and individu_prenom='Cathrine'),(select recompense_id from P02_recompense where recompense_nom='meilleur actrice' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),2003,'nomme');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES ((select film_id from P02_film where film_nom='La Nuit du 12'),(select individu_id from P02_individu where individu_nom='Dominik' and individu_prenom='Moll'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2023,'nomme');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES ((select film_id from P02_film where film_nom='La Nuit du 12'),(select individu_id from P02_individu where individu_nom='Dominik' and individu_prenom='Moll'),(select recompense_id from P02_recompense where recompense_nom='meilleur film' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2023,'gagnant');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES((select film_id from P02_film where film_nom='Une place au soleil'),(select individu_id from P02_individu where individu_nom='C.Mellor' and individu_prenom='William'),(select recompense_id from P02_recompense where recompense_nom='meilleur photographie' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1952,'gagnant');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES((select film_id from P02_film where film_nom='Boulevard du crépuscule'),(select individu_id from P02_individu where individu_nom='Franz' and individu_prenom='Waxman'),(select recompense_id from P02_recompense where recompense_nom='meilleur musique' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Golden Globe')),1951,'gagnant');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES((select film_id from P02_film where film_nom='Une place au soleil'),(select individu_id from P02_individu where individu_nom='Franz' and individu_prenom='Waxman'),(select recompense_id from P02_recompense where recompense_nom='meilleur musique' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1952,'gagnant');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES((select film_id from P02_film where film_nom='le loup de Wall Street'),(select individu_id from P02_individu where individu_nom='Leonardo' and individu_prenom='Dicaprio'),(select recompense_id from P02_recompense where recompense_nom='meilleur acteur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),2014,'nomme');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES((select film_id from P02_film where film_nom='Three Billboards'),(select individu_id from P02_individu where individu_nom='McDonagh' and individu_prenom='Martin'),(select recompense_id from P02_recompense where recompense_nom='Prix Orsella (meilleur scénario)' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Venise')),2017,'gagnant');
Insert into P02_nomination( film_id, individu_id,recompense_id, annee_remise, statut) VALUES((select film_id from P02_film where film_nom='Mon trésor'),(select individu_id from P02_individu where individu_nom='Yedaya' and individu_prenom='Keren'),(select recompense_id from P02_recompense where recompense_nom='Camera d''Or' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Cannes')),2004,'gagnant');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES ((select film_id from P02_film where film_nom='Amour'),(select individu_id from P02_individu where individu_nom='Michael' and individu_prenom='Haneke'),(select recompense_id from P02_recompense where recompense_nom='Palme d''Or (meilleur film)' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Cannes')),2012,'gagnant');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES ((select film_id from P02_film where film_nom='Joker'),(select individu_id from P02_individu where individu_nom='Phillips' and individu_prenom='Todd'),(select recompense_id from P02_recompense where recompense_nom='Lion d''Or (meilleur film)' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Venise')),2019,'gagnant');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES ((select film_id from P02_film where film_nom='Joker'),(select individu_id from P02_individu where individu_nom='Phillips' and individu_prenom='Todd'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Bafta')),2020,'nomme');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES ((select film_id from P02_film where film_nom='La bonne épouse'),(select individu_id from P02_individu where individu_nom='Fontaine' and individu_prenom='Madeline'),(select recompense_id from P02_recompense where recompense_nom='meilleur costume' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2021,'gagnant');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES ((select film_id from P02_film where film_nom='La douleur'),(select individu_id from P02_individu where individu_nom='Ballo' and individu_prenom='Sergio'),(select recompense_id from P02_recompense where recompense_nom='meilleur costume' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2019,'nomme');
Insert into P02_nomination ( film_id, individu_id,recompense_id, annee_remise, statut)VALUES ((select film_id from P02_film where film_nom='La Nuit du 12'),(select individu_id from P02_individu where individu_nom='Barthélémy' and individu_prenom='Michel'),(select recompense_id from P02_recompense where recompense_nom='meilleur décor' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2023,'nomme');

--Création de la première vue :

create view P02_Les_gagnants(individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut) AS
    select individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut
from P02_Individu inner join P02_Nomination on P02_Individu.individu_id = P02_Nomination.individu_id
    inner join P02_FILM on P02_Nomination.film_id = P02_FILM.film_id
    inner join P02_Recompense on P02_Nomination.recompense_id = P02_Recompense.recompense_id
    inner join P02_Ceremonie on P02_Recompense.ceremonie_id = P02_Ceremonie.ceremonie_id
where recompense_nom not like '%meilleur film%' and statut='gagnant'
order by annee_remise ASC;

--Création de la deuxième vue

create view P02_Nomination_film(film_nom,realisateur_nom,realisateur_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut) As
    select film_nom,individu_nom,individu_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut
from P02_FILM inner join P02_Nomination on P02_FILM.film_id = P02_Nomination.film_id
inner join P02_individu on P02_Nomination.individu_id = P02_individu.individu_id
inner join P02_Recompense on P02_Nomination.recompense_id = P02_Recompense.recompense_id
inner join P02_ceremonie on P02_Recompense.ceremonie_id = P02_ceremonie.ceremonie_id
where recompense_nom like '%meilleur film%' ;

--Création de la troisième table

create view P02_PrixByCeremonie(NomPrix,NomCeremonie,PremiereEdition,Type,Pays) AS
    select recompense_nom,ceremonie_nom,ceremonie_annee_creation,ceremonie_types,ceremonie_pays
from P02_Recompense inner join P02_CEREMONIE on P02_Recompense.ceremonie_id = P02_CEREMONIE.ceremonie_id;

--Fonction
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

--Procédure

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
--Fonction

CREATE TYPE P02_recompenseObjet AS OBJECT(recompense_nom varchar2(100),ceremonie_nom varchar2(100));
CREATE TYPE P02_recompensesTable as TABLE OF recompenseObjet2;

create or replace FUNCTION P02_RecompenseOfCeremonie(ceremonieNom varchar2) return P02_recompensesTable  PIPELINED
IS
varRecompense P02_recompenseObjet := P02_recompenseObjet (null, null);
invalid Exception ;
i int;
    Begin
        select count(*) into i from  P02_PrixByCeremonie  where NomCeremonie=ceremonieNom;
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
--Fonction

create or replace PROCEDURE P02_FilmEntre(anneeInf Number,anneeSup Number)  IS
   NomFilm  P02_FILM.film_nom%type;
    Invalid Exception;
    nbFilm int;
    CURSOR curseur (annee1Film Number,annee2Film Number ) is select film_nom from P02_FILM where film_annee between annee1Film and annee2Film;


     BEGIN
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
--Trigger1

CREATE OR REPLACE TRIGGER P02_Majuscule
BEFORE INSERT OR UPDATE ON P02_INDIVIDU
FOR EACH ROW
DECLARE
BEGIN
    -- Vérifier et mettre en majuscules si nécessaire pour individu_nom
    IF INSERTING AND :new.individu_nom IS NOT NULL AND UPPER(:new.individu_nom) != :new.individu_nom THEN
        :new.individu_nom := UPPER(:new.individu_nom);
    ELSIF UPDATING AND :new.individu_nom IS NOT NULL AND UPPER(:new.individu_nom) != :new.individu_nom THEN
        :new.individu_nom := UPPER(:new.individu_nom);
    END IF;

    -- Vérifier et mettre en majuscules si nécessaire pour individu_prenom
    IF INSERTING AND :new.individu_prenom IS NOT NULL AND UPPER(:new.individu_prenom) != :new.individu_prenom THEN
        :new.individu_prenom := UPPER(:new.individu_prenom);
    ELSIF UPDATING AND :new.individu_prenom IS NOT NULL AND UPPER(:new.individu_prenom) != :new.individu_prenom THEN
        :new.individu_prenom := UPPER(:new.individu_prenom);
    END IF;
END;

--trigger2

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