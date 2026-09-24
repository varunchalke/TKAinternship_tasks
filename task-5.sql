CREATE DATABASE quickbite_db;

USE quickbite_db;

CREATE TABLE restaurants (
  restaurant_id INT PRIMARY KEY,
  restaurant_name VARCHAR(100),
  cuisine VARCHAR(50),
  city VARCHAR(50),
  rating DOUBLE,
  avg_order_value DOUBLE,
  orders_count INT,
  delivery_fee DOUBLE,
  est_delivery_time INT,
  owner_name VARCHAR(100),
  brand VARCHAR(100)
);

INSERT INTO restaurants
(restaurant_id, restaurant_name, cuisine, city, rating, avg_order_value,
 orders_count, delivery_fee, est_delivery_time, owner_name, brand)
VALUES
(101, 'Spice Route', 'North Indian', 'Pune', 4.5, 420, 18500, 39, 32, 'Amit Sharma', 'Spice Route'),
(102, 'South Tiffin House', 'South Indian', 'Pune', 4.3, 260, 14300, 29, 25, 'Priya Nair', 'South Tiffin'),
(103, 'Mumbai Zaika', 'Maharashtrian', 'Mumbai', 4.1, 350, 22000, 49, 38, 'Rohit Patil', 'Zaika Foods'),
(104, 'Burger Garage', 'Fast Food', 'Pune', 4.4, 310, 27500, 29, 30, 'Neha Joshi', 'Burger Garage'),
(105, 'Pizza Planet', 'Italian', 'Mumbai', 4.6, 520, 31000, 19, 35, 'Vikas Mehta', 'Pizza Planet'),
(106, 'Biryani Junction', 'Biryani', 'Hyderabad', 4.7, 480, 42000, 29, 40, 'Arjun Reddy', 'Biryani Junction'),
(107, 'Chai & Snacks', 'Cafe', 'Pune', 4.2, 180, 19500, 19, 22, 'Sneha Kulkarni', 'Chai & Snacks'),
(108, 'Royal Thali', 'North Indian', 'Delhi', 4.0, 390, 16800, 39, 42, 'Manish Gupta', 'Royal Thali'),
(109, 'Tandoori Tales', 'Mughlai', 'Delhi', 4.5, 610, 12100, 59, 45, 'Karan Singh', 'Tandoori Tales'),
(110, 'Coastal Curry', 'Seafood', 'Goa', 4.6, 750, 9800, 69, 48, 'Riya Fernandes', 'Coastal Curry'),
(111, 'Green Bowl', 'Healthy', 'Bengaluru', 4.3, 330, 11600, 39, 28, 'Ananya Rao', 'Green Bowl'),
(112, 'Dosa Factory', 'South Indian', 'Bengaluru', 4.5, 240, 27800, 19, 24, 'Suresh Kumar', 'Dosa Factory'),
(113, 'Punjabi Dhaba', 'Punjabi', 'Chandigarh', 4.1, 370, 13200, 49, 40, 'Gurpreet Singh', 'Punjabi Dhaba'),
(114, 'The Wok House', 'Chinese', 'Pune', 4.4, 450, 18400, 39, 36, 'Rahul Jain', 'Wok House'),
(115, 'Sushi Street', 'Japanese', 'Mumbai', 4.8, 920, 7600, 89, 50, 'Meera Shah', 'Sushi Street'),
(116, 'Cafe Mocha', 'Cafe', 'Pune', 4.2, 290, 15400, 29, 27, 'Ishita Deshmukh', 'Cafe Mocha'),
(117, 'Street Tadka', 'Indian', 'Nagpur', 3.9, 220, 10200, 19, 35, 'Akash Verma', 'Street Tadka'),
(118, 'Hyderabadi House', 'Biryani', 'Hyderabad', 4.6, 430, 35500, 29, 37, 'Faizan Ali', 'Hyderabadi House'),
(119, 'Pasta Palace', 'Italian', 'Bengaluru', 4.5, 560, 10900, 49, 41, 'Nikhil Rao', 'Pasta Palace'),
(120, 'Sweet Cravings', 'Desserts', 'Pune', 4.7, 280, 20500, 19, 26, 'Pooja Patil', 'Sweet Cravings'),
(121, 'Kebab Kingdom', 'Mughlai', 'Delhi', 4.4, 530, 14100, 59, 44, 'Sameer Khan', 'Kebab Kingdom'),
(122, 'Taco Town', 'Mexican', 'Mumbai', 4.2, 460, 8700, 49, 39, 'Kabir Malhotra', 'Taco Town'),
(123, 'Farm Fresh', 'Healthy', 'Pune', 4.6, 390, 12500, 29, 30, 'Rohan Kulkarni', 'Farm Fresh'),
(124, 'Midnight Bites', 'Fast Food', 'Pune', 4.0, 250, 24800, 39, 34, 'Rohan Kulkarni', 'Midnight Bites'),
(125, 'Kolkata Kitchen', 'Bengali', 'Kolkata', 4.3, 340, 11400, 39, 43, 'Tanvi Shah', 'Kolkata Kitchen'),
(126, 'Kerala Cafe', 'South Indian', 'Kochi', 4.5, 310, 12700, 29, 31, 'Soham Sen', 'Kerala Cafe'),
(127, 'Royal Rajputana', 'Rajasthani', 'Jaipur', 4.7, 470, 9200, 49, 46, 'Akhil Menon', 'Rajputana Foods'),
(128, 'Namma Meals', 'South Indian', 'Bengaluru', 4.4, 275, 23900, 19, 27, 'Vivek Rathore', 'Namma Meals'),
(129, 'Lassi Lab', 'Beverages', 'Pune', 4.1, 160, 18200, 19, 21, 'Kavya Shetty', 'Lassi Lab'),
(130, 'Flame & Grill', 'BBQ', 'Mumbai', 4.8, 880, 8300, 79, 52, 'Dev Malhotra', 'Flame & Grill');

