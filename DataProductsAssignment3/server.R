#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    data   <- reactive({filter(prizes, 
                               category == input$category & 
                                   year >= as.character(input$dates[1]) & 
                                   year <= as.character(input$dates[2]) ) } )
    
    # Bubble Chart
    bubble <- reactive({
        ylim = as.numeric(c(min(data()$year), max(data()$year) ) )
        gvisBubbleChart(data(), 
                        idvar = "bornCountryCode", 
                        xvar = "age", 
                        yvar = "year", 
                        colorvar = "share",
                        options = list(width = "800", 
                                       height = "5000", 
                                       axisTitlesPosition = "in",
                                       bubble = "{opacity:'0.75',
                                                  textStyle:{fontSize:20}}",
                                       chartArea = "{left:100,
                                                     top:75,
                                                     width:'90%',
                                                     height:'90%'}",
                                       vAxes = "[{viewWindowMode:'pretty',
                                                  title:'year',
                                                  format:'',
                                                  titleTextStyle:{fontSize:40}}]", 
                                       hAxes = "[{viewWindowMode:'pretty',
                                                  title:'age',
                                                  format:'',
                                                  titleTextStyle:{fontSize:40}}]",
                                       legend = "{format:'',
                                                  position:'top'}") )
    
    })
    output$bubble <- renderGvis({bubble() } )
    
    # Pie chart
    pie <- reactive({
        gender <- as.data.frame(table(data()$gender), stringsAsFactors = FALSE)
        gvisPieChart(gender, 
                     labelvar = "Var1", 
                     numvar = "Freq", 
                     options = list(width = "500", 
                                    height = "500",
                                    legend = "none",
                                    pieSliceText = "label") ) } )
    output$pie <- renderGvis({pie() } )
    
    # Map and Table
    map <- reactive({
        country <- as.data.frame(table(data()$bornCountry), stringAsFactors = FALSE)
        colnames(country)[1] <- "Country"
        M <- gvisGeoChart(country, 
                          locationvar = "Country", 
                          colorvar = "Freq", 
                          options = list(width = "1000", 
                                         height = "800",
                                         colorAxis = "{colors:['blue','red']}") )
        T <- gvisTable(country, options = list(width = "400",
                                               height = "400", 
                                               page = "TRUE",
                                               pageSize = 10,
                                               width = "500") )
        
        gvisMerge(M, T, horizontal = FALSE) 
    })
    output$map <- renderGvis({map() } )
    
    sankey <- reactive({
        connection <- as.data.frame(table(data()$bornCountryCode, data()$diedCountryCode), stringsAsFactors = FALSE)
        migration <- subset(connection, Freq > 0 & Var1 != Var2)

        gvisSankey(migration, 
                   from = "Var1", 
                   to = "Var2", 
                   weight = "Freq",
                   options = list(width = "600",
                                  height = "600",
                                  chartArea = "{left:100,
                                                top:75,
                                                width:'90%',
                                                height:'90%'}") )
    })
    output$sankey <- renderGvis({sankey() } )
})
