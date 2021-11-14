create database Travel_On_The_Go;
use Travel_On_The_Go;

/*
1. Creating Tables
*/
create table PASSENGER (Passenger_name varchar (50),
                        Category varchar (50),
                        Gender varchar (2),
			Boarding_City varchar (30),
			Destination_City varchar (30),
                        Distance int ,
                        Bus_Type varchar (30)
                        );
create table PRICE (Bus_Type varchar (30),
                    Distance int,
                    Price int
                    );

/*
2. Inserting values inside Tables
*/
insert into PASSENGER values('Sejal' ,'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),('Anmol',' Non-AC', 'M', 'Mumbai', 'Hyderabad', 700,'Sitting'),('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600 ,'Sleeper'),
			    ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper'),('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper'),('Ankur', 'AC', 'M' ,'Nagpur', 'Hyderabad', 500 ,'Sitting'),
                            ('Hemant', 'Non-AC' ,'M' ,'panaji' ,'Mumbai', 700, 'Sleeper'),('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting'),('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700 ,'Sitting');
insert into PRICE values('Sleeper', 350, 770),('Sleeper' ,500 ,1100),('Sleeper', 600, 1320),('Sleeper', 700, 1540),('Sleeper', 1000, 2200),('Sleeper' ,1200, 2640),
                         ('Sleeper', 350 ,434),('Sitting', 500 ,620),('Sitting', 500 ,620),('Sitting', 600, 744),('Sitting', 700, 868),('Sitting', 1000, 1240),('Sitting', 1200, 1488),
                         ('Sitting', 1500 ,1860);



/*
3. How many females and how many male passengers travelled for a minimum distance of 600 KM s?
*/
SELECT 
    COUNT(p.gender) AS 'count of passengers travelled for a min distance of 600 KM',
    p.gender
FROM
    passenger p
WHERE
    p.distance >= 600
GROUP BY gender;



/*
4. Find the minimum ticket price for Sleeper Bus
*/
SELECT 
    MIN(p.price) AS 'min ticket price',
     p.bus_type
FROM
    price p
WHERE
    p.bus_type = 'Sleeper';
    


/*
5. Select passenger names whose names start with character 'S'
*/
SELECT 
    *
FROM
    passenger p
WHERE
    p.passenger_name LIKE 'S%';



/*
6. Calculate price charged for each passenger displaying Passenger name, Boarding City,Destination City, Bus_Type, Price in the output
*/
SELECT DISTINCT
   /* adding distinct so that only those price values will be shown that have different price value for same distance*/
    p.passenger_name,
    p.boarding_city,
    p.destination_city,
    p.bus_type,
	pr.price as 'calculated price'
FROM
    passenger p
        JOIN
    price pr ON p.bus_type = pr.bus_type
        AND p.distance = pr.distance
ORDER BY p.passenger_name;


/*
7. What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KM s 
*/
SELECT 
    p.passenger_name, pr.price AS 'ticket price'
FROM
    passenger p
        JOIN
    price pr ON p.bus_type = 'sitting'
        AND p.distance = 1000
GROUP BY p.passenger_name;   /* will return 0 record as there is no such entry of passenger having sitting as bus type and 1000 Kms distance in passenger table*/



/*
8. What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
*/
SELECT 
    p.passenger_name,
    p.destination_city AS boarding_city,
    p.boarding_city AS destination_city,
    pr.bus_type,
    pr.price as bus_charge
FROM
    passenger p
        JOIN
    price pr ON pr.distance = p.distance
WHERE
    p.passenger_name = 'Pallavi'; 

    
/*
9. List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
*/
SELECT DISTINCT
    (p.distance) AS 'unique distances'
FROM
    passenger p
ORDER BY p.distance DESC;



/*
10. Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables 
*/
SELECT 
    p.passenger_name,
    p.distance AS 'distance travelled',
    p.distance * 100 / (SELECT 
            SUM(p.distance)
        FROM
            passenger p) AS 'percentage % of distance travelled from total distance'
FROM
    passenger p;



/*
11. Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/
SELECT 
    pr.distance,
    pr.price,
    CASE
        WHEN pr.price > 1000 THEN 'Expensive'
        WHEN pr.price > 500 AND pr.price < 1000 THEN 'Average Coast'
        ELSE 'Cheap'
    END AS category
FROM
    price pr;