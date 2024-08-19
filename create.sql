-- CSG1207D Assignment Task 2 - Movies - Tri 1, 2024

-- Student Number: 74002435
-- Student Name: YADDEHIGE Kisandu Kawsika Ariyarathne		



/*	Database Creation & Population Script 
	Script to create the database we designed in Task 1 
*/


-- Creating an empty database

IF DB_ID('Movie_Theater') IS NOT NULL             
	BEGIN
		PRINT 'Database exists - dropping.';
		
		USE master;		
		ALTER DATABASE [Movie_Theater] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		
		DROP DATABASE [Movie_Theater];
	END

GO
PRINT 'Creating database.';

CREATE DATABASE [Movie_Theater];

GO

--  An empty database has been created now and now will make it an active database.
--  The table creation statements that follow will therefore be executed on the newly created database.

-- Making the database active

USE [Movie_Theater];

GO

-- Table Creation 

-- Table creation Order 
		-- Genre
		-- Classification
		-- CinemaType
		-- Movie
		-- MovieGenre
		-- Cinema
		-- Session
		-- Customer 
		-- Ticket
		-- GiftCard

-- Creation script for our Tables 

--Table Genre-- (This Table Stores all information about Genre)
CREATE TABLE Genre (
    Genre_ID INT IDENTITY(1,1) NOT NULL,
    Genre_Name VARCHAR(50) UNIQUE NOT NULL,
    
	CONSTRAINT Genre_pk PRIMARY KEY(Genre_id)
	);
print 'Create Genre table...'


 
 -------------------------------------------------------------------------------------------------------

--Table Classification-- (This Table Stores all information about Classification)
CREATE TABLE Classification (
    Class_ID VARCHAR (2) NOT NULL,
    Class_Name VARCHAR(50) NOT NULL,
    Minimum_Age INT DEFAULT NULL,

	CONSTRAINT Classification_pk PRIMARY KEY(Class_id)
	);
print 'Create Classification table...'


 
 -------------------------------------------------------------------------------------------------------

--Table Cinema_Type-- (This Table Stores all information about Cinema_Type)
CREATE TABLE Cinema_Type (
    Cinema_Type_ID INT IDENTITY(100,1) NOT NULL,
    Cinema_Type_Name VARCHAR (50) UNIQUE NOT NULL,
    Child_Price MONEY NOT NULL,
	Adult_Price MONEY NOT NULL, 
	Concession_Price MONEY NOT NULL,

	CONSTRAINT Cinema_Type_pk PRIMARY KEY(Cinema_Type_ID)
	);
print 'Create Cinema_Type table...'



-------------------------------------------------------------------------------------------------------

--Table Movie-- (This Table Stores all information about Movie)
CREATE TABLE Movie (
    Movie_ID INT IDENTITY(150,3) NOT NULL,
    Movie_Name VARCHAR (255) UNIQUE NOT NULL,
    Duration INT NULL,
	M_Description VARCHAR (255) NULL, 
	Class_ID VARCHAR (2) NOT NULL,
	CONSTRAINT Movie_pk PRIMARY KEY(Movie_ID),
	CONSTRAINT Movie_classification_fk FOREIGN KEY (Class_ID) 
			REFERENCES Classification (Class_ID)
	);
print 'Create Movie table...'



-------------------------------------------------------------------------------------------------------

--Table Movie_Genre-- (This Table Stores all information about Movie_Genre)
CREATE TABLE Movie_Genre (
    Movie_ID INT,
    Genre_ID INT,
    CONSTRAINT Movie_Genre_pk PRIMARY KEY (Movie_ID, Genre_ID), 
    CONSTRAINT Movie_Genre_fk FOREIGN KEY (Movie_ID) 
				REFERENCES Movie(Movie_ID),
     CONSTRAINT Movie_Genre_fk2 FOREIGN KEY (Genre_ID)
				REFERENCES Genre(Genre_ID)
	);
print 'Create Movie_Genre table...'



-------------------------------------------------------------------------------------------------------

--Table Cinema-- (This Table Stores all information about Cinema)
CREATE TABLE Cinema (
    Cinema_ID INT IDENTITY(260,1) NOT NULL,
    Cinema_name VARCHAR(50) UNIQUE NOT NULL,
    Capacity INT NOT NULL,
	Cinema_Type_ID INT NOT NULL,
	CONSTRAINT Cinema_pk PRIMARY KEY(Cinema_ID),
	CONSTRAINT Cinema_Cinema_Type_ID_fk FOREIGN KEY (Cinema_Type_ID) 
			REFERENCES Cinema_Type (Cinema_Type_ID)
	);
