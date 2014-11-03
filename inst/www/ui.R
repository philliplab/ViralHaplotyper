library(shiny)

shinyUI(fluidPage(

  tags$link(rel = "stylesheet", type = "text/css", href="no_wrap_tables.css"),

  titlePanel("Viral Haplotyper"),

  sidebarLayout(
    sidebarPanel(
      textInput('msg', 'Message', value = "Hello Word")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("File Details",
                 textOutput("test_out")
                 )
        )
    )
  )
))
