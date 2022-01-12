
## Task: 

Modeling dataset of fire incidents in the city of San Francisco


## Description:

The dataset was modeled as a star schema, using time dimension, battlion dimension and fire incident dimension. I chose the transformation tool DBT as the transformation layer. I'm getting familiar with the tool as we start exploring it and implementing it at my current employee a month ago.

The project is organized in a staging area and a mart area. The purpose of the staging layer is to recast, rename, deal with nulls in data comming from the source. In our case we got data comming from the San Francisco goverment. If there are new data sources in the future, this will allow to better organize and architecture the data.

The mart area is where we describe business entities and organizational units (business units). Here we modeled fact tables which represents business process and are tailored to the questions an organization wants to answer. In our case, we have the public safety and compliance(example) mart.

There are also empty fact tables (fact losses details and fact structure details) as an example. The fact table modeling will depend on which processes or insight we are intested on.

The fact fire details table is where analysts will run their queries against. I'll write down a few sql statements to ilustrate how to query the table


- select the city with the higher number of fire incidents (I assume that incident_id is unique and is not duplicated)

select count (incident_id) as inc_count,<br/>
        city<br/>
from fact_fires_details<br/>
group by city<br/>
order by inc_count desc<br/>
limit 1<br/>

- select the battalion most demanded in 2019

select count (battlion_id) as bat_count,<br/>
        battlion_id<br/>
from fact_fires_details<br/>
where year = '2019'<br/>
group by battlion_id<br/>
order by bat_count desc<br/>
limit 1<br/>

- select the year having the higher numer of fire incidents intentionally caused 

select count (incident_id) as inc_count,<br/>
        year<br/>
from fact_fires_details<br/>
where ignition_cause = '1 - Intentional'<br/>
group by year<br/>
order by inc_count desc<br/>
limit 1<br/>




## Deliverable:

- star schema url

https://dbdiagram.io/d/61d857bef8370f0a2ee35ca9




## Important Notes

- this DBT project is not completly configured

- DBT is NOT an orchestration tool, so it need to be orchestrated using an appropiate tool for it, such as Airflow. On the other hand, DBT cloud provides an orchestrator. So in the case of paying for using DBT cloud, the orchestration need is covered

- Fact table references to staging tables rather than dimensional tables as shown in the star schema model. I didn't have much time to create those tables, but in this case staging and dimensional entities have the same atributes and data types

- there are basic testing conditions for the data source (csv) in the src_san_francisco_gov.yml file 

- DBT runs on top of a datawarehouse, snowflake for instace

- DBT takes care of the ddl. By running dbt run, dbt will create the schemas for you in the db target if they don't exist

- the comand dbt seed will load a table using the csv files in the seeds dir. The only good use case for this feature is for loading small csv files, such as a list of zip-country codes.

- a mechanism for fetching only new records needs to be implemented (using a timestamp flag). Fetching all data every day would be the least elegant option. I didn't have much free time to implement it 