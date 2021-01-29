####################
###### SERVER ######
####################

server <- function(input, output, session) {
  
  # Add folder to store images for app
  addResourcePath("images", "images")
  
  values <- reactiveValues(i = 1)
  
  observe({
    input$increment
    isolate({
      values$i <- ifelse((values$i + 1) %% 10 == 0,
                         1,
                         (values$i + 1) %% 10)
    })
  })
  
  # Generate patient banner
  output$patient_banner <- renderUI({
    gender <- dataset$gender[dataset$retinal_id == ids[values$i]][1]
    HTML(paste0(
      '<div id="textbox"><p class="alignleft" style="font-size:20px"><b>',
      dataset$name[dataset$retinal_id == ids[values$i]][1],
      '</b></p><p class="alignright">DOB: <b> 14-Jul-1954 </b> Gender: <b>',
      gender,
      '</b> NHS No:<b> 123456789</b><br></p></div>
      <div><p class="alignright">Address:<b> 09 The Street, The City, AA11 A1A </b><br></p></div>
      <div><p class="alignright">Phone:<b> 07700099900</b></p></div>
      <div style="clear: both;"></div>'
    ))
  })
  
  # Generate filenames for retinal images for selected patient
  filename_left <- reactive({
    paste0("images/", ids[values$i], "_left.jpeg")
  }) 
  
  filename_right <- reactive({
    paste0("images/", ids[values$i], "_right.jpeg")
  })
  
  # Get images for selected patient
  output$logo_l <- renderUI({
    img(src = filename_left(), width = "100%")
  })
  
  output$logo_r <- renderUI({
    img(src = filename_right(), width = "100%")
  })
  
  # function for ui chunk with checked circles and text
  checked_ui <- function(which_checked, text) {
    colours <- c("green", "yellow", "orange", "red", "DarkRed")
    classes <- rep('"fa fa-circle-thin fa-5x"', 5)
    classes[which_checked] <- '"fa fa-check-circle fa-5x"'
    lines <- paste0("<i class =", classes, " style=\"color: ", colours, ";\"></i>")
    lines <- paste(lines, collapse = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
    
    final_line <- paste0("<div class=\"strokeme\"><h2 style=\"color: ", colours[which_checked], ";\"><b>", text, "</b></h2></div>")
    HTML(paste0(lines, final_line))
  }
  
  # Generate correct symbols & description to display for patients score
  output$choose_symbol <- renderUI({
    which_checked <- dataset$score[dataset$retinal_id == ids[values$i]][1] + 1
    text <- switch(which_checked, "None", "Mild", "Moderate", "Severe", "Proliferative")
    checked_ui(which_checked, text)
  })
  
  # Generate clinical history table for selected patient
  output$clin_history <- renderDataTable({
    dt <- dataset[dataset$retinal_id == ids[values$i], c("event_dt", "location", "clinician", "event_type",
                                                         "description", "event_result", "event_measure_id")]
    names(dt) <- c("Date", "Location", "Clinician", "Event", "Description", "Result", "Code")
    dt %>% 
      filter(!is.na(Date)) %>%
      arrange(desc(Date)) %>%
      mutate(Result = round(Result, 1), Code = round(Code, 1))
  }, options = list(pageLength = 5, searching = FALSE, lengthChange = FALSE, 
                    columnDefs = list(list(targets = 0:6, searchable = FALSE)))
  )
}
