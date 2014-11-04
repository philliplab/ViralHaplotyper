library(shiny)
library(ViralHaplotyper)
library(toolmania)
options(shiny.maxRequestSize=100*1024^2)

shinyServer(function(input, output, session) {

  read_data <- reactive({
    data_sets <- list()
    data_sets[['success']] <- TRUE
    seq_data <- try(read_seq_data(input$seq_data$datapath))
    if (class(seq_data) == 'try-error') {
      data_sets[['seq_data']] <- list(msg = attr(seq_data, 'condition')$message, 
                                      data_set = NULL)
      data_sets[['success']] <- FALSE
    } else {
      data_sets[['seq_data']] <- list(msg = 'File read successfully',
                                      data_set = seq_data)
    }

    return(data_sets)
  })

  output$data_set <- renderPrint(print(read_data()$seq_data$data_set))

  output$big_phylo <- renderPlot({
    seq_data <- read_data()$seq_data$data_set
    seq_data <- get_data_of('timepoint', seq_data, "_4250V3_")
    seq_data <- unique(seq_data)
    seq_dists <- stringDist(seq_data)
    big_plot <- bionj(seq_dists)
    plot(big_plot, show.tip.label = FALSE)
  })

  output$session_info <- renderPrint(print(as.list(session)))

})
