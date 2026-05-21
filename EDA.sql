  


  with topHost as (

  SELECT 
         host_id,
		 host_name,
		 city,
		 neighbourhood_cleansed,
		 SUM(CASE WHEN room_type = 'Entire home/apt' THEN 1 ELSE 0 END) AS [Entire appartment],
         SUM(CASE WHEN room_type = 'Private room' THEN 1 ELSE 0 END) AS [Private room],
         SUM(CASE WHEN room_type = 'Shared room' THEN 1 ELSE 0 END) AS [Shared room],
         SUM(CASE WHEN room_type = 'Hotel room' THEN 1 ELSE 0 END) AS [Hotel room],
		 count(host_id) as 'listing'
  
  
  FROM [Airbnb].[dbo].[listing]
  group by host_id,
		 host_name,
		 neighbourhood_cleansed,
		 city


  ),
   topHost2 as (
  select *
		,RANK() over(partition by neighbourhood_cleansed order by listing desc) as 'rank_'
  from topHost
  where city = 'Rome'
  )

  select * 
  from topHost2 
  where rank_ <=5





  SELECT TOP (1000) [id]
      ,[listing_url]
      ,[name]
      ,[description]
      ,[neighborhood_overview]
      ,[host_id]
      ,[host_name]
      ,[host_since]
      ,[host_location]
      ,[host_about]
      ,[host_response_time]
      ,[host_response_rate]
      ,[host_acceptance_rate]
      ,[host_is_superhost]
      ,[host_neighbourhood]
      ,[host_listings_count]
      ,[host_total_listings_count]
      ,[host_verifications]
      ,[neighbourhood]
      ,[neighbourhood_cleansed]
      ,[property_type]
      ,[room_type]
      ,[accommodates]
      ,[bathrooms]
      ,[bathrooms_text]
      ,[bedrooms]
      ,[beds]
      ,[amenities]
      ,[price]
      ,[minimum_nights]
      ,[maximum_nights]
      ,[minimum_minimum_nights]
      ,[maximum_minimum_nights]
      ,[minimum_maximum_nights]
      ,[maximum_maximum_nights]
      ,[minimum_nights_avg_ntm]
      ,[maximum_nights_avg_ntm]
      ,[availability_30]
      ,[availability_60]
      ,[availability_90]
      ,[availability_365]
      ,[number_of_reviews]
      ,[number_of_reviews_ltm]
      ,[number_of_reviews_l30d]
      ,[availability_eoy]
      ,[number_of_reviews_ly]
      ,[estimated_occupancy_l365d]
      ,[estimated_revenue_l365d]
      ,[first_review]
      ,[last_review]
      ,[review_scores_rating]
      ,[review_scores_accuracy]
      ,[review_scores_cleanliness]
      ,[review_scores_checkin]
      ,[review_scores_communication]
      ,[review_scores_location]
      ,[review_scores_value]
      ,[calculated_host_listings_count]
      ,[calculated_host_listings_count_entire_homes]
      ,[calculated_host_listings_count_private_rooms]
      ,[calculated_host_listings_count_shared_rooms]
      ,[reviews_per_month]
  FROM [Airbnb].[dbo].[listing]





--avg occupancy per neighbourhoods

SELECT
	neighbourhood_cleansed,
	city,
	round((AVG([estimated_occupancy_l365d]) / 365) * 100,2) AS estimated_occupancy_pct
FROM [Airbnb].[dbo].[listing]
where city = 'Rome' 
and  [estimated_occupancy_l365d] > 0
group by city,
		neighbourhood_cleansed

order by estimated_occupancy_pct desc



--Update the price column in the listing table

Update [Airbnb].[dbo].[listing]
SET price = CAST(CONVERT(DECIMAL(10,2), REPLACE(REPLACE(price, '$', ''), ',', '')) AS INT) 

--alter the column to modify the structure of the table
ALTER TABLE [Airbnb].[dbo].[listing]
ALTER COLUMN price DECIMAL(10,2);


--AVG prices per neighbourhood per day

with avgPricePerNC as (
	SELECT
		neighbourhood_cleansed
	   ,city
	   ,ROUND(AVG([price]),2) as avgPrice
	FROM [Airbnb].[dbo].[listing]
	group by city,
			neighbourhood_cleansed
)

SELECT *
	   ,DENSE_RANK() over(partition by city order by avgPrice desc) as 'rank_'
FROM avgPricePerNC
where city = 'Rome' 
	   


--who makes more money super host or not super host 

---Count of superhost

select 

 sum(case when host_is_superhost = 't' then 1 end) as 'Superhost'
,sum(case when host_is_superhost = 'f' then 1 end) as 'Non-Superhost'

FROM [Airbnb].[dbo].[listing]




--reviews per cities

SELECT [listing_id]
      ,[id]
      ,[date]
      ,[reviewer_id]
      ,[reviewer_name]
      ,[comments]
      ,[city]
      ,[unique_listing_id]
  FROM [Airbnb].[dbo].[reviews]
  where city = 'Amsterdam'


select 
	count(case when city = 'Amsterdam' then 1 end) as 'Amsterdam'
   ,count(case when city = 'Rome' then 1 end) as 'Rome'
   ,count(case when city = 'HongKong' then 1 end) as 'HongKong'

FROM [Airbnb].[dbo].[reviews]



--occupancy rate


SELECT [listing_id]
      ,[date]
      ,[available]
      ,[price]
      ,[adjusted_price]
      ,[minimum_nights]
      ,[maximum_nights]
      ,[city]
  FROM [Airbnb].[dbo].[calendar]
  where city = 'Rome' and [date] >=dateadd(month,datediff(month,0,getdate())-12,0)


SELECT 
 
	  count(case when city = 'Amsterdam' then 1 end) as 'Amsterdam'
     ,count(case when city = 'Rome' then 1 end) as 'Rome'
     ,count(case when city = 'HongKong' then 1 end) as 'HongKong'

FROM [Airbnb].[dbo].[calendar]
WHERE available = 'f'



SELECT 
      city,
      -- Counts the days the properties are empty and ready to rent
      SUM(CASE WHEN available = 't' THEN 1 ELSE 0 END) AS Available_Days,
      
      -- Counts the days the properties are actively booked/blocked
      SUM(CASE WHEN available = 'f' THEN 1 ELSE 0 END) AS Booked_Days
FROM [Airbnb].[dbo].[calendar]
WHERE city IN ('Amsterdam', 'Rome', 'HongKong') -- Optional: Only needed if you have other cities you want to hide
GROUP BY city;





  SELECT

      distinct([review_scores_rating])
      
  FROM [Airbnb].[dbo].[listing]
  order by [review_scores_rating]

SELECT TOP (1000) 
       FORMAT([date], 'yyyy-MM') AS 'YearMonth'
      ,SUM(CASE WHEN available = 'f' THEN 1 ELSE 0 END) AS NotAvailable
      ,SUM(CASE WHEN available = 't' THEN 1 ELSE 0 END) AS Available
      ,[city]
FROM [Airbnb].[dbo].[calendar]
GROUP BY FORMAT([date], 'yyyy-MM'), city
ORDER BY YearMonth, city