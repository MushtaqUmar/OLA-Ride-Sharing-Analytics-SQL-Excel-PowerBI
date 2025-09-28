CREATE DATABASE IF NOT EXISTS OLA;
USE OLA;

-- ========== Importing data
-- Data is imported via python script

-- ======= How our data looks like
SELECT * FROM ola.ola_bookings;
 
-- ========== Total records we have
select COUNT(*)
from ola_bookings;

-- =========== Of what period we have data
SELECT MAX(DATE), MIN(DATE)
FROM ola_bookings;
# === We have booking data of july,2024


-- ================ Neccessary cleaning & formatting 
DESCRIBE ola_bookings;

-- Drop un-neccessary column
ALTER TABLE ola_bookings
DROP COLUMN `Unnamed: 19`;

-- There is no primary key so far
SELECT Booking_ID
FROM ola_bookings
WHERE Booking_ID IS NULL; -- nothing is null 
-- perfect for primary key - nothing null and all are unique (duplicated removed from exel already)

-- We explored, booking id is of 13 characters
ALTER TABLE ola_bookings 
MODIFY Booking_ID VARCHAR(13) NOT NULL;

-- Making it Primary_key now
ALTER TABLE ola_bookings
ADD CONSTRAINT pk_booking_id PRIMARY KEY(Booking_ID);



-- ============ Payment mode
SELECT Payment_Method
FROM ola_bookings
GROUP BY Payment_Method;

-- Tackle null payment_mode
UPDATE ola_bookings
SET Payment_Method = "Canceled rides"
WHERE Payment_Method IS NULL;


-- ============ While extracting insights I noticed that Customer Rating has "text" for one row - which was sucess ride
SELECT DISTINCT Customer_Rating
FROM ola_bookings
GROUP BY Customer_Rating;

-- Address it with avg rating
UPDATE ola_bookings
JOIN
(SELECT AVG(Customer_Rating*1) AS avg_rat
    FROM ola_bookings
    WHERE Customer_Rating REGEXP "^[0-9]+$"   # ^: Start with 0-9 (+: one or more 0-9), $: end must with one or more no. 
) AS avg_cust_rat
ON 1=1 # Always true -> thus for each row , there wil be avg_rat

SET Customer_Rating = avg_rat
WHERE Customer_Rating = "Dataset";

DESCRIBE ola_bookings;
SELECT * FROM ola_bookings;
