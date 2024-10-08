#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define server logic required to fitting 2 models 
shinyServer(function(input, output) {
  mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20,0)
  model1 <- lm(hp~mpg, data = mtcars)
  model2 <- lm(hp~mpgsp + mpg, data = mtcars)
    
    #create a input var for model 1 and predict
  model1pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model1, newdata = data.frame(mpg =mpgInput))
  })
    # for model 2
  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model2, newdata = data.frame(mpg =mpgInput,
                                          mpgsp = ifelse(mpgInput-20 > 0,
                                                         mpgInput-20, 0)))
  })
  
  #generate plot
  output$Plot <-renderPlot({
    mpgInput <- input$sliderMPG
    plot(mtcars$mpg, mtcars$hp, xlab = "miles per gallon",
         ylab = "horsepower",
         bty = "n", pch = 16, xlim= c(10, 35), ylim = c(50, 350))
    #add fit for model 1
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    # add fit for model2
    if(input$showModel2){
      model2lines <- predict(model2, 
                             newdata = data.frame(mpg = 10:35,
                                                  mpgsp = ifelse(10:35-20 >0, 10:35-20, 0)
                                                  ))
      lines(10:35, model2lines, col ="blue", lwd = 2)
    }
    legend(25, 250, c("model1 prediction", "model2 prediction"), pch = 16, col = 
             c("red", "blue"), bty = "n", cex = 1.2)
    points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1<-renderText({model1pred()})
  output$pred2<-renderText({model2pred()
    })
  })
