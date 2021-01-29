####################
###### GLOBAL ######
####################

# Loading the libraries
library(shiny)
library(shinydashboard)
library(dplyr)

# Read in data set
dataset <- read.csv("data/retinopathy_sample_data.csv")
ids <- unique(dataset$retinal_id)

# Source documentation tab
source("./help_tab.R")