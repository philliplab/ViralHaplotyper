library(shiny)

shinyUI(fluidPage(

  #tags$link(rel = "stylesheet", type = "text/css", href="no_wrap_tables.css"),

  titlePanel("Viral Haplotyper"),

  sidebarLayout(
    sidebarPanel(
      fileInput("seq_data", label = h3("Sequence Data"))
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Input File",
                 verbatimTextOutput("data_set")
                 ),
        tabPanel("Unique Sequence Details",
                 dataTableOutput('unique_table')
                 ),
        tabPanel("Unique Sequences",
                 verbatimTextOutput("unique_sequences")
                 )
        )
    )
  )
))
