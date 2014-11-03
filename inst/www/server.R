library(shiny)
library(ViralHaplotyper)

shinyServer(function(input, output, session) {

  output$test_out <- renderPrint(print(input$msg))
})
