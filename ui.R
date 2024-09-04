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
    titlePanel("Predict horsepower from mpg"),

    # provide an input (slider, checkbox to show whether or not to show a given model) for value of mpg of car
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderMPG", "what is the mpg value of car?", 10, 35, value = 20),
            checkboxInput("showModel1", "Show/Hide model1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide model2", value = TRUE),
        ),

        # Show a plot of the output
        mainPanel(
            plotOutput("Plot"),
            h3("Predicted hp from Model 1:"),
            textOutput("pred1"),
            h3("Predicted hp from Model 2:"),
            textOutput("pred2"),
        )
    )
))

