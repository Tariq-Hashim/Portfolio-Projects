--Inserting all the data into one table t1

insert into t1
select * 
from t2

insert into t1
select * 
from t3

insert into t1
select * 
from t4

insert into t1
select *
from t5

insert into t1
select * 
from t6

insert into t1
select *
from t7

insert into t1
select * 
from t8

insert into t1
select *
from t9

insert into t1
select * 
from t10

insert into t1
select * 
from t11

insert into t1
select * 
from t12


select * 
from t1

--Calculate trip duration by minutes

select DATEDIFF(minute, started_at, ended_at) as trip_duration
from t1



select AVG (DATEDIFF(MINUTE,started_at,ended_at)) as avg_trip_duration_for_casuals
from t1
where member_casual = 'casual'


select AVG (DATEDIFF(MINUTE,started_at,ended_at)) as avg_trip_duration_for_members
from t1
where member_casual = 'member'


--Usage pattern throughout the week

select count(member_casual) as num_of_casual_rides,
 DATEPART(weekday, started_at) as week_days
from t1
where member_casual = 'casual'
group by DATEPART(weekday, started_at)
order by num_of_casual_rides desc


select count(member_casual) as num_of_member_rides,
 DATEPART(weekday, started_at) as week_days
from t1
where member_casual = 'member'
group by DATEPART(weekday, started_at)
order by num_of_member_rides desc









