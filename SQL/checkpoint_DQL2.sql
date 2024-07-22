USE wine;


-- Convert the given entity-relationship diagram into a relational model.
-- Implement the relational model using SQL.
-- Insert data into the database tables.


-- Give the list the producers.
SELECT  (First_name + ' ' + Last_name) AS "Producers" FROM Producers;

-- Give the list of producers sorted by name.
SELECT  First_name + ' ' + Last_name AS "Producers" FROM Producers
ORDER BY First_name, Last_name DESC;

-- Give the list the producers of Sousse.
SELECT  First_name + ' ' + Last_name AS "Producers" FROM Producers
WHERE Region = 'Sousse';

SELECT DISTINCT( Region) FROM Producers;

-- Calculate the total quantity of wine produced having the number 12.
SELECT W.Wine_id, W.Degree, SUM(Units) AS "No. Of Units" FROM Harvest H 
LEFT JOIN WINE W ON  H.Wine_id = W.Wine_id
GROUP BY W.Wine_id, W.Degree
HAVING W.Degree = 12
ORDER BY W.Wine_id;


-- Calculate the quantity of wine produced by category.
SELECT W.Category, SUM(Units) AS "No. Of Units" FROM Harvest H 
LEFT JOIN WINE W ON H.Wine_id = W.Wine_id
GROUP BY W.Category
ORDER BY W.Category;

-- Which producers in the Sousse region have harvested at least one wine in quantities greater than 300 liters? 
-- We want the names and first names of the producers, sorted in alphabetical order.

SELECT First_name + ' ' + Last_name AS "Producers", Region, "Total Produced Quantity" FROM 
    (SELECT  P.First_name, P.Last_name , P.Region, SUM(H.Units) AS "Total Produced Quantity"
        FROM Producers P LEFT JOIN Harvest H ON P.Prod_num = H.Prod_num
        GROUP BY P.First_name, P.Last_name, P.Region
        ) SUB
    WHERE Region = 'Sousse' AND "Total Produced Quantity" >300
ORDER BY First_name, Last_name;

-- TEST --
SELECT  P.First_name, P.Last_name , P.Region, SUM(H.Units) AS "Total Produced Quantity"
        FROM Producers P LEFT JOIN Harvest H ON P.Prod_num = H.Prod_num
        GROUP BY P.First_name, P.Last_name, P.Region;

SELECT COUNT(Prod_num) FROM Producers;


-- List the wine numbers that have a degree greater than 12 and that have been produced by producer number 24.--

SELECT H.Prod_num, W.Wine_id, W.Degree FROM Harvest H 
LEFT JOIN WINE W ON  H.Wine_id = W.Wine_id
GROUP BY H.Prod_num, W.Wine_id, W.Degree
HAVING W.Degree > 12 AND H.Prod_num = 'P024'
ORDER BY W.Wine_id;

-- OR ---
SELECT Wine_id FROM HARVEST
WHERE Wine_id IN
(SELECT Wine_id FROM WINE 
WHERE Degree > 12) AND  Prod_num = 'P024';


SELECT * FROM Harvest;
SELECT * FROM Producers;
SELECT * FROM WINE;