print 'Create Cinema table...'



-------------------------------------------------------------------------------------------------------

--Table Session-- (This Table Stores all information about Session)
CREATE TABLE Session (
    Session_ID INT IDENTITY (400,2)NOT NULL,
    Date_Time DATETIME NOT NULL,
	Movie_ID INT NOT NULL,
	Cinema_ID INT NOT NULL,
	Tickets_Sold INT NOT NULL,
    CONSTRAINT Session_pk PRIMARY KEY (Session_ID), 
    CONSTRAINT Session_Movie_fk FOREIGN KEY (Movie_ID) 
				REFERENCES Movie(Movie_ID),
     CONSTRAINT Session_Cinema_fk FOREIGN KEY (Cinema_ID)
				REFERENCES Cinema(Cinema_ID)
	);
print 'Create Session table...'



-------------------------------------------------------------------------------------------------------

--Table Customer-- (This Table Stores all information about Customer)
CREATE TABLE Customer (
    Customer_ID INT IDENTITY (850,2)NOT NULL,
	Email VARCHAR(255) UNIQUE NULL,
	Password VARCHAR(50) NULL,
	First_Name VARCHAR(50) NULL,
	Last_Name VARCHAR(50) NULL,
	Date_of_Birth DATE NULL,
	CONSTRAINT Customer_pk PRIMARY KEY (Customer_ID),
	);
print 'Create Customer table...'




-------------------------------------------------------------------------------------------------------

--Table Ticket-- (This Table Stores all information about Ticket)
CREATE TABLE Ticket (
    Ticket_ID INT IDENTITY (980,1)NOT NULL,
	Session_ID INT NOT NULL,
	Email VARCHAR (255) UNIQUE NOT NULL,
	Ticket_Type VARCHAR (20) NOT NULL,
	Seat_Number INT UNIQUE NOT NULL,
	Customer_ID INT NOT NULL,
	CONSTRAINT Ticket_pk PRIMARY KEY (Ticket_ID),
	CONSTRAINT Ticket_Session_fk FOREIGN KEy (Session_ID)
				REFERENCES Session(Session_ID),
	CONSTRAINT Ticket_Customer_fk FOREIGN KEY(Customer_ID)
				REFERENCES Customer(Customer_ID),
	CONSTRAINT chk_TicketType CHECK (Ticket_Type IN ('Child_Price', 'Adult_Price', 'Concession_Price')),
	CONSTRAINT uc_SessionID_SeatNumber UNIQUE (Session_ID, Seat_Number)
	);
print 'Create Ticket table...'




-------------------------------------------------------------------------------------------------------


--Table Gift_Card-- (This Table Stores all information about Gift_Card)
CREATE TABLE Gift_Card (
    Gift_Card_ID INT IDENTITY (1001,3)NOT NULL,
	Value MONEY NOT NULL,
	Customer_ID INT NOT NULL,
	CONSTRAINT Gift_Card_pk PRIMARY KEY (Gift_Card_ID),
	CONSTRAINT Gift_Card_Customer_FK FOREIGN KEY (Customer_ID)
				REFERENCES Customer(Customer_ID)
	);
print 'Create Gift_Card table...'



-------------------------------------------------------------------------------------------------------


-- Now we have created all the 10tables in the respective order
-- Next step is to insert some data into the tables, for this we should use INSERT INTO "Table Name" (Coloum names)
--																			Values (enter the values in the correct order) 


--INSERT data into Genre Table 
INSERT INTO Genre (Genre_Name)
Values	('Action'), -- Genre Action
		('Horror'), -- Genre Horror
		('Sci-Fic'), -- Genre Sci-Fic
		('Thriller'), -- Genre Thriller
		('Comedy'), -- Genre Comedy
		('Animation'), -- Genre Animation
		('Adventure'), --Genre Adventure
		('Romantic'), -- Genre Romantic
		('Fantasy'), -- Genre Fantasy
		('Historical Fiction'), -- Genre Historical Fiction 
		('Melodrama'); -- Genre Melodrama

-- NOTE : We dont insert values to Genre_ID cause the coloumn Genre_ID is defined as IDENTITY which means auto-incrementing values.



-------------------------------------------------------------------------------------------------------

--INSERT data into Classification Table 
INSERT INTO Classification(Class_ID, Class_Name, Minimum_Age)
Values	('G', 'General', NULL), -- Classification General
		('PG', 'Parental Guidance', NULL), -- Classification Parental Guidance
		('M', 'Mature', NULL), -- Classification Mature 
		('MA', 'Mature Audiences', 15), -- Classification Mature Audiences
		('R', 'Restricted', 18); -- Classification Restricted

--Note : In the Minimum Age we cannot use 'NOT APPLICABLE' Becasue we defined the coloumn as INT so instead NOT APPLICABLE we use NULL
	 


-------------------------------------------------------------------------------------------------------

--INSERT data into Cinema_Type Table
INSERT INTO Cinema_Type (Cinema_Type_Name, Child_Price,Adult_Price,Concession_Price)
Values	('Standard', 15.50, 19.50,16.50), --Cinema_Type_Standard 
		('Premium', 18.50,25.00,19.50), --Cinema_Type_Premium
		('Gold Class', 23.50, 30.50, 24.50), --Cinema_Type_Gold Class
		('Gold Class Xtreme', 28.50, 32.00, 29.50); -- Cinema_Type_Gold Class Xtreme

-- NOTE : We dont insert values to Cinema_Type_ID cause the coloumn Cinema_Type_ID is defined as IDENTITY which means auto-incrementing values.


-------------------------------------------------------------------------------------------------------

--INSERT data into Movie Table
INSERT INTO Movie (Movie_Name, Duration, M_Description, Class_ID)
Values	('The Lion King', 88, 'The Lion King, This animated Disney Classic Portrays the narrative of Simba' , 'G'), -- Movie 1 
		('Jumanji Welcome to Jungle', 120, 'Four teenagers stucked in a videogame and trys to survive', 'G'), -- Movie 2
		('Cheaper by the Dozen', 68, 'A comedy about a romatic couple with tweleve children', 'PG'), -- Movie 3
		('The Mitchells vs. the Machines', 115, 'An animated film about a dysfunctional family who must come together', 'PG'), -- Movie 4
		('The Shawshank Redemption', 110, 'A drama about a man who is wrongly convited of murder and sentenced to life in prison', 'M'), --Movie 5
		('Schinders List', 98, NULL, 'M'), -- Movie 6
		('Fight Club', NULL, NULL, 'MA'), -- Movie 7
		('Requiem for a Dream', NULL, 'A drama that follows four characters as they decend into addiction and despair', 'MA'), -- Movie 8
		('Clock Work Orange', 120, NULL, 'R'), -- Movie 9
		('Eyes Wide Shut', 110, NULL, 'R'), -- Movie 10
		('Love', 120, 'Two Teenagers tries to fullfill their sexual desires','R'),-- Movie 11
		('Sand Castle', 115, 'Story of Rescuing a team of US Army Soilders from a terrorist group', 'M'), --Movie 12
		('Twelve Strong', 110, 'Taking the Revenge of Attack on World Trade Center', 'PG'), -- Movie 13
		('Boss Baby', 120, NULL, 'G'), --Movie 14
		('Kill Bill', NULL, NULL, 'G'), -- Movie 15
		('Pulp Fiction', 148, NULL, 'MA'), -- Movie 16
		('Geostorm', 115, NULL, 'G'), -- Movie 17
		('Road Trip', NULL, 'Four College buddies embark on a road trip', 'MA'),-- Movie 18
		('Heightfull Eight', NULL, NULL, 'PG'); -- Movie 19
		
------------------------------------------------------------------------------------------------------------------------------
		


--INSERT Data into Movie_Genre Table
INSERT INTO Movie_Genre(Movie_ID,Genre_ID)
VALUES	(150, 6), --Lion King , Animation
		(153, 1), --Jumanji , Action
		(156, 3), --Star Wars:The Phantom Menace, Sci-Fic
		(159, 10), --The Mitchells vs the Machines, Historical Fiction
		(162, 10), --Shawshank Redemption, Historical Fiction
		(165, 2), -- Schinders List, Horror
		(168, 9), -- Fight Club Fantasy
		(171, 11), -- Requeim for a dream, Melodrama
		(174, 7), -- Clock Work Orange, Adventure
		(177, 8), -- Eyes Wide Shut, Romantic
		(180, 8), -- Love, Romantic 
		(183, 1), -- Sand Castle, Action 
		(186, 1), --Twelve Strong, Action 
		(189, 6), --Boss Baby, Animation
		(192, 3), --Kill Bill, SCI-FIC
		(195, 3), --Pulp Fiction, SCI-FIC
		(198, 4), --Geostorm, Thriller
		(201, 5), -- Road Trip, Comedy 
		(204, 11); --Heightfull Eight, Melodrama
	



--------------------------------------------------------------------------------------------------------------------------

--INSERT Data into Cinema Table
INSERT INTO Cinema (Cinema_name, Capacity, Cinema_Type_ID)
VALUES	('Liberty By Scope Cinemas', 500, 100), -- Standard Cinema  
		('Regal Cinema', 320, 101), -- Premium Cinema 
		('Majestic Complex', 450, 102), -- Gold Class Cinema 
		('PVR Cinema', 150, 103); -- Gold Class Xtreme Cinema 
		



---------------------------------------------------------------------------------------------------------------------------

--INSERT Data into Session
INSERT INTO Session(Date_Time, Movie_ID, Cinema_ID, Tickets_Sold)
VALUES	--Lion King Movie Sessions 
		(Convert(DATETIME,'2024-03-01 10:30:00',101), 150, 260, 10), --Lion King Movie in Libeerty By Scope Cinema from 10:30:00
		(Convert(DATETIME,'2024-04-20 12:30:00',101), 150, 262, 0), -- Lion King Movie in Majestic Complex Cinema from 12:30:00
		(Convert(DATETIME,'2024-12-27 15:30:00',101), 150, 261, 10), --  Lion King Movie in Regal Cinema from 15:30:00
		--Jumanji Movie Sessions
		(Convert(DATETIME,'2024-01-05 10:30:00',101), 153, 263, 5), --Jumanji Welcome to jungle Movie  in PVR Cinema from 10:30:00
		(Convert(DATETIME,'2024-07-15 12:30:00',101), 153, 262,6), -- Jumanji Welcome to Jungle Movie in PVR Cinema from 10:30:00
		(Convert(DATETIME,'2024-11-23 15:30:00',101), 153, 261,8), -- Jumanji Welcome to Jungle Movie in Regal Cinema from 15:30:00
		--Cheaper By the Dozen Movie Sessions 
		(Convert(DATETIME,'2024-02-17 10:30:00',101), 156, 263,10), -- Cheaper By the Dozen Movie in PVR Cinema from 10:30:00
		(Convert(DATETIME,'2024-05-24 18:30:00',101), 156, 263,12), -- Cheaper By the Dozen Movie in PVR Cinema from 18:30:00
		--The Mitchells vs the Machines Movie Sessions
		(Convert(DATETIME,'2024-05-10 10:30:00',101), 159, 262,3), -- The Mitchells vs the Machines Movie in Majestic Complex Cinema from 10:30:00
		(Convert(DATETIME,'2024-05-19 16:30:00',101), 159, 260,4), -- The Mitchells vs the Machines Movie in Liberty By Scope Cinema from 16:30:00
		(Convert(DATETIME,'2024-05-26 18:30:00',101), 159, 263,5), -- The Mitchells vs the Machines Movie in PVR Cinema from 18:30:00
		--The Sahwshank Redemption Movie Sessions 
		(Convert(DATETIME,'2024-06-05 10:30:00',101), 162, 263,6), -- The Sahwshank Redemption Movie in PVR Cinema from 10:30:00
		(Convert(DATETIME,'2024-08-17 15:30:00',101), 162, 263,7), -- The Sahwshank Redemption Movie in PVR Cinema from 15:30:00
		--Schinders List Movie Sessions
		(Convert(DATETIME,'2024-07-09 10:30:00',101), 165, 260,8), --  Schinders List Movie in Liberty By Scope Cinema from 10:30:00
		(Convert(DATETIME,'2024-09-15 15:30:00',101), 165, 260,4), --  Schinders List Movie in Liberty By Scope Cinema from 15:30:00
		(Convert(DATETIME,'2024-10-19 10:30:00',101), 165, 261,3), --  Schinders List Movie in Regal Cinema from 15:30:00
		(Convert(DATETIME,'2024-05-15 18:30:00',101), 165, 262,2), --  Schinders List Movie in Majestic Complex Cinema from 18:30:00
		--Fight Club Movie Sessions 
		(Convert(DATETIME,'2024-09-05 10:30:00',101), 168, 260,4), --   Fight Club Movie in Liberty By Scope Cinema from 10:30:00
		(Convert(DATETIME,'2024-10-10 15:30:00',101), 168, 260,5), --   Fight Club Movie in Liberty By Scope Cinema from 15:30:00
		(Convert(DATETIME,'2024-11-15 16:30:00',101), 168, 263,2), --   Fight Club Movie in PVR Cinema from 16:30:00
		(Convert(DATETIME,'2024-12-20 18:30:00',101), 168, 262,3), --   Fight Club Movie in Majestic City Cinema from 16:30:00
		--Requiem for a dream Movie Sessions 
		(Convert(DATETIME,'2024-03-03 10:30:00',101), 171, 260,0), --   Requiem for a Dream Movie in Liberty By Scope Cinema from 10:30:00
		(Convert(DATETIME,'2024-04-12 15:30:00',101), 171, 260,4), --   Requiem for a Dream Movie in Liberty By Scope Cinema from 15:30:00
		(Convert(DATETIME,'2024-05-24 18:30:00',101), 171, 260,6), --   Requiem for a Dream Movie in Liberty By Scope Cinema from 18:30:00
		--Clock Work Orange Movie Sessions
		(Convert(DATETIME,'2024-07-17 10:30:00',101), 174, 263,5),--   Clock Work Orange Movie in PVR Cinema from 10:30:00
		--Eyes Wide Shut Sessions
		(Convert(DATETIME,'2024-01-15 10:30:00',101), 177, 261,4),--   Eyes Wide Shut Movie in Regal Cinema from 10:30:00
		(Convert(DATETIME,'2024-02-18 19:30:00',101), 177, 261,6),--	 Eyes Wide Shut Movie in Regal Cinema from 19:30:00
		--Love Movie Sessions
		(Convert(DATETIME,'2024-03-19 15:30:00',101), 180, 263,5),--	 Love Movie in PVR Cinema from 15:30:00
		(Convert(DATETIME,'2024-04-28 20:30:00',101), 180, 263,6),--	 Love Movie in PVR Cinema from 20:30:00
		--Sand Castle Movie Sessions 
		(Convert(DATETIME,'2024-05-07 14:00:00',101), 183, 261,4),--	 Sand Castle Movie in Majestic Complex Cinema from 14:00:00
		(Convert(DATETIME,'2024-06-20 21:30:00',101), 183, 262,4),--	 Sand Castle Movie in Majestic Complex Cinema from 21:30:00
		--Twelve Strong Movie Sessions
		(Convert(DATETIME,'2024-03-06 17:30:00',101), 186, 260,10),--	 Twelve Strong Movie in Liberty By Scope Cinema from 17:30:00
		(Convert(DATETIME,'2024-04-07 19:30:00',101), 186, 260,3),--	 Twelve Strong Movie in Liberty By Scope Cinema from 19:30:00
		(Convert(DATETIME,'2024-07-08 21:30:00',101), 186, 260,5),--	 Twelve Strong Movie in Liberty By Scope Cinema from 21:30:00
		-- Boss Baby Movie Sessions
		(Convert(DATETIME,'2024-02-01 10:30:00',101), 189, 260,5),--	 Boss Baby Movie in Liberty By Scope Cinema from 10:30:00
		(Convert(DATETIME,'2024-03-09 12:30:00',101), 189, 260,1),--	 Boss Baby  Movie in Liberty By Scope Cinema from 12:30:00
		(Convert(DATETIME,'2024-04-17 17:30:00',101), 189, 261,3),--	 Boss Baby Movie in Regal Cinema from 17:30:00
		(Convert(DATETIME,'2024-05-25 19:30:00',101), 189, 263,4),--	 Boss Baby Movie in PVR Cinema from 19:30:00
		--Kill Bill Movie Sessions 
		(Convert(DATETIME,'2024-06-20 10:30:00',101), 192, 260,4),--	 Kill Bill Movie in Liberty By Scope Cinema from 10:30:00
		(Convert(DATETIME,'2024-07-25 12:30:00',101), 192, 262,3),--	 Kill Bill Movie in Majestic Complex Cinema from 12:30:00
		(Convert(DATETIME,'2024-08-29 20:30:00',101), 192, 263,8),--	 Kill Bill Movie in PVR Cinema from 20:30:00
		--Pulp Fiction Movie Sessions
		(Convert(DATETIME,'2024-09-15 10:30:00',101), 195, 261,10),--	 Pulp Fiction Movie in Regal Cinema from 10:30:00
		(Convert(DATETIME,'2024-10-20 15:30:00',101), 195, 262,12),--	 Pulp Fiction Movie in Majestic Complex Cinema from 15:30:00
		(Convert(DATETIME,'2024-11-28 20:30:00',101), 195, 260,4),--	 Pulp Fiction Movie in Liberty By Scope from 20:30:00
		--Gestorm Movie Sessions
		(Convert(DATETIME,'2024-07-10 15:30:00',101), 198, 261,4),--	 Geostorm Movie in Regal Cinema from 15:30:00
		(Convert(DATETIME,'2024-08-15 17:30:00',101), 198, 260,6),--	 Gestorm Movie in Liberty By Scope Cinema from 17:30:00
		(Convert(DATETIME,'2024-12-31 20:30:00',101), 198, 260,7),--	 Gestorm Movie in Liberty By Scope from 20:30:00
		--Road Trip Movie Sessions
		(Convert(DATETIME,'2024-07-20 18:30:00',101), 201, 262,7),--	 Road Trip Movie in Majestic Complex Cinema from 18:30:00
		(Convert(DATETIME,'2024-08-28 20:30:00',101), 201, 263,8),--	 Road Trip Movie in PVR Cinema from 20:30:00
		--Heightfull Eight Movie Sessions 
		(Convert(DATETIME,'2024-09-12 18:30:00',101), 204, 263,7),--	 HeightFull Eight Movie in PVR Cinema from 18:30:00
		(Convert(DATETIME,'2024-10-15 20:30:00',101), 204, 263,3);--	 HeightFull Eight Movie in PVR Cinema from 20:30:00


-----------------------------------------------------------------------------------------------------------------------------------------

--INSERT Data into Customer Table
INSERT INTO Customer (Email, Password, First_Name, Last_Name, Date_of_Birth)
VALUES	('maya123@gmail.com', 'Maya@123', 'Maya', 'Rodriguez', '19-JUN-1990'), -- Maya Rodriguez
		('Ethan222@gmail.com', 'Ethan@2003', 'Ethan', 'Patel', '20-Apr-2003'), -- Ethan Patel 
		('ChenLee@gmail.com', 'Lee@123', 'Chen', 'Lee', '18-MAR-1999'), -- Chen Lee
		('Isabellab@gmail.com', 'Bella@100', 'Issabella', 'Brown', NULL), --Issabella Brown
		('Johson@gmail.com', 'Liam@2001', 'Liam', 'Johnson', '20-DEC-2001'), --Liam Johnson
		('EvergreenLyra@gmail.com', 'EverLyra@1999', 'Lyra', 'Evergreen', '15-MAY-1997'),-- Lyra Evergreen
		('Winters@gmail.com', 'KaiWinters@1998', 'Kai', 'Winters', '12-JUN-1998'), -- Kai Winters
		('RowanHunter@gmail.com', NULL, 'Rowan', 'Hunter', NUll), -- Rowan Hunter 
		('anonymous@gmail.com', NULL, NULL, NUll, NULL), -- An Anonymous Customer
		('SparksAmara@gmail.com', NULL, 'Amara', 'Sparks','13-AUG-2000'); --Amara Sparks 




-------------------------------------------------------------------------------------------------------------------------------------

--INSERT INTO Ticket Table 
INSERT INTO Ticket (Session_ID, Email, Ticket_Type, Seat_Number, Customer_ID)
VALUES	(400, 'SparksAmara@gmail.com', 'Adult_Price', 44, 868), 
		(406, 'Winters@gmail.com', 'Adult_Price', 50, 862),
		(408, 'Isabellab@gmail.com', 'Adult_Price', 100, 856),
		(408, 'ChenLee@gmail.com', 'Adult_Price', 82, 854),
		(500, 'Ethan222@gmail.com', 'Child_Price', 70, 852),
		(458, 'maya123@gmail.com', 'Concession_Price', 155, 850),
		(414, 'Johson@gmail.com', 'Concession_Price', 200, 858),
		(426, 'EvergreenLyra@gmail.com', 'Adult_Price', 120, 860),
		(450, 'annonymous@gmail.com', 'Adult_Price', 280, 866);



--INSERT INTO Gift_Card table 
INSERT INTO Gift_Card (Value, Customer_ID)
Values	(50, 866),
		(100, 850),
		(60, 856),
		(28, 852);

-- Now the Creation Script is over and in order to run the database we should click on execute. 

