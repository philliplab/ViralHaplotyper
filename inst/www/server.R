library(shiny)
library(ViralHaplotyper)
options(shiny.maxRequestSize=100*1024^2)

shinyServer(function(input, output, session) {

  read_data <- reactive({
    data_sets <- list()
    data_sets[['success']] <- TRUE
    seq_data <- try(readAAStringSet(input$seq_data$datapath))
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

  single_haplotypes <- reactive({
    input$goButton
    isolate({
      return(construct_haplotypes(read_data()$seq_data$data_set, 'single', 
                                  n_header_letters = input$hap_name_chars))
    })
  })

  unique_sequence_list <- reactive({
    return(get_unique_sequence_details(single_haplotypes()[[1]]))
  })

  output$unique_table <- renderDataTable({
    return(unique_sequence_list()$details)
  })

  output$unique_sequences <- renderPrint({
    print(unique_sequence_list()$unique_sequences)
  })

  output$data_set <- renderPrint(print(read_data()$seq_data$data_set))

  output$download_unique_details <- downloadHandler(
    filename = function() {'unique_sequence_details.csv'},
    content = function(file){
      write.csv(unique_sequence_list()$details, file, row.names = FALSE)
    }
  )

  output$download_unique_sequences <- downloadHandler(
    filename = function() {'unique_sequences.FASTA'},
    content = function(file){
      writeXStringSet(unique_sequence_list()$unique_sequences, file)
    }
  )

  output$download_sample_data <- downloadHandler(
    filename = function() {'sample_data.FASTA'},
    content = function(file){
      writeXStringSet(get_test_AAStringSet(), file)
    }
  )

})
