
library(shiny)
library(shinydashboard)
library(dplyr)

# Read in data set
dataset <- read.csv("data/retinopathy_sample_data.csv")
ids <- unique(dataset$retinal_id)