SELECT COUNT(*) AS total_restaurants FROM restaurants;

SELECT * FROM restaurants;

-- Task 1
SELECT * FROM restaurants WHERE rating > 4.5;

-- Task 2
SELECT * FROM restaurants WHERE avg_order_value < 300;

-- Task 3
SELECT * FROM restaurants WHERE city = 'Pune';

-- Task 4
SELECT * FROM restaurants WHERE orders_count > 20000;

-- Task 5
SELECT * FROM restaurants WHERE est_delivery_time > 40;

-- Task 6
SELECT * FROM restaurants WHERE rating BETWEEN 4.2 AND 4.7;

-- Task 7
SELECT * FROM restaurants WHERE cuisine IN ('South Indian', 'Italian', 'Biryani');

-- Task 8
SELECT * FROM restaurants WHERE owner_name LIKE '%Patil%';

-- Task 9
SELECT * FROM restaurants WHERE brand = restaurant_name;

-- Task 10
SELECT * FROM restaurants WHERE delivery_fee < 30;

-- Task 11
SELECT * FROM restaurants ORDER BY orders_count DESC LIMIT 5;

-- Task 12
SELECT *
FROM restaurants
ORDER BY avg_order_value ASC
LIMIT 5;

-- Task 13
SELECT * FROM restaurants ORDER BY rating DESC;

-- Task 14
SELECT DISTINCT cuisine FROM restaurants;

-- Task 15
SELECT
    restaurant_name AS Restaurant_Name,
    rating AS Customer_Rating
FROM restaurants;

-- Task 16
SELECT restaurant_name, owner_name, brand FROM restaurants;

-- Task 17
SELECT * FROM restaurants ORDER BY city ASC, rating DESC;

-- Task 18
SELECT * FROM restaurants WHERE orders_count > 10000 ORDER BY rating DESC LIMIT 5;

-- Task 19
SELECT * FROM restaurants WHERE city = 'Pune' ORDER BY orders_count DESC LIMIT 3;

-- Task 20
SELECT * FROM restaurants ORDER BY delivery_fee DESC LIMIT 5;

-- Task 21
SELECT restaurant_name FROM restaurants WHERE restaurant_name LIKE 'S%';

-- Task 22
SELECT restaurant_name FROM restaurants WHERE restaurant_name LIKE '%House';

-- Task 23
SELECT restaurant_name FROM restaurants WHERE restaurant_name LIKE '%Cafe%';

-- Task 24
SELECT cuisine FROM restaurants WHERE cuisine LIKE '%Indian%';

-- Task 25
SELECT restaurant_name FROM restaurants WHERE restaurant_name LIKE '_____';

-- Task 26
SELECT owner_name FROM restaurants WHERE owner_name LIKE '%Raj%';

-- Task 27
SELECT brand FROM restaurants WHERE brand LIKE '%Foods%';

-- Task 28
SELECT city FROM restaurants WHERE city LIKE 'P%';

-- Task 29
SELECT * FROM restaurants WHERE avg_order_value > 400 AND rating > 4.5;

-- Task 30
SELECT * FROM restaurants WHERE orders_count > 20000 OR rating > 4.7;

-- Task 31
SELECT * FROM restaurants WHERE city NOT IN ('Pune');

-- Task 32
SELECT * FROM restaurants WHERE est_delivery_time BETWEEN 25 AND 40;

-- Task 33
SELECT * FROM restaurants WHERE avg_order_value BETWEEN 300 AND 600;

-- Task 34
SELECT * FROM restaurants WHERE city IN ('Pune', 'Mumbai');

-- Task 35
SELECT * FROM restaurants WHERE cuisine = 'Fast Food' AND orders_count > 20000;

-- Task 36
SELECT * FROM restaurants WHERE rating > 4.5 AND delivery_fee < 40;

-- Task 37
SELECT * FROM restaurants WHERE city = 'Bengaluru' AND orders_count > 10000;

-- Task 38
SELECT * FROM restaurants WHERE owner_name <> 'Rahul Jain';

-- Challenge 1 — Hidden Gem
SELECT * FROM restaurants WHERE rating > 4.5 AND orders_count < 10000;

-- Challenge 2 — Cheap & Popular
SELECT * FROM restaurants WHERE avg_order_value < 300 AND orders_count > 20000;

-- Challenge 3 — Fast Delivery
SELECT * FROM restaurants WHERE est_delivery_time < 30 AND rating > 4.3;

-- Challenge 4 — Trending Restaurants
SELECT * FROM restaurants WHERE city = 'Mumbai' ORDER BY orders_count DESC LIMIT 3;

-- Challenge 5 — Premium Restaurants
SELECT * FROM restaurants WHERE avg_order_value > (SELECT AVG(avg_order_value) FROM restaurants);

-- Challenge 6 — City Spotlight
SELECT * FROM restaurants WHERE city = 'Pune' ORDER BY orders_count DESC;

-- Challenge 7 — Cuisine Report
SELECT restaurant_name, city, rating, avg_order_value FROM restaurants WHERE cuisine = 'South Indian';

-- Challenge 8 — High Value Partners
SELECT * FROM restaurants WHERE avg_order_value > 500 AND rating >= 4.5;


SELECT restaurant_name, cuisine, city, rating, avg_order_value, orders_count, delivery_fee, owner_name, brand FROM restaurants WHERE rating > 4.4 AND orders_count > 10000 AND avg_order_value BETWEEN 300 AND 700 ORDER BY orders_count DESC LIMIT 5;