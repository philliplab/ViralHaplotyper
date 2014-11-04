library(shiny)

shinyUI(fluidPage(

  tags$link(rel = "stylesheet", type = "text/css", href="no_wrap_tables.css"),

  titlePanel("Viral Haplotyper"),

  sidebarLayout(
    sidebarPanel(
      fileInput("seq_data", label = h3("Sequence Data")),
      uiOutput('timepoint'),
      downloadButton('download_big_phylo', 'Download Big Phylog. Plot')
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Input File",
                 verbatimTextOutput("data_set")
                 ),
        tabPanel("Big Phylog. Plot",
                 plotOutput("big_phylo", height = 2000)
                 ),
        tabPanel("Time Points",
                 verbatimTextOutput('all_timepoints')
                 )
        )
    )
  )
))
