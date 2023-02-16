-- Creating a database , and also building a table that we will import our csv file --

CREATE SCHEMA project; 

USE project; 

CREATE TABLE calls( 
ID CHAR(50), 
cust_name CHAR(50),
sentiment CHAR(50),
csat_score INT,
call_timestamp CHAR(50),
reason CHAR(20),
city CHAR(20),
state CHAR(20),
channel CHAR(20),
repsonse_time CHAR(20),
call_duration_minutes INT, 
call_center CHAR(20)
);

-- the call_timestamp is a string, so we need to convert it to a date --


SET SQL_SAFE_UPDATES = 0;

UPDATE calls 
SET call_timestamp = DATE_FORMAT(call_timestamp, "%m/%d/%Y");


UPDATE calls
SET csat_score = NULL
WHERE csat_score = 0 ;

SET SQL_SAFE_UPDATES = 1;



-- Exploring the data --

select count(*) as rows_num from calls ;
select count(*) as cols_num from information_schema.columns WHERE table_name = 'calls';

-- checking distinct values -- 

Select distinct sentiment from calls;

Select distinct reason from calls; 

Select distinct channel from calls;

select distinct response_time FROM calls; 

select distinct call_center from calls; 


-- the count and percentage from total of each distinct values we got --

SELECT 
    sentiment,
    COUNT(*),
    ROUND((COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls)) * 100,
            1) AS pct
FROM
    calls
GROUP BY 1
ORDER BY 3 DESC;

SELECT 
    reason,
    COUNT(*),
    ROUND((COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls)) * 100,
            1) AS pct
FROM
    calls
GROUP BY 1
ORDER BY 3 DESC;

SELECT 
    channel,
    COUNT(*),
    ROUND((COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls)) * 100,
            1) AS pct
FROM
    calls
GROUP BY 1
ORDER BY 3 DESC; 

SELECT 
    response_time,
    COUNT(*),
    ROUND((COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls)) * 100,
            1) AS pct
FROM
    calls
GROUP BY 1
ORDER BY 3 DESC; 

SELECT 
    call_center,
    COUNT(*),
    ROUND((COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    calls)) * 100,
            1) AS pct
FROM
    calls
GROUP BY 1
ORDER BY 3;

SELECT 
    state, COUNT(*)
FROM
    calls
GROUP BY 1
ORDER BY 2;



/* Aggregations */

-- Which day has the most calls ? --

SELECT 
    DAYNAME(call_timestamp) AS day_of_call,
    COUNT(*) num_of_calls
FROM
    calls
GROUP BY 1
ORDER BY 2 desc;


-- Finding the min,max,avg of call duration --


SELECT 
    MIN(call_duration_minutes) AS min_call_duration,
    MAX(call_duration_minutes) AS max_call_duration,
    AVG(call_duration_minutes) AS avg_call_duration
FROM
    calls;
    
    
 -- how many calls are within, below or above the Service-Level -Agreement time (SLA) --  
  
 SELECT 
    call_center, response_time, COUNT(*) AS count
FROM
    calls
GROUP BY 1 , 2
ORDER BY 1 , 3 DESC;


-- Average call duration for each call center --

SELECT 
call_center, avg(call_duration_minutes)
FROM calls
GROUP BY 1
ORDER BY 2 DESC;





