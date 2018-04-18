
library(shiny)
library(leaflet)

shinyServer(function(input, output,session) {
  


  observe({
    
    
    spatialQuery <- paste0("SELECT s.* ",
                           "FROM pointwithsepta AS s "
    )
    
    point<- st_read_db(con, query=spatialQuery, geom_column='wkb_geometry')
    
    spatialQuery2 <- paste0("SELECT b.* ",
                           "FROM eachstationcrime AS b "
    )
    
    metrostation<- st_read_db(con, query=spatialQuery2, geom_column='wkb_geometry')
    
    

      output$selectstation <- renderUI({
        stationlist <- arrange(point, station_na)
        stationlist <- unique(stationlist$station_na)
        stationlist <- c("All",stationlist)
        selectInput("station", "Select a station", as.list(stationlist))
      })
      
  
      
      
  output$mymap1 <- renderLeaflet({
    
    if(is.null(input$hour) || input$hour == "All") {
      point2 <- point
    } else {
      point2 <- filter(point,hour == input$hour)  
    }
    
    
    if(is.null(input$station) || input$station == "All") {
      point2 <- point2
    } else {
      point2 <- filter(point2,station_na == input$station)  
    }
    
    
    leaflet() %>%
      addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
      #addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
      addCircleMarkers(data=point2,
                       lng = ~lon,
                       lat = ~lat,
                       radius = 5,
                       fillOpacity = 1,
                       #fillColor = ~paletteBins(-persons),
                       #fillColor = ~paletteFactor(drunk_dr),
                       #fillColor = ~paletteContinuous(latitude + longitud),
                       color = "red",
                       #opacity = 1,
                       stroke=F,
                       #stroke=T,
                       weight = 200,
                       clusterOptions = markerClusterOptions()
                       )

  })
  
  
  output$table <- renderDataTable({
    
    if(is.null(input$hour) || input$hour == "All") {
      point2 <- point
    } else {
      point2 <- filter(point,hour == input$hour)  
    }
    
    
    if(is.null(input$station) || input$station == "All") {
      point2 <- point2
    } else {
      point2 <- filter(point2,station_na == input$station)  
    }
    
    
    datatable(point2, options = list(pageLength = 10, autoWidth = TRUE))
    
  })
  
  
  output$mymap2 <- renderLeaflet({
    
    if(is.null(input$station) || input$station == "All") {
      point3 <- metrostation
    } else {
      point3 <- filter(metrostation,station_na == input$station)  
    }
    
    personBins <- c(0,0.1,50,100,200,300,500,Inf)
    paletteBins <- colorBin(palette = "OrRd", point3$count_  , bins=personBins)
    
    #paletteFactor <- colorFactor(c("blue","green","yellow"), accidentpoints$drunk_dr)
    
    #paletteContinuous <- colorNumeric(palette = "magma", domain = accidentpoints$latitude + accidentpoints$longitud)
    
    
    leaflet() %>%
      addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
      setView( -75.177436,39.988737, zoom = 11)%>%
      #addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
      addCircleMarkers(data=point3,
                       lng = ~longitude,
                       lat = ~latitude,
                       radius = ~sqrt(count_) - 2,
                       fillOpacity = 1,
                       fillColor = ~paletteBins(count_),
                       #fillColor = ~paletteFactor(drunk_dr),
                       #fillColor = ~paletteContinuous(latitude + longitud),
                       color = "white",
                       #opacity = 1,
                       stroke=F,
                       #stroke=T,
                       weight = 200,
                       popup= ~paste0("station: ",station_na,"Crime Count:",count_),
                       label = ~station_na
                
      )
    
  })
  
  
})
}
)



