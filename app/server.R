library(shiny)
library(quantmod)
library(data.table)
library(forecast)

shinyServer(
  function(input, output) {
    ticker_data <- reactive({
        t <- input$ticker
        ini_date <- input$dates[1]
        end_date <- input$dates[2]
        file_name <- paste0(t,"-",input$src,"-",ini_date,"-",end_date,".Rdata")
        if (file.exists(file_name)) {
          load(file_name)
        } else {
          getSymbols(t, src=input$src, from=ini_date, to=end_date)
          dat <- get(input$ticker)
          save(dat, file=file_name)}
        dat
      })
    
    op_ts <-reactive({
      ts(Op(to.monthly(ticker_data())), frequency = 12)
      })

    train <- reactive({
      if (!is.integer(input$train)) {
        5 }
      else {
        as.integer(input$train) }
    })
        
    output$plot <- renderPlot({
      ts1Train <- window(op_ts(),start=1,end=train())
      output$train <- renderTable({data.table(ts1Train)})
      ts1Test <- window(op_ts(),start=train())
      output$test <-renderTable({data.table(ts1Test)})
      ets_model <- paste0(input$err, input$trend, input$season)
      ets1 <- ets(ts1Train,model=ets_model)
      fcast <- forecast(ets1)
      output$accuracy <- renderPrint({accuracy(fcast,ts1Test)})
      plot(fcast); lines(ts1Test,col="red")
      lines(ma(op_ts(),5),col="orange")
    })
    output$table <- renderDataTable({cbind(date=index(ticker_data()),
                                           data.table(ticker_data()))})
    
    output$train_slider <- renderUI({
      sliderInput("train", "Train years:",  min = 3, 
                  value = min(round(length(op_ts())/10,0), 5), 
                  max = round(length(op_ts())/12,0),
                  step = 1)
    })
    
  }
)