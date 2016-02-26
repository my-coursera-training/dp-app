---
title       : Stok Forecast
subtitle    : Understanding Exponential Smoothing State Space Model

framework   : io2012        # {io2012, html5slides, shower, dzslides, revealjs, ImpressJS ...}

highlighter : prettify  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

---

## About

This application tries to help in getting a better understanding of the time series forecasting as explained in the lecture *forecast*, of course *Practical Machine Learning*, part of the **Data Science specialization**.

The application allows to select several parameters used to get the data form either Google or Yahoo sources, and configure the model used to train the Exponential smoothing state space model. 

The landing page of the application, contains a brief description and the usage basics fo the aplication, that can be accessed clicking on "app" tab, in the bar at the top of the page.

Initial configuration is the same than that set on the course lecture, but several parameters can be modified to see how their effect on the results.

There are some other controls that have been included mainly to test shinny app functionality, including the train years selector slider control, that is generated in the server script to allow setting dynamically the maximum allowed value, depending on the selected date range.

---

## Application structure

The application consist bassically in a main panel, that shows the information about the gathered data, and a sidebar pannel, that holds the user interface controls.

* Side Panel
 * Ticker: Symbol of the stock. 
 * Date Range: Period of time of intered. Initially set as the example in coure lecture.
 * ETS model parameters: character string identifying method using the framework terminology of Hyndman et al. (2002) and Hyndman et al. (2008). Initially set as the example in coure lecture(MMM).
 * Train years: slider control to select how many of the available years in the downloaded data should be used in ETS model
 * Apply Changes Button: Should be clicked when the parameter selection has been updated. Has been set to avoid unnecesary data request to sources when modifying several parameters at once.

* Main Panel Tabs
 * Plot: Shows the opening pricesof the selected stock usin in training in a black line the values of the testing set in red, and the moving average in orange. The forecast line is in color blue.
 * Accuracy: Accuracy information on the prediction.
 * Table: The values downloaded from the source for the given stock and time frame.
 * Training: Time serie used in training.
 * Testing: Remaining valued used to validate the forecast.

---

##  Application Access and source code

* Application access
 * https://my-coursera-training.shinyapps.io/stock_forecast/

* Slide github web pages:
 * http://my-coursera-training.github.io/dp-app/

* Slide source code
  * <a href="https://github.com/my-coursera-training/gh_pages/dp-app">gh_pages branch</a>

* Application code
  * <a href="https://github.com/my-coursera-training/master/dp-app/app/ui.R">ui.R</a>
  * <a href="https://github.com/my-coursera-training/master/dp-app/app/server.R">server.R</a>

