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
        tabPanel("Unique Sequences Counts",
                 plotOutput('cc_plot'),
                 plotOutput('ecdf_plot_of_cc')
                 ),
        tabPanel("Big Phylog. Plot",
                 plotOutput("big_phylo", height = 2000)
                 ),
        tabPanel("Small Phylog. Plot",
                 plotOutput("small_phylo")
                 #verbatimTextOutput("small_phylo")
                 ),
        tabPanel("Cluster Output",
                 verbatimTextOutput('cluster_output')
                 ),
        tabPanel("Time Points",
                 verbatimTextOutput('all_timepoints')
                 ),
        tabPanel("Debug",
                 verbatimTextOutput('debug')
                 )
        )
    )
  )
))
