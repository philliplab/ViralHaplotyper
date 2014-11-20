#' Runs the shiny app for this package
#' 
#' @export

run_ViralHaplotyper_app <- function(port = 5437){
  packageDir <- find.package('ViralHaplotyper')
  shinyAppDir <- file.path(packageDir, "www") 
  if (is.null(port)){
    runApp(shinyAppDir, host = "0.0.0.0")
  } else {
    runApp(shinyAppDir, port = port, host = "0.0.0.0")
  }
}
