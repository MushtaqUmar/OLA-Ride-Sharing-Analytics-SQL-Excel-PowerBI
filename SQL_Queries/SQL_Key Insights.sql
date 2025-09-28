-- =============== Key Insights
# == General
SELECT * FROM ola_bookings;

-- =========== Of what period we have data
SELECT MAX(DATE), MIN(DATE)
FROM ola_bookings;
# === We have booking data of july,2024



-- 1. =========== Successful bookings:
SELECT * FROM ola_bookings
WHERE Booking_Status = "Success";
-- === Creating view of it , so that we can show result result directly to end stakeholders
CREATE VIEW Successful_Bookings AS
SELECT * FROM ola_bookings
WHERE Booking_Status = "Success";
-- We can show it directly when manager for example asks for displaying successful bookings
SELECT * FROM Successful_Bookings;

-- total
SELECT COUNT(*) AS total_succ_book FROM ola_bookings
WHERE Booking_Status = "Success";

# Insight:  Out of approximately 10,3000 total bookings, about 64,000 were successfully completed, reflecting a success rate of roughly 62%.


-- 2.============ Total number of cancelled rides by customers, riders & where rider was not available
SELECT Booking_Status, COUNT(*) AS total
FROM ola_bookings
GROUP BY Booking_Status;

/* Insights:
- About 10,500 rides were canceled by customers, reflecting a customer_cancellation rate of roughly 10.5%.
- About 18,500 rides were canceled by riders, reflecting a rider_cancellation rate of roughly 19%.
- About 10,100 rides are there where rider was not available, reflecting a un-availability rate of roughly 10%.

*/
-- Storing them seperatorly to show details to stakeholders
CREATE VIEW canceled_by_customers AS
SELECT * FROM ola_bookings
WHERE Booking_Status = "Canceled by Customer";
-- display if you want
SELECT * FROM canceled_by_customers;

CREATE VIEW canceled_by_driver AS
SELECT * FROM ola_bookings
WHERE Booking_Status = "Canceled by Driver";
-- display if you want
SELECT * FROM canceled_by_driver;

CREATE VIEW Driver_unavailable AS
SELECT * FROM ola_bookings
WHERE Booking_Status = "Driver Not Found";
-- display if you want
SELECT * FROM Driver_Unavailable;



-- 3. ============= Number of rides cancelled by drivers but due to personal and car-related issues:
CREATE VIEW `Rider_Canceled_Personal/Car` AS
SELECT COUNT(*) AS total 
FROM ola_bookings
WHERE Canceled_Rides_by_Driver = "Personal & Car related issue";

SELECT * FROM `Rider_Canceled_Personal/Car`;



-- 4. =========== Average ride distance for each vehicle type
CREATE VIEW Avg_Vehicle_Distance AS
SELECT Vehicle_type, ROUND(AVG(Ride_Distance),2) AS Avg_distance
FROM ola_bookings
GROUP BY Vehicle_type;

SELECT * FROM Avg_Vehicle_Distance;
# == Insight : Customers prefer Prime Sedan for longer rides may be for comfortability and auto for local rides.


-- 5. ================ Total booking value of rides completed successfully - Revenue
CREATE VIEW Total_Booking_value AS
SELECT SUM(Booking_Value) AS success_booking_amt
FROM ola_bookings
WHERE Booking_Status = "Success";

SELECT * FROM Total_Booking_value;

-- === Breakdown by vehicle type
CREATE VIEW Booking_value_By_VehicleType AS
SELECT Vehicle_Type, SUM(Booking_Value) AS booking_amt
FROM ola_bookings
WHERE Booking_Status = "Success"
GROUP BY Vehicle_Type
ORDER BY booking_amt DESC;

SELECT * FROM Booking_value_By_VehicleType ;

# == Insight: Total booking value generated amounted to ₹35.08 million, with each vehicle type contributing between ₹4.8 million and ₹5.2 million.




-- 6. ============= Mode of payment and contribution of each on overall booking_value
CREATE VIEW amt_by_payment_mode AS
SELECT Payment_Method, SUM(Booking_Value) AS booking_value
FROM ola_bookings
WHERE Booking_Status = "Success"
GROUP BY Payment_Method
ORDER BY booking_value DESC;

SELECT * FROM amt_by_payment_mode;



-- 7. ============== Most Loyal customers: Top 10  customers who booked the highest number of rides
CREATE VIEW Loyal_Customers AS
SELECT Customer_ID, COUNT(Booking_ID) AS total_bookings 
FROM ola_bookings
GROUP BY Customer_ID
ORDER BY total_bookings DESC
LIMIT 10;

SELECT * FROM Loyal_Customers;
# Insights: Top 10 Loyal Customers : CID954071, CID966929, CID819034, CID836942, CID309168, CID465260, CID340854, CID539191, CID189965, CID980727



-- 8. ===================== The maximum, minimum & Average:  driver & customer ratings for all vehicle type..
CREATE VIEW Driver_Customer_Ratings AS
SELECT Vehicle_Type, 
ROUND(MIN(Driver_Ratings),3) AS Driver_Min_Rating,
ROUND(MAX(Driver_Ratings),3) AS Driver_Max_Rating,
ROUND(AVG(Driver_Ratings),3) AS Driver_Avg_Rating,
ROUND(MIN(Customer_Rating),3) AS Customer_Min_Rating,
ROUND(MAX(Customer_Rating),3) AS Customer_Max_Rating,
ROUND(AVG(Customer_Rating),3) AS Customer_Avg_Rating
FROM ola_bookings
GROUP BY Vehicle_Type;

SELECT * FROM Driver_Customer_Ratings;
# == Insights:
-- Ola maintains strong service quality with driver and customer ratings around 4.0 across all vehicle types, but Prime Plus and eBike leading slightly, while Bikes show room for improvement.



SELECT * FROM ola_bookings;

-- 9. =========================== Incomplete rides along with the reason -> i.e., Rides booked successfully but incomple reasons
CREATE VIEW Incomple_Rides_summary AS
SELECT Incomplete_Rides_Reason, COUNT(Booking_ID) AS total_incomplete, SUM(Booking_Value) AS Booking_Amt
FROM ola_bookings
WHERE Incomplete_Rides = "Yes"
GROUP BY Incomplete_Rides_Reason;

SELECT * FROM Incomple_Rides_summary;

-- Detaied incomplete rides
CREATE VIEW Detaied_Incomplete_Rides AS
SELECT Booking_ID, Incomplete_Rides_Reason
FROM ola_bookings
WHERE Incomplete_Rides = "Yes";

SELECT * FROM Detaied_Incomplete_Rides;

/* === Insights:
Incomplete (successfully booked) rides reveals that Vehicle Breakdown (1,591) and Customer Demand (1,601)
 are the leading causes, together accounting for over 80% of incomplete rides, with Other Issues contributing 734 cases.
*/

