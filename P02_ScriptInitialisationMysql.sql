/*creation de la table P02_film*/
create  table  P02_film(film_id int auto_increment primary key ,
                       film_nom varchar(100) not null,
                        film_annee int not null
                       );
/*creation de la table P02_individu*/
create  table P02_individu(
			            individu_id int auto_increment  primary key ,
                        individu_nom varchar(30) not null ,
                        individu_prenom varchar(30) not null ,
                        individu_nationalite varchar(30) ,
                        individu_naissance date not null );

/*creation de la table P02_ceremonie*/

create  table P02_ceremonie(ceremonie_id int auto_increment  primary key,
                            ceremonie_nom varchar(100) not null ,
			                ceremonie_pays VARCHAR(30),
                            ceremonie_type varchar(30) not null check ( ceremonie_type in ('festival','annuelle') ),
                            ceremonie_description varchar(255),
			    ceremonie_annee_creation int  );

/*creation de la table P02_recompense*/

create  table P02_recompense(recompense_id int auto_increment  primary key ,
                            recompense_nom varchar(100) not null ,
                            ceremonie_id int not null,
                            foreign key (ceremonie_id) references P02_ceremonie(ceremonie_id) );

/*creation de la table P02_nomination*/

create  table  P02_nomination(
                            film_id int not null ,
                            individu_id int not null ,
                            recompense_id int not null,
			                annee_remise int not null,
                            statut varchar(8) not null check ( statut in ('nomme','gagnant')),
                            foreign key (film_id) references P02_film(film_id)  ,
                            foreign key (individu_id) references P02_individu(individu_id) ,
                            foreign key (recompense_id) references P02_recompense(recompense_id)
                            );

/*insertion des films*/
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

/*insertion des individus*/

INSERT  INTO P02_individu(individu_nom,individu_prenom,individu_nationalite,individu_naissance)
               VALUES ('James','Cameron','Canadien','1954-08-16'),
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

/*insertion des céremonies*/

INSERT INTO P02_ceremonie (ceremonie_nom,ceremonie_type, ceremonie_pays,ceremonie_description, ceremonie_annee_creation)
                    VALUES('Oscar(Academy Awards)','Annuelle','Etats-Unis','Récompense d''excellence dans l''industrie du cinéma international',1929),
                          ('César','Annuelle','France','Récompense d''excellence des productions cinématographiques françaises',1976),
                          ('Bafta','Annuelle','Royaume-uni','British academy film and television arts',1947),
                          ('Golden Globe','Annuelle','Etats-Unis','Récompense des meilleures oeuvre et professionels du cinéma et de la télévision',1944),
                          ('Festival de Cannes','Festival','France','festival international du cinéma',1939),
                          ('Festival de Venise','Festival','Italie','nommé également ''Mostra de Venise'' ',1951);

/*insertion des récompenses*/

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
                           ('Caméra d''Or',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Cannes')),
                           ('Prix Orsella (meilleur scénario)',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Venise')),
                           ('Lion d''Or (meilleur film)',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Festival de Venise')),
                           ('meilleur realisateur',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'Bafta')),
                           ('meilleur costume',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César')),
                           ('meilleur décor',(select ceremonie_id from P02_ceremonie where ceremonie_nom = 'César'));

/*insertion des nominations*/
Insert into P02_nomination(film_id, individu_id, recompense_id, annee_remise,statut) VALUES
                        ((select film_id from P02_film where film_nom='Titanic'),(select individu_id from P02_individu where individu_nom='James' and individu_prenom='Cameron'),(select recompense_id from P02_recompense where recompense_nom='meilleur film' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Oscar(Academy Awards)')),1998,'gagnant'),
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
                        ((select film_id from P02_film where film_nom='Mon trésor'),(select individu_id from P02_individu where individu_nom='Yedaya' and individu_prenom='Keren'),(select recompense_id from P02_recompense where recompense_nom='Caméra d''or' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Cannes')),2004,'gagnant'),
                        ((select film_id from P02_film where film_nom='Amour'),(select individu_id from P02_individu where individu_nom='Michael' and individu_prenom='Haneke'),(select recompense_id from P02_recompense where recompense_nom='Palme d''Or (meilleur film)' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Cannes')),2012,'gagnant'),
                        ((select film_id from P02_film where film_nom='Joker'),(select individu_id from P02_individu where individu_nom='Phillips' and individu_prenom='Todd'),(select recompense_id from P02_recompense where recompense_nom='Lion d''Or (meilleur film)' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Festival de Venise')),2019,'gagnant'),
                        ((select film_id from P02_film where film_nom='Joker'),(select individu_id from P02_individu where individu_nom='Phillips' and individu_prenom='Todd'),(select recompense_id from P02_recompense where recompense_nom='meilleur realisateur' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='Bafta')),2020,'nomme'),
                        ((select film_id from P02_film where film_nom='La bonne épouse'),(select individu_id from P02_individu where individu_nom='Fontaine' and individu_prenom='Madeline'),(select recompense_id from P02_recompense where recompense_nom='meilleur costume' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2021,'gagnant'),
                        ((select film_id from P02_film where film_nom='La douleur'),(select individu_id from P02_individu where individu_nom='Ballo' and individu_prenom='Sergio'),(select recompense_id from P02_recompense where recompense_nom='meilleur costume' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2019,'nomme'),
                        ((select film_id from P02_film where film_nom='La Nuit du 12'),(select individu_id from P02_individu where individu_nom='Barthélémy' and individu_prenom='Michel'),(select recompense_id from P02_recompense where recompense_nom='meilleur décor' and ceremonie_id=(select ceremonie_id from P02_ceremonie where ceremonie_nom='César')),2023,'nomme');
/*Création de la première vue*/

create view P02_Les_gagnants(individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut) AS
    select individu_nom,individu_prenom,recompense_nom,ceremonie_nom,film_nom,annee_remise,statut
from P02_individu inner join P02_nomination on P02_individu.individu_id = P02_nomination.individu_id
    inner join P02_film on P02_nomination.film_id = P02_film.film_id
    inner join P02_recompense on P02_nomination.recompense_id = P02_recompense.recompense_id
    inner join P02_ceremonie on P02_recompense.ceremonie_id = P02_ceremonie.ceremonie_id
where recompense_nom not like '%meilleur film%' and statut='gagnant'
order by annee_remise ASC;
select* from Les_gagnants;

/*Création de la deuxième vue*/

create view P02_Nomination_film(film_nom,realisateur_nom,realisateur_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut) As
    select film_nom,individu_nom,individu_prenom,film_annee,recompense_nom,ceremonie_nom,annee_remise,statut
from P02_film inner join P02_nomination on P02_film.film_id = P02_nomination.film_id
inner join P02_individu on P02_nomination.individu_id = P02_individu.individu_id
inner join P02_recompense on P02_nomination.recompense_id = P02_recompense.recompense_id
inner join P02_ceremonie on P02_recompense.ceremonie_id = P02_ceremonie.ceremonie_id
where recompense_nom like '%meilleur film%' ;

/*Création de la troisième vue*/

create view P02_PrixByCeremonie(NomPrix,NomCeremonie,PremiereEdition,Type,Pays) AS
    select recompense_nom,ceremonie_nom,ceremonie_annee_creation,ceremonie_type,ceremonie_pays
from P02_recompense inner join P02_ceremonie on P02_recompense.ceremonie_id = P02_ceremonie.ceremonie_id;

