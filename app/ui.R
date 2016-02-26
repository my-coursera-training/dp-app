sources = list("yahoo", "google")

ets_params = c("none" = "N", 
               "additive" = "A", 
               "multiplicative" = "M", 
               "auto-Selected" = "Z")

shinyUI(
  navbarPage("Stock Forecast",
    tabPanel("Usage",
             h2("Description"),
             p("This application tries to help in getting a better untderstanding of the time series ",
               "forecasting as explained in the lecture 'forecast', of course 'Practical Machine Learning', ",
               "part of the Coursera Data Science specialization"),
             p("The application allows to select several parameters used to get the data form either Google ",
               "or Yahoo sources, and configure the model used to train the Exponential smoothing state space model"),
             p("The main panel shows the different outputs available (plot, summary, data table and training and testing series)."),
             h3("Side Panel"),
             p("Ticker: Symbol of the stock. Initially set as the example in coure lecture (GOOG)."),
             p("Date Range: Period of time of intered. Initially set as the example in coure lecture."),
             p("ETS model parameters: character string identifying method using the framework terminology ",
               "of Hyndman et al. (2002) and Hyndman et al. (2008). ",
               "Initially set as the example in coure lecture(MMM)."),
             p("Train years: slider control to select how many of the available years in the downloaded data should be used in ETS model"),
             p("Apply Changes Button: Should be clicked when the parameter selection has been updated. Has been set ",
               "to avoid unnecesary data request to sources when modifying several parameters at once."),
             h3("Main Panel Tabs"),
             p("Plot: Shows the opening pricesof the selected stock usin in training in a black line, ",
               "the values of the testing set in red, and the moving average in orange. ", 
               "The forecast line is in color blue"),
             p("Accuracy: Accuracy information on the prediction."),
             p("Table: The values downloaded from the source for the given stock and time frame."),
             p("Training: Time serie used in training."),
             p("Testing: Remaining valued used to validate the forecast")
    ),
    tabPanel("App",
      fluidPage(
        sidebarLayout(
          sidebarPanel(
            textInput(inputId="ticker", value="GOOG", label = "Ticker symbol"),
            dateRangeInput("dates",  label="Dates range", start = "2008-01-01", 
                           end = "2013-12-31"),
            selectInput(inputId="src", label="Source", choices=sources, selected = "google", 
                        multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
            selectInput("err", "ETS error type:",  ets_params[2:4], selected = "M"),
            selectInput("trend", "ETS trend type:",  ets_params[1:4], selected = "M"),
            selectInput("season", "ETS season type:",  ets_params[1:4], selected = "M"),
            uiOutput("train_slider"),
            submitButton()
          ),
          mainPanel(
            tabsetPanel(
              tabPanel("Plot", plotOutput("plot")), 
              tabPanel("Accuracy", verbatimTextOutput("accuracy")),
              tabPanel("Table", dataTableOutput("table")),
              tabPanel("Train", tableOutput("train")),
              tabPanel("Test", tableOutput("test"))
            )
          )
        )
      )
    )
  )
)
