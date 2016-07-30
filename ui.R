#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  includeCSS("custom.css"),
  
  
  
  
  
  # Application title
  div(
    id='mydiv',
    h1("Twitter Analytics Dashboard")
  ),
  
  
  sidebarPanel(
    
    textInput("wordToSearchInput","Search an events or hashtag"),
    actionButton("do", "Search"),
    tableOutput("tweetsResult")
    #textOutput("theWord")
  ),
  
  
  # Trends World USA France
  h3("Trends per location"),
  sidebarPanel(
    helpText("you can select a Location"),
    selectInput("Location","Select location", choices = c("World","USA","France","Saoudi Arabia"),selected = "World"),
    
    
    h3(textOutput("Trends")),
    paste("you have selected this"),

    textOutput("country"),
    #textOutput('tweet'),
    tableOutput('table'),
    
    box(width = NULL, status = "warning",
        selectInput("interval", "Refresh interval",
                    choices = c(
                      "30 seconds" = 30,
                      "1 minute" = 60,
                      "2 minutes" = 120,
                      "5 minutes" = 300,
                      "10 minutes" = 600
                    ),
                    selected = "60"
        ),
        uiOutput("timeSinceLastUpdate"),
        actionButton("refresh", "Refresh now"),
        p(class = "text-muted",
          br(),
          "Source data updates every 30 seconds."
        )
    )
  ),
  
  h1(textOutput("currentTime")),   #Here, I show a real time clock
  h4("Tweets:"),   #Sidebar title
  sidebarLayout(
    sidebarPanel(
      dataTableOutput('tweets_table') #Here I show the users and the sentiment
    ),
    sidebarLayout(
      sidebarPanel(
        
        fluidRow(
          
          plotOutput("distPlot") 
        )
      ),
    
      
    # Show a plot of the generated distribution
    mainPanel(
     
      
        #Senttiment analysis
      #barplot("where",height=350)
      #tableOutput("table")
    )
  
  )
)
)
)
