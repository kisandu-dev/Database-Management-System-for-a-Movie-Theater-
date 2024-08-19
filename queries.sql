-- Student Number: 74002435
-- Student Name: YADDEHIGE Kisandu Kawsika Ariyarathne		



--Queries

--Query 1: Child Friendly Movies

SELECT Movie_name 'Title', Duration 'Duration', Class_ID 'Classification Id'
FROM Movie
WHERE Class_ID LIKE 'G' OR Class_ID LIKE 'PG'; --Movies with G or PG ratings are selected.

--Query 2: Anonymous Gift Cards
SELECT G.Gift_Card_ID AS 'ID', G.Value AS 'Amount', ISNULL(C.First_Name + ' ' + C.Last_Name, 'Anonymous') AS 'Customer name'
FROM Gift_Card G
LEFT JOIN Customer C 
ON G.Customer_ID = C.Customer_ID;

--Query 3: Genre Statistics

--The average duration must be cast as a VARCHAR before allowing "None" to be entered if null.
SELECT Genre_Name 'Genre Name', count(M.Movie_ID) 'Movie Count', isnull(cast(AVG(Duration) as varchar), 'None') 'Average Duration'
FROM Movie M
Inner join Movie_Genre MG
ON m.Movie_ID = MG.Movie_ID
Inner join Genre G
ON MG.Genre_ID = G.Genre_ID
Group By Genre_Name;


--Query 4: Adult Revenue

SELECT Session_ID 'Session ID', Date_Time 'Session Time', Movie_Name 'Movie Name', Cinema_name 'Cinema Name', Tickets_Sold 'Tickets Sold', CONCAT('$', CONVERT(VARCHAR, Adult_Price*Tickets_Sold)) 'Total Revenue'
FROM Session S
INNER JOIN Movie M
ON S.Movie_ID = M.Movie_ID
INNER JOIN Cinema C
ON S.Cinema_ID = C.Cinema_ID
INNER JOIN Cinema_Type CT
ON C.Cinema_Type_ID = CT.Cinema_Type_ID
WHERE Date_Time < CURRENT_TIMESTAMP AND Date_Time > DATEADD(MONTH, -6, GETDATE())
ORDER BY Adult_Price*Tickets_Sold DESC;

-- The Total Revenue was converted to a varchar string before being concatenated with $ sign

--Query 5: Lost Umbrella

SELECT c.Cinema_name AS 'Lost Umbrella Location '
FROM Session s
INNER JOIN Cinema c ON s.Cinema_ID = c.Cinema_ID
INNER JOIN Movie m ON s.Movie_ID = m.Movie_ID
INNER JOIN Ticket t ON s.Session_ID = t.Session_ID
INNER JOIN Customer cu ON t.Customer_ID = cu.Customer_ID
INNER JOIN Gift_Card gc ON cu.Customer_ID = gc.Customer_ID --Multiple Joins made to link tables to match parameters for the search.
WHERE c.Cinema_Type_ID = 101 -- Premium Cinemas
  AND m.Movie_Name LIKE '%Sand Castle%' --The movie 'Star Wars' is not included in the data that we used to populate the database. Movie 'Sand Castle' is used instead.
  AND s.Date_Time >= DATEADD(day, -14, GETDATE()) --The date range for the last two weeks are selected.
  AND DATEPART(weekday, s.Date_Time) = 3
  AND gc.Gift_Card_ID = 
  (
    SELECT TOP 1 Gift_Card_ID
    FROM Gift_Card
    WHERE Value = 100
    ORDER BY Gift_Card_ID DESC
  );


  --The result includes "Regal Cinema" where the customer forgot their umbrella.
  --END.