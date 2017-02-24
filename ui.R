library(shiny)
library(shinythemes)

## I just rearranged the UI a little bit

shinyUI(fluidPage(theme = shinytheme("lumen"),
  h3("Unlimited Test Bank - Confidence Intervals"),
  hr(),
  h4("Enter your answer below and click Answer to check it"),
  h4("or click Next Problem for a new question"),
  hr(),
  h4("Question:"),
  textOutput("Question"),
  hr(),
  numericInput("Low", label = "Lower End of the Interval: ", value = 0, min = -10000, max = 10000, step = 0.05,
               width = NULL),
  numericInput("High", label = "Higher End of the Interval: ", value = 0, min = -10000, max = 10000, step = 0.05,
               width = NULL),
  actionButton("answer", label = "Answer"),
  actionButton("action", label = "Next Problem"),
  hr(),
  mainPanel(
    h4(textOutput("ci")),
    h5(textOutput("cor")),
    h5(textOutput("incor"))
  )
))