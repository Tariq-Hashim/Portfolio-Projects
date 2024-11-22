# Solving the Case study: “How does a bike-share navigate speedy success?” using SQL and Google sheets
## Business Task Statement:
Understanding How Casual Riders and Annual Members Use Cyclistic Bikes
## Business Problem:  
Cyclistic wants to grow its number of annual memberships. The marketing director believes converting casual riders into annual members is the key to future growth. To do this, the team needs to understand how casual riders and annual members use the bikes differently.
## Objective:  
Analyze historical bike trip data to identify key differences in usage patterns between casual riders and annual members. The goal is to uncover trends that can inform a targeted marketing strategy to convert more casual riders into members.
## Scope:  
The analysis will focus on ride data from the past 12 months, comparing casual riders and annual members. Key metrics include ride frequency, duration,  and time of day.
## Data Preparation:
* The data has been made available by Motivate International Inc.
* This is public data that can be used to explore how different customer types are using Cyclistic bikes, but due to privacy I won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.
* All (12 data files) stored in a csv format.
* Data used in this case study is between November 2023 to November 2024.
## Process:
* The data contains nearly 6 millions rows so I prefered to use Microsoft SQL Server to clean and minipulate the data.
* While importing the data into SQL I found errors about some data types, so I had to change 'start_lat' & 'end_lat' columns from smallint to float, 'start_station_name' & 'end_station_name' columns from nvarchar(50) to nvarchar(max). Also I had to allow null values for all the columns, and it worked.
* I,ve checked the data and found no null values, that means no missing data.
* I,ve added a new column 'trip_duration' by calculating the difference between 'started_at' & 'ended_at' dates.
## Analysis:
* Calculate the total rides for each rider type across the week.
* Visualize the number of rides by rider type and weekday using a clustered column chart.
* Analyze the usage patterns to identify any significant trends or differences.
## Dashboard:
![Dashboard](https://github.com/user-attachments/assets/93335cd2-55dd-4e7a-9a6a-1d2f2bfc417d)



  



