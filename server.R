library(shiny)

sd<-round(runif(1,2,15),2)
n<-round(runif(1,35,1234),0)
xbar<-round(runif(1,-5,200),1)
C<-if(runif(1,0,1)<0.3) 0.9 else {
  if(runif(1,0,1)<0.5) 0.95 else 0.99
}

## I just initiated the reactive values outside of the shiny server before the write_question 
## because I believe it makes use of the reactive values
v <- reactiveValues(cor_inc = "", 
                    sd = sd,
                    n = n,
                    xbar = xbar,
                    C = C,
                    correct = 0,
                    incorrect = 0,
                    question_count = 0,
                    test_area = 0)

shinyServer(function(input, output, session){
  observeEvent(input$action, {
    v$cor_inc <- ""
    v$sd<-round(runif(1,2,15),2)
    v$n<-round(runif(1,35,1234),0)
    v$xbar<-round(runif(1,-5,200),1)
    v$C<-if(runif(1,0,1)<0.3) 0.9 else {
      if(runif(1,0,1)<0.5) 0.95 else 0.99
    }  
  })
  
  observeEvent(input$answer, {
    correct_answer1 <- qnorm((1-v$C)/2,v$xbar,v$sd/sqrt(v$n))
    correct_answer2 <- qnorm((1-v$C)/2+v$C,v$xbar,v$sd/sqrt(v$n))
    if (correct_answer1 >= input$Low - 0.01 & correct_answer1 <= input$Low + 0.01 & correct_answer2 >= input$High - 0.01 & correct_answer2 <= input$High + 0.01){
      v$cor_inc <- "Correct!"
      v$correct <- v$correct + 1
    }
    else{
      v$cor_inc <- "Incorrect! Please try again"
      v$incorrect <- v$incorrect + 1
    }
  })
  
  
  output$Question <- renderText(paste("You collect a sample of ",v$n," observations from a population with standard deviation of ",v$sd,". The value of the sample mean is ",v$xbar,". Calculate a ",v$C*100," percent confidence interval for the population mean.",sep=""))
  output$ci <- renderText(v$cor_inc)
  output$cor <- renderText(paste("Correct: ", v$correct))
  output$incor <- renderText(paste("Incorrect: ", v$incorrect))
})