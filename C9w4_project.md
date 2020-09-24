Developing Data Products Week4 Project
========================================================
author: SiranC
date: 09/21/2020
autosize: true

Project Instructions
========================================================
This peer assessed assignment has two parts. First, you will create a Shiny application and deploy it on Rstudio's servers. Second, you will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application.

Your Shiny Application

1. Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application.
2. Deploy the application on Rstudio's shiny server
3. Share the application link by pasting it into the provided text box
4. Share your server.R and ui.R code on github

The application must include the following:

1. Some form of input (widget: textbox, radio button, checkbox, ...)
2. Some operation on the ui input in sever.R
3. Some reactive output displayed as a result of server calculations
4. You must also include enough documentation so that a novice user could use your application.
55. The documentation should be at the Shiny website itself. Do not post to an external link.

Project Overview
========================================================

In this project, the Canada COVID-19 cases data from Government of Canada( https://health-infobase.canada.ca/covid-19/) was used to create a Shiny application showing the case number of COVID-19 cross the country by 09/20/2020.

Data Process
========================================================


```r
library(dplyr)
library(lubridate)

covid <- read.csv('covid19.csv', stringsAsFactors= FALSE, header = TRUE)
covid <- covid %>%
    select(pruid, prname,date,numconf,numdeaths,numtotal,numtested,numrecover)
covid$date <- parse_date_time(covid$date, orders = c("ymd", "dmy", "mdy"))

head(covid)
```

```
  pruid           prname       date numconf numdeaths numtotal numtested
1    35          Ontario 2020-01-31       3         0        3        NA
2    59 British Columbia 2020-01-31       1         0        1        NA
3     1           Canada 2020-01-31       4         0        4        NA
4    35          Ontario 2020-02-08       3         0        3        NA
5    59 British Columbia 2020-02-08       4         0        4        NA
6     1           Canada 2020-02-08       7         0        7        NA
  numrecover
1         NA
2         NA
3         NA
4         NA
5         NA
6         NA
```

Shiny Application
========================================================
The shiny application has an interactive plot showing the different types of cases number within Canada during this pandemic period.  
![plot of chunk unnamed-chunk-2](C9w4_project-figure/unnamed-chunk-2-1.png)
