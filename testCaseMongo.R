library(shiny)

library(RMongo)
library(RJSONIO)

mongo = mongoDbConnect('mytest')

shiny::runApp(list(
  ui = shinyUI(fluidPage(
    titlePanel("Testcase for funny tweet characters"),
  
    sidebarLayout(
      sidebarPanel(
	selectInput("tweetIdx", label = h3("Tweet id"), 
	  choices = c("Tweet 1" = 467347144664313856, "Tweet 2" = 467460399281881088, "Tweet 3" = 467155643015512064))),
      mainPanel(textOutput("tweet"))
    )
  )),
  server = function(input, output) {

    output$tweet <- renderText({ 
	cat("Choosing ", input$tweetIdx, "\n")
	tweettext = dbGetQuery(mongo, 'tweettext', paste('{"tweet":', input$tweetIdx, '}'))$text
	cat(tweettext, " with encoding ", Encoding(tweettext), "\n")
        tweettext
    })
    
  }
), port = 8080, host = "0.0.0.0")
