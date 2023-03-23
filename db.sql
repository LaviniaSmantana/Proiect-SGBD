DROP TABLE useri;
/
CREATE TABLE useri(
id_user number(5) PRIMARY KEY not null,
username varchar2(30),
password varchar(20),
name varchar2(20) not null,
email varchar2(30),
job varchar2(20),
home varchar2(50),
id_movie NUMBER(5),
date_rented VARCHAR2(30),
to_pay NUMBER(6) 
);
/



select * from useri;

insert into useri values(1,'mihaiul','parola1','Pop Mihai','mihaiul@gmail.com','Student','Bacau',3,'18-04-2022', 0);
insert into useri values(2,'eduard.escu','newpass','Escu Eduard','edi12@yahoo.com','Student','Vaslui',1,'15-05-2022', 0);
insert into useri values(3,'mihai.emi','luceafarul','Eminescu Mihai','eminescu@gmail.com','Scriitor','Iasi',5, '12-04-2022', 50);
insert into useri values(4,'ionel','copilarie','Creanga Ion','creanga@yahoo.com','Scriitor','Iasi',4, '21-05-2022',0);
insert into useri values(5,'george','opera','Enescu George','e.george@gmail.com','Compozitor','Botosani',6,'19-03-2022',100);
--insert into useri values(6,'ciprian','parola123','Porumbescu Ciprian','ciprian@gmail.com','Compozitor','Suceava',3,'17-05-2022',0);



drop procedure has_to_pay;
/
CREATE OR REPLACE PROCEDURE has_to_pay AS
CURSOR pay_cursor IS 
    SELECT id_user, username FROM useri where (sysdate - TO_DATE(date_rented)) > 30;
    v_user pay_cursor%rowtype;
BEGIN
    FOR v_user in pay_cursor LOOP
        UPDATE useri SET useri.to_pay = useri.to_pay + 50 
        WHERE v_user.id_user = id_user;
    END LOOP;
END has_to_pay;
/





DROP PROCEDURE rent_movie;
/
CREATE OR REPLACE PROCEDURE rent_movie(user_id IN NUMBER, new_movie IN NUMBER) AS 
CURSOR change_cursor IS 
    SELECT id_user, name, id_movie FROM useri WHERE id_user = user_id;
    v_user change_cursor%rowtype;
BEGIN

    FOR v_user in change_cursor LOOP
        UPDATE useri SET useri.id_movie = new_movie WHERE v_user.id_user = id_user;
        UPDATE useri SET useri.date_rented = TO_CHAR(SYSDATE) WHERE v_user.id_user = id_user;
    END LOOP;
END rent_movie;
/


DROP TABLE movies;
/
CREATE TABLE movies
(
id_movie NUMBER(3) primary key not null,
name varchar2(50),
year NUMBER(5),
director VARCHAR2(50),
rating NUMBER(5),
genre VARCHAR(50),
nr_of NUMBER(3)
)
/

insert into movies values(1,'Titanic',1997,'James',8,'Romance', 4);
insert into movies values(2,'John Wick',2014,'Chad',7,'Action', 5);
insert into movies values(3,'Shrek',2001,'Andrew',8,'Animation', 2);
insert into movies values(4,'Avatar',2009,'James',9,'Action', 0);
insert into movies values(5,'Spiderman',2021,'John',10,'Action',0);
insert into movies values(6,'Hacksaw Ridge',2016,'Gibson',9,'History',3);
insert into movies values(7,'Star Wars',1977,'George',9,'Action',4);
insert into movies values(8,'Spartacus',2010,'Steven',8,'History',2);
insert into movies values(9,'Hotel Transylvania',2012,'Genndy',7,'Animation',2);
insert into movies values(10,'Dunkirk',2017,'Christopher',7,'History',5);

select * from movies;

alter table useri add foreign key(id_movie) references movies(id_movie);



-- pentru filmele noi(aparute dupa anul 2009) vom creste ratingul

DROP PROCEDURE new_movies;

CREATE OR REPLACE PROCEDURE new_movies AS 
CURSOR movie_cursor IS 
    SELECT id_movie, name, year, genre from MOVIES where year>2009;
    v_movie movie_cursor%rowtype;
BEGIN 
    FOR v_movie in movie_cursor LOOP
        UPDATE movies SET movies.rating = movies.rating + 2 
        WHERE v_movie.id_movie = id_movie;
    END LOOP;
END new_movies;


drop procedure delete_movie;

CREATE OR REPLACE PROCEDURE delete_movie AS
CURSOR delete_cursor IS 
    SELECT id_movie, nr_of FROM movies where nr_of=0;
    v_movie delete_cursor%rowtype;
BEGIN
    FOR v_movie IN delete_cursor LOOP
        DELETE FROM movies WHERE id_movie=v_movie.id_movie;
    END LOOP;
END delete_movie;





select * from useri;
select * from movies;


drop trigger trigger_id;

CREATE OR REPLACE TRIGGER trigger_id
BEFORE INSERT ON useri
FOR EACH ROW
DECLARE
v_number integer;
v_maxim integer;
BEGIN
IF :NEW.id_user IS NULL THEN
    SELECT MAX(id_user) INTO v_maxim FROM useri;
    :NEW.id_user := v_maxim +1;
    DBMS_OUTPUT.PUT_LINE('Inserare reusita');
ELSE
    SELECT COUNT(*) INTO v_number FROM useri WHERE id_user=:NEW.id_user;
    IF(v_number != 0) THEN
    DBMS_OUTPUT.PUT_LINE('Eroare');
    ELSE DBMS_OUTPUT.PUT_LINE('Inserare reusita');
    END IF;
END IF;
END;


DROP TRIGGER trigger_username;


CREATE OR REPLACE TRIGGER trigger_username
BEFORE INSERT ON useri
FOR EACH ROW
DECLARE
v_useri NUMBER;
BEGIN 
    SELECT COUNT(*) INTO v_useri FROM useri WHERE username=:NEW.username;
    IF(v_useri = 0) THEN
        DBMS_OUTPUT.PUT_LINE('Inserare reusita');
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Eroare: Username-ul exista deja');
    END IF;
END;

select * from useri;






DROP TRIGGER trigger_email;


CREATE OR REPLACE TRIGGER trigger_email
BEFORE INSERT ON useri
FOR EACH ROW
DECLARE
v_email NUMBER;
BEGIN 
    SELECT COUNT(*) INTO v_email FROM useri WHERE email=:NEW.email;
    IF(v_email = 0) THEN
        DBMS_OUTPUT.PUT_LINE('Inserare reusita');
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Eroare: Email-ul exista deja');
    END IF;
END;


DROP TRIGGER trigger_id_movie;

CREATE OR REPLACE TRIGGER trigger_id_movie
BEFORE INSERT ON movies
FOR EACH ROW
DECLARE
v_number integer;
v_maxim integer;
BEGIN
IF :NEW.id_movie IS NULL THEN
    SELECT MAX(id_movie) INTO v_maxim FROM movies;
    :NEW.id_movie := v_maxim +1;
    DBMS_OUTPUT.PUT_LINE('Inserare reusita');
ELSE
    SELECT COUNT(*) INTO v_number FROM movies WHERE id_movie=:NEW.id_movie;
    IF(v_number != 0) THEN
    DBMS_OUTPUT.PUT_LINE('Eroare');
    ELSE DBMS_OUTPUT.PUT_LINE('Inserare reusita');
    END IF;
END IF;
END;



