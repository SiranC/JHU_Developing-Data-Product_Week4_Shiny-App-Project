library(shiny)
library(dplyr)
library(lubridate)

#Data loading
covid <- read.csv('covid19.csv', stringsAsFactors= FALSE, header = TRUE)
covid <- covid %>%
    select(pruid, prname,date,numconf,numdeaths,numtotal,numtested,numrecover)
covid$date <- parse_date_time(covid$date, orders = c("ymd", "dmy", "mdy"))

# Define UI for application
ui <- fluidPage(
        #Application Title
        titlePanel("COVID-19 Cases in Canada"),
        
        #Sidebar with multiple slider input
        sidebarLayout(
            sidebarPanel(
                dateRangeInput('date',strong('Select a Period:'),
                               start = '2020-01-31', end = '2020-09-20',
                               min = '2020-01-31', max = '2020-09-20'
                ),
                
                selectInput('region',strong('Select a Region'),
                            c('Canada','British Columbia','Manitoba','New Brunswick',
                              'Newfoundland and Labrador','Northwest Territories',
                              'Nova Scotia', 'Nunavut','Ontario','Prince Edward Island',
                              'Quebec','Repatriated travellers','Saskatchewan','Yukon')
                ),
                
                radioButtons('data_type','Select a data type',
                             c('numconf','numdeaths','numtotal','numtested',
                               'numrecover')
                )
            ),
            
            mainPanel(
                h3("The Progression of COVID-19 Cases in Canda"),
                plotOutput("distPlot"),
                h3('Data Summary'),
                verbatimTextOutput('view'),
                tags$a(href = "https://health-infobase.canada.ca/covid-19/", 
                       "Source: Government of Canada", target = "_blank")
            )
        )
    )

# Define server logic required to plot the data
server <- function(input, output) {

    # subset data
    selected_data <- reactive({
        covid %>%
            select(prname,date,input$data_type)%>%
            filter(prname == input$region,
                   date >= as.POSIXct(input$date[1]) & date <= as.POSIXct(input$date[2]))
    })
    
    output$distPlot <- renderPlot({
        plot(x =  selected_data()$date, y = selected_data()[,3],
             type = 'l', lwd = 2, xlab = 'Date', 
             ylab = paste('Number of Cases in',input$region),
             col = 'purple')
    })
    
    output$view <- renderPrint({
        summary(selected_data())
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
