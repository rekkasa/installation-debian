#!/usr/bin/env Rscript

cat("\n\nInstall important packages\n")
install.packages(
  c(
    "tidyverse", "shiny", "shinydashboard", "devtools",
    "data.table", "DT", "gridExtra", "rmarkdown",
    "plotly", "rstudioapi", "tinytex"
  )
)

cat("\n\nInstall tinytex\n")
tinytex::install_tinytex()

# cat("\n\nInstall themes\n")
# devtools::install_github("gadenbuie/rsthemes")
