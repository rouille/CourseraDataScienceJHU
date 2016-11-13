#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Nobel Prize Data"),
  
  sidebarLayout(
      sidebarPanel(width = 3,
          selectInput('category', 'Category', unique(prizes$category) ),
          dateRangeInput("dates", "Date range", start = "1950-01-01", end = "2000-01-01", 
                         startview = "decade", format = "yyyy" ),
          submitButton("submit")
          ),
    
      mainPanel(
          tabsetPanel(
              tabPanel("Age", htmlOutput("bubble") ),
              br(),
              tabPanel("Gender", htmlOutput("pie") ),
              br(),
              tabPanel("Country", htmlOutput("map") ),
              br(),
              tabPanel("Migration", htmlOutput("sankey") )
              )
          )
      )
))
