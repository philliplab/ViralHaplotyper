library(shiny)

shinyUI(fluidPage(

  #tags$link(rel = "stylesheet", type = "text/css", href="no_wrap_tables.css"),

  titlePanel("Viral Haplotyper"),

  sidebarLayout(
    sidebarPanel(
      fileInput("seq_data", label = h3("Sequence Data")),
      numericInput("hap_name_chars", "Haplotype name length", 10),
      tags$br(),
      actionButton('goButton', 'Get Haplotypes'),
      tags$hr(),
      downloadButton("download_unique_details", "Download Details of Unique Sequences"),
      tags$br(),
      downloadButton("download_unique_sequences", "Download Unique Sequences"),
      tags$br(),
      downloadButton("download_sample_data", "Download Sample Data")
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
