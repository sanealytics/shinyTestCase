library(shiny)

randomTweets <- c("RT @sperez_21: But when I hit my head on Priscilla's car because I was saying hi to her mom😂😂 @iam_prisscilla @JulioOrnelas13",
 "RT @alextongol: Truck needed a wash 😅,afrausto09")


shiny::runApp(list(
  ui = shinyUI(fluidPage(
    titlePanel("Testcase for funny tweet characters"),
  
    sidebarLayout(
      sidebarPanel(
	selectInput("tweetIdx", label = h3("Tweet id"), 
	  choices = c("Tweet 1" = 1, "Tweet 2" = 2))),
      mainPanel(textOutput("tweet"))
    )
  )),
  server = function(input, output) {

    output$tweet <- renderText({ 
	cat("Choosing ", input$tweetIdx, "\n")
	tweettext <- randomTweets[as.numeric(input$tweetIdx)]
	cat(tweettext, " with encoding ", Encoding(tweettext), "\n")
        tweettext
    })
    
  }
), port = 8080, host = "0.0.0.0")
