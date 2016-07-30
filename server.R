

library(shiny)
library(twitteR)
library(shinydashboard)
library(tm)
library(wordcloud)
library(plyr)


#saoudiTrends <- getTrends(23424938)
#japanTrends <- getTrends(23424856)
#franceTrends <- getTrends(23424819)
#egypteTrends <- getTrends(23424802)
#algeriaTrends <- getTrends(23424740)
#southAfricaTrends <- getTrends(23424942)
#pakistanTrends <- getTrends(23424922)
#indiaTrends <- getTrends(23424848)
#bahrainTrends <- getTrends(23424753)
#AustriaTrends <- getTrends(23424750)
#ArgentinaTrends <- getTrends(23424747)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  
  #set twitter connection parametters
  api_key <- 'xgpUFoHWn8v13eXx0ifmeUZQa'
  api_secret <- 'laSHlJHGXDVoaQCThGpSg6grsJxvdRQbJ456OFijQEyhcUqzbh'
  access_token <- '733355867073085440-Q3mtgOkfF2dsf65mAIsTqdgcRpOOS02'
  access_token_secret <- 'zFvnHLpbVnoUn76gj7xfqEmcoM7gl1CpZL2v72OK26UDH'
  
  
  
  #set connection to twitter
  options(httr_oauth_cache = TRUE)
  setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
  
  
  
  #id <- reactive({
  #  if(country=="world") 1
  #  else 23424848
  #})
  
  #Trends <- getTrends('weekly', as.character(Sys.Date()-1))
  Trends <- getTrends(1)
  dim(Trends)
  
  
  class(Trends)
  
  Trends_names<-Trends$name
  
  Trends_text<-sapply(Trends_names, function(x) x)
  Trends_text
  
  #enc2native(Trends_text)
  
  output$tweet<- renderText(Trends_text)
  #output$table <- renderTable(Trends["name"],30)
  output$table <- renderTable(Trends["name"],30)
  #for(i in head(Trends[c(1)],30)){
   # output$tweet <- renderText(i)
  #}
#  Trends <- getTrends(id()) 
  
  country <- reactive({
    input$Location
  })
  output$country <- renderText(country())
  
  
  
  #output$table <- renderTable(head(Trends[1],10))

  #output$title <- renderText("Top 10 trends in the world")
  #output$table <- reactiveTable({
  #  Trends <- reactive({
  #    getTrends(id())
  #  })
  #    renderTable(head(Trends[c(1)],10))
  #}) 
  
  ##################################################################
  
  
  
  output$theWord <- renderText(wordToSearch())
  
  output$currentTime <- renderText({invalidateLater(1000, session)
    paste("Current time: ",Sys.time())})
  

  
  observeEvent(input$do, {
    
    #dataInput <- reactive({  
      tweets <- twListToDF(searchTwitter(input$wordToSearchInput, n = 100)) 
    #})
    
    output$tweetsResult <- renderTable(
      #dataInput()[c("text")]
      tweets[c("text")]
    )
    
  })
  
  
  
  
  
  
  # rawData <- (function(){
  #   tweets <- searchTwitter(input$wordToSearchInput, n=1000,lang=en)
  #   twListToDF(tweets)
  # })
  # 
  # 
  # output$tweetsResult <- renderTable(function(){
  #   head(rawData()[1],n=5)
  # })
  # 
  
  
    
 #  tweets = reactive({
 #   searchTwitteR(wordToSearch, n=1000, lang=en)
 # })
 #  
 #    tweets.text=laply(tweets,function(t)t$getText())
 #  
 #    for(tweet in tweets.text){
 #    output$tweets_result <- renderText(tweets.text)
 #   
 #  }
 #  
 #  
  
  # observe({
  #   invalidateLater(60000,session)
  #   count_positive = 0
  #   count_negative = 0
  #   count_neutral = 0
  #   positive_text <- vector()
  #   negative_text <- vector()
  #   neutral_text <- vector()
  #   vector_users <- vector()
  #   vector_sentiments <- vector()
  #   tweets_result = ""
  #   tweets_result = searchTwitter("wordToSearchInput")
  #   for (tweet in tweets_result){
  #     print(paste(tweet$screenName, ":", tweet$text))
  #     vector_users <- c(vector_users, as.character(tweet$screenName));
  #     if (grepl("lindo", tweet$text, ignore.case = TRUE) == TRUE | grepl("Wonderful", tweet$text, ignore.case = TRUE) | grepl("Awesome", tweet$text, ignore.case = TRUE)){
  #       count_positive = count_positive + 1
  #      # print("positivo")
  #       vector_sentiments <- c(vector_sentiments, "Positive")
  #       positive_text <- c(positive_text, as.character(tweet$text))
  #     } else if (grepl("Boring", tweet$text, ignore.case = TRUE) | grepl("I'm sleeping", tweet$text, ignore.case = TRUE)) {
  #       count_negative = count_negative + 1
  #     # print("negativo")
  #       vector_sentiments <- c(vector_sentiments, "Negative")
  #       negative_text <- c(negative_text, as.character(tweet$text))
  #     } else {
  #       count_neutral = count_neutral + 1
  #     #  print("neutral")
  #       vector_sentiments <- c(vector_sentiments, "Neutral")
  #       neutral_text <- c(neutral_text, as.character(neutral_text))
  #     }
  #   }
  #   df_users_sentiment <- data.frame(vector_users, vector_sentiments)
  #   output$tweets_table = renderDataTable({
  #     df_users_sentiment
  #   })
  # 
  #   output$distPlot <- renderPlot({
  #     results = data.frame(tweets = c("Positive", "Negative", "Neutral"), numbers = c(count_positive,count_negative,count_neutral))
  #     barplot(results$numbers, names = results$tweets, xlab = "Sentiment", ylab = "Counts", col = c("Green","Red","Blue"))
  # 
  #   })
  # })
})
  
  

