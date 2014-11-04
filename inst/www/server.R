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

  seq_dists <- reactive({
    seq_data <- read_data()$seq_data$data_set
    seq_data <- get_data_of('timepoint', seq_data, input$timepoint)
    seq_data <- unique(seq_data)
    seq_dists <- stringDist(seq_data)
    return(seq_dists)
  })

  output$data_set <- renderPrint(print(read_data()$seq_data$data_set))

  output$cc_plot <- renderPlot({
    seq_data <- read_data()$seq_data$data_set
    seq_data <- get_data_of('timepoint', seq_data, input$timepoint)
    table_table <- table(table(seq_data))
    table_table <- data.frame(number_of_copies = as.numeric(attr(table_table,                 
                                                      'dimnames')[[1]]),                  
                              number_of_sequences = as.numeric(table_table))
    print(plot_the_counts_of_the_counts(table_table))
  })

  output$ecdf_plot_of_cc <- renderPlot({
    seq_data <- read_data()$seq_data$data_set
    seq_data <- get_data_of('timepoint', seq_data, input$timepoint)
    table_table <- table(table(seq_data))
    table_table <- data.frame(number_of_copies = as.numeric(attr(table_table,                 
                                                      'dimnames')[[1]]),                  
                              number_of_sequences = as.numeric(table_table))
    tt <- table_table
    x <- tt[,1]*tt[,2]                                  
    ecdf_of_cc <- data.frame(y = cumsum(rev(x)),
                            x = rev(tt$number_of_copies))                                 
    p <- plot_ecdf_of_counts_of_the_counts(ecdf_of_cc)
    print(p)                      
  })

  output$debug <- renderPrint({
    print(count_the_counts_of_the_sequences)
  })

  output$big_phylo <- renderPlot({
    big_plot <- bionj(seq_dists())
    plot(big_plot, show.tip.label = FALSE)
  })

  output$download_big_phylo <- downloadHandler(
    filename = function() {paste0('big_phylog_', floor(runif(1)*(10^16)), 'pdf')},
    content = function(file){
      temp_name <- paste0(floor(runif(1)*(10^16)), '.pdf')
      pdf(temp_name, width = 10, height = 25)
      big_plot <- bionj(seq_dists())
      plot(big_plot, show.tip.label = FALSE)
      dev.off()
      file.copy(temp_name, file)
      file.remove(temp_name)
    },
    contentType = 'application/pdf'
  )

  output$all_timepoints <- renderPrint({print(get_unique_points_of('time', 
    read_data()$seq_data$data_set, sep = '_', indx = 2))})

  output$timepoint <- renderUI({
    if (!read_data()$success){
      return()
    } else {
      all_time_points <- get_unique_points_of('time', 
                                              read_data()$seq_data$data_set, 
                                              sep = '_', 
                                              indx = 2)
      all_time_points <- sort(all_time_points)
      return(selectInput('timepoint', 
                         label = h3("Time Point"), 
                         choices = all_time_points,
                         selected = all_time_points[1]))
    }
  })

  output$session_info <- renderPrint(print(as.list(session)))
})
