# Crime-Shiny
## This is a interactive map for visualize the crime data in the philadelphia and identify the crime count for each septa station


## interaction tool;
### using hour selector and septa station selector 
    map1: the crime distribution based on hour and septa location( crimes within 1000m for each station)
    map2: each septa crime count 

## Assignment Steps:
#### 1. collect data
     the dataset is two:
     one : the crime data from 2016-2017 (sepcific fruad type)
     two : the septa station data
     third: the phily boundary
     
#### 2. the ui design
     the thought to mention:
     put two maps to better visualize the crime data
     put one table for obviously show the user the raw data
  
 #### 3. the server design
     using the postgis to load the data
     using the observe to excute the filter funtion
     using the ifesle to better interact with the input
     Add two selector simultaneously by put into same scope
######   challenge 
- 1 in the server sector, using the sql for the spatial select, which can not work. so did the process in gis, then write in to the database, and then read it through sql
- 2 the second map( can not add legend for the point; only for the polygon; need more work to add legend)
- 3 change the color of the layout(ui)
   need to learn more about the java script and CSS plugin for futher layout adjustment 

