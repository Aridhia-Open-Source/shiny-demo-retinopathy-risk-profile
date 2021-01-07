
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
  
  # Generate correct symbols & description to display for patients score
  output$choose_symbol <- renderUI({
    if (dataset$score[dataset$retinal_id == ids[values$i]][1] == 0){  
      HTML("<i class=\"fa fa-check-circle fa-5x\" style=\"color: green;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: yellow;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: orange;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: red;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: DarkRed;\"></i><br>
            <div class=\"strokeme\"><h2 style=\"color: green;\"><b>None</b></h2></div>")
     } else if (dataset$score[dataset$retinal_id == ids[values$i]][1] == 1){
      HTML("<i class=\"fa fa-circle-thin fa-5x\" style=\"color: green;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-check-circle fa-5x\" style=\"color: yellow;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: orange;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: red;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: DarkRed;\"></i><br>
            <div class=\"strokeme\"><h2 style=\"color: yellow;\"><b>Mild</b></h2></div>")
     } else if (dataset$score[dataset$retinal_id == ids[values$i]][1] == 2){ 
      HTML("<i class=\"fa fa-circle-thin fa-5x\" style=\"color: green;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: yellow;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-check-circle fa-5x\" style=\"color: orange;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: red;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: DarkRed;\"></i><br>
            <div class=\"strokeme\"><h2 style=\"color: orange;\"><b>Moderate</b></h2></div>")
     } else if (dataset$score[dataset$retinal_id == ids[values$i]][1] == 3){ 
      HTML("<i class=\"fa fa-circle-thin fa-5x\" style=\"color: green;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: yellow;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: orange;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-check-circle fa-5x\" style=\"color: red;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: DarkRed;\"></i><br>
            <div class=\"strokeme\"><h2 style=\"color: red;\"><b>Severe</b></h2></div>")
    } else if (dataset$score[dataset$retinal_id == ids[values$i]][1] == 4){
      HTML("<i class=\"fa fa-circle-thin fa-5x\" style=\"color: green;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: yellow;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: orange;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-circle-thin fa-5x\" style=\"color: red;\"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <i class=\"fa fa-check-circle fa-5x\" style=\"color: DarkRed;\"></i><br>
            <div class=\"strokeme\"><h2 style=\"color: DarkRed;\"><b>Proliferative</b></h2></div>")
    }
  })
  
  # Generate clinical history table for selected patient
  output$clin_history <- renderDataTable({
    dt <- dataset[dataset$retinal_id == ids[values$i], c("event_dt", "location", "clinician", "event_type", "description", "event_result", "event_measure_id")]
    names(dt) <- c("Date", "Location", "Clinician", "Event", "Description", "Result", "Code")
    dt %>% 
      filter(!is.na(Date)) %>%
      arrange(desc(Date)) %>%
      mutate(Result = round(Result, 1), Code = round(Code, 1))
  }, options = list(pageLength = 5, searching = FALSE, lengthChange = FALSE, 
                    columnDefs = list(list(targets = c(0:6), searchable = FALSE)))
  )
}
