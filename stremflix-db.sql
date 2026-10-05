CREATE DATABASE streamflix;
USE streamflix;

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    language VARCHAR(30),
    rating DOUBLE,
    price DOUBLE,
    views INT,
    release_year INT,
    director VARCHAR(100),
    production_company VARCHAR(100)
);

INSERT INTO movies (movie_id, title, genre, language, rating, price, views, release_year, director, production_company) VALUES
(101, 'Avengers: Endgame', 'Action', 'English', 8.4, 199, 950000, 2019, 'Anthony Russo & Joe Russo', 'Marvel Studios'),
(102, '3 Idiots', 'Comedy', 'Hindi', 8.4, 149, 1200000, 2009, 'Rajkumar Hirani', 'Vinod Chopra Films'),
(103, 'Drishyam', 'Thriller', 'Hindi', 8.2, 129, 850000, 2015, 'Nishikant Kamat', 'Panorama Studios'),
(104, 'Interstellar', 'Sci-Fi', 'English', 8.7, 249, 1100000, 2014, 'Christopher Nolan', 'Warner Bros. Pictures'),
(105, 'KGF: Chapter 1', 'Action', 'Kannada', 8.4, 179, 1400000, 2018, 'Prashanth Neel', 'Hombale Films'),
(106, 'KGF: Chapter 2', 'Action', 'Kannada', 8.4, 199, 1800000, 2022, 'Prashanth Neel', 'Hombale Films'),
(107, 'RRR', 'Action', 'Telugu', 8.0, 199, 2100000, 2022, 'S. S. Rajamouli', 'DVV Entertainment'),
(108, 'Baahubali: The Beginning', 'Epic', 'Telugu', 8.0, 179, 1900000, 2015, 'S. S. Rajamouli', 'Arka Media Works'),
(109, 'Baahubali 2: The Conclusion', 'Epic', 'Telugu', 8.2, 199, 2500000, 2017, 'S. S. Rajamouli', 'Arka Media Works'),
(110, 'Pushpa: The Rise', 'Action', 'Telugu', 7.6, 179, 1700000, 2021, 'Sukumar', 'Mythri Movie Makers'),
(111, 'Pushpa 2: The Rule', 'Action', 'Telugu', 6.1, 199, 2300000, 2024, 'Sukumar', 'Mythri Movie Makers'),
(112, 'Jawan', 'Action', 'Hindi', 6.9, 199, 2200000, 2023, 'Atlee', 'Red Chillies Entertainment'),
(113, 'Pathaan', 'Action', 'Hindi', 5.8, 179, 1600000, 2023, 'Siddharth Anand', 'Yash Raj Films'),
(114, 'Dangal', 'Sports', 'Hindi', 8.3, 159, 1300000, 2016, 'Nitesh Tiwari', 'Aamir Khan Productions'),
(115, 'PK', 'Comedy', 'Hindi', 8.1, 149, 1250000, 2014, 'Rajkumar Hirani', 'Vinod Chopra Films'),
(116, 'Munna Bhai M.B.B.S.', 'Comedy', 'Hindi', 8.1, 99, 900000, 2003, 'Rajkumar Hirani', 'Vinod Chopra Films'),
(117, 'Chhichhore', 'Comedy', 'Hindi', 8.3, 129, 1050000, 2019, 'Nitesh Tiwari', 'Fox Star Studios'),
(118, 'Taare Zameen Par', 'Drama', 'Hindi', 8.3, 119, 780000, 2007, 'Aamir Khan', 'Aamir Khan Productions'),
(119, 'Zindagi Na Milegi Dobara', 'Drama', 'Hindi', 8.2, 139, 980000, 2011, 'Zoya Akhtar', 'Excel Entertainment'),
(120, 'War', 'Action', 'Hindi', 6.5, 189, 1500000, 2019, 'Siddharth Anand', 'Yash Raj Films'),
(121, 'Dhoom', 'Action', 'Hindi', 6.6, 109, 720000, 2004, 'Sanjay Gadhvi', 'Yash Raj Films'),
(122, 'Dhoom 2', 'Action', 'Hindi', 6.5, 129, 860000, 2006, 'Sanjay Gadhvi', 'Yash Raj Films'),
(123, 'Dhoom 3', 'Action', 'Hindi', 5.4, 149, 920000, 2013, 'Vijay Krishna Acharya', 'Yash Raj Films'),
(124, 'Bahubali Returns', 'Fantasy', 'Hindi', 7.1, 139, 410000, 2020, 'Demo Director', 'StreamFlix Originals'),
(125, 'Robot', 'Sci-Fi', 'Tamil', 7.1, 129, 680000, 2010, 'S. Shankar', 'Sun Pictures'),
(126, 'Enthiran 2.0', 'Sci-Fi', 'Tamil', 6.2, 169, 760000, 2018, 'S. Shankar', 'Lyca Productions'),
(127, 'Vikram', 'Action', 'Tamil', 8.3, 189, 1450000, 2022, 'Lokesh Kanagaraj', 'Raaj Kamal Films International'),
(128, 'Master', 'Action', 'Tamil', 7.3, 159, 1120000, 2021, 'Lokesh Kanagaraj', 'XB Film Creators'),
(129, 'Kantara', 'Drama', 'Kannada', 8.2, 149, 1350000, 2022, 'Rishab Shetty', 'Hombale Films'),
(130, 'Charlie 777', 'Adventure', 'Kannada', 8.0, 139, 740000, 2022, 'Kiranraj K', 'Paramvah Studios');

SELECT * FROM movies;

SELECT * FROM movies WHERE rating > 8;
SELECT * FROM movies WHERE price < 150;
SELECT * FROM movies WHERE language = 'Hindi';
SELECT * FROM movies WHERE views > 1000000;
SELECT * FROM movies WHERE release_year > 2015;
SELECT * FROM movies WHERE rating BETWEEN 8 AND 8.5;
SELECT * FROM movies WHERE genre IN ('Action', 'Comedy', 'Thriller');
SELECT * FROM movies WHERE director = 'S. S. Rajamouli';
SELECT * FROM movies WHERE production_company = 'Hombale Films';
SELECT * FROM movies WHERE production_company = 'Arka Media Works';

SELECT * FROM movies ORDER BY views DESC LIMIT 5;
SELECT * FROM movies ORDER BY price ASC LIMIT 5;
SELECT * FROM movies ORDER BY rating DESC;
SELECT DISTINCT language FROM movies;
SELECT title AS Movie, rating AS IMDb_Rating FROM movies;
SELECT title, director, production_company FROM movies;
SELECT * FROM movies ORDER BY production_company ASC, rating DESC;
SELECT * FROM movies WHERE release_year > 2015 ORDER BY rating DESC LIMIT 5;
SELECT * FROM movies WHERE language = 'Telugu' ORDER BY views DESC LIMIT 3;
SELECT * FROM movies ORDER BY price DESC LIMIT 5;

SELECT * FROM movies WHERE title LIKE 'A%';
SELECT * FROM movies WHERE title LIKE '%a';
SELECT * FROM movies WHERE title LIKE '%Baahubali%';
SELECT * FROM movies WHERE title LIKE '%Dhoom%';
SELECT * FROM movies WHERE title LIKE '_____';
SELECT * FROM movies WHERE director LIKE '%Raj%';
SELECT * FROM movies WHERE production_company LIKE '%Films%';
SELECT * FROM movies WHERE language LIKE 'T%';

SELECT * FROM movies WHERE price > 150 AND rating > 8;
SELECT * FROM movies WHERE views > 1000000 OR rating > 8.5;
SELECT * FROM movies WHERE genre <> 'Horror';
SELECT * FROM movies WHERE release_year BETWEEN 2015 AND 2020;
SELECT * FROM movies WHERE price BETWEEN 100 AND 200;
SELECT * FROM movies WHERE language IN ('Hindi', 'Telugu');
SELECT * FROM movies WHERE genre = 'Action' AND views > 1000000;
SELECT * FROM movies WHERE director = 'S. S. Rajamouli' AND rating > 8;
SELECT * FROM movies WHERE production_company = 'Hombale Films' AND release_year > 2019;
SELECT * FROM movies WHERE director <> 'S. S. Rajamouli';

SELECT * FROM movies WHERE rating > 8 AND views < 500000;
SELECT * FROM movies WHERE price < 150 AND views > 1000000;
SELECT * FROM movies WHERE language = 'English' AND release_year > 2015 AND rating > 8.5;
SELECT * FROM movies WHERE release_year > 2020 ORDER BY views DESC LIMIT 3;
SELECT * FROM movies WHERE price > (SELECT AVG(price) FROM movies);
SELECT * FROM movies WHERE director = 'S. S. Rajamouli' ORDER BY release_year ASC;
SELECT title, release_year, rating, views FROM movies WHERE production_company = 'Hombale Films';
SELECT * FROM movies WHERE title LIKE '%Baahubali%' OR title LIKE '%KGF%';

SELECT title, genre, rating, price, views, director, production_company
FROM movies
WHERE rating > 8
AND views > 500000
AND price BETWEEN 100 AND 250
ORDER BY views DESC
LIMIT 5;