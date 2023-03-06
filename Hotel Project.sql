
---Create table to combine 3 tables
CREATE VIEW [HOTELS] AS
select * from dbo.[2018]
union
select * from dbo.[2019]
union
select * from dbo.[2020]


SELECT
arrival_date_year,
hotel,
ROUND(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr),2) as revenue
FROM HOTELS
GROUP BY arrival_date_year,hotel



SELECT * FROM HOTELS
left join dbo.market_segment
on hotels.market_segment=market_segment.market_segment
left join dbo.meal_cost
on  hotels.meal = meal_cost.meal





