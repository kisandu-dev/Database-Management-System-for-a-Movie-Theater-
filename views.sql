-- Student Number: 74002435
-- Student Name: YADDEHIGE Kisandu Kawsika Ariyarathne		



--Views
--1. Cinema Details View
CREATE View Cinema_Info AS
SELECT Cinema_ID 'Cinema_ID', Cinema_name 'Cinema_name', Capacity 'Seating_Capacity', Cinema_Type_Name 'Cinema Name', Child_Price 'Child Price', Adult_Price 'Adult Price', Concession_Price 'Concession Price'
FROM Cinema C
INNER Join Cinema_Type CT
ON C.Cinema_Type_ID = CT.Cinema_Type_ID
GO



--2.Session View
Create View Session_Details AS
SELECT Session_ID 'Session_ID', Date_Time 'Session Time', S.Movie_ID 'Movie Id', Movie_Name 'Movie Title', Cinema_name 'Cinema Name', Cinema_Type_Name 'Cinema Type Name', Tickets_Sold 'Tickets Sold'
FROM Session S
Inner join Cinema C
ON s.Cinema_ID = c.Cinema_ID
Inner join Cinema_Type CT
on C.Cinema_Type_ID = CT.Cinema_Type_ID
Inner join Movie M
on s.Movie_ID = M.Movie_ID
GO

--Multiple Joins were used to link three seperate tables.
--Session to Movie.Session to Cinema. Cinema to Cinema_Type. 

--Now lets run the views to get an output
SELECT *
FROM Cinema_Info

SELECT *
FROM Session_Details





