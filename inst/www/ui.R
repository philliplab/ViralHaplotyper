library(shiny)

shinyUI(fluidPage(

  tags$link(rel = "stylesheet", type = "text/css", href="no_wrap_tables.css"),

  titlePanel("Viral Haplotyper"),

  sidebarLayout(
    sidebarPanel(
      fileInput("seq_data", label = h3("Sequence Data")),
      textInput('msg', 'Message', value = "Hello Word")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("File Details",
                 verbatimTextOutput("test_out")
                 )
        )
    )
  )
))
