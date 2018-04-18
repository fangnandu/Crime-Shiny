
library(shiny)
library(leaflet)
library(rsconnect)
rsconnect::setAccountInfo(name='fangnan', token='F0B5B103AAD0752E2B98682871AC38B2', secret='8z7Bqirt+uxa0xYUN7OXYyoAF6mZuWfjDB2EZcss')
library(rsconnect)



fluidPage(
  
  titlePanel("The Crime interactive tool"),
  hr(),
  fluidRow(
    
    column(6, 
           p("crime distribution based on time and septa station selection"),
           
           leafletOutput("mymap1")
    ),
    column(6,
           p("crime count for select septat station ( click on the station)"),
           
           leafletOutput("mymap2")
    )
  ),
  hr(),
  
  fluidRow(

    column(4, 
           numericInput("hour","hour", min=0, max=23, value=23, step=1)
    ),
    column(4,offset=4, 
           uiOutput("selectstation")
       )
    ),
           
  hr(),
  dataTableOutput('table'),
  hr()

  
)
 # deployApp()
