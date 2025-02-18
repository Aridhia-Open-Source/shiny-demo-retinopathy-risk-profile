################
###### UI ######
################


# Create body of mini-app
body <- dashboardBody(
  includeCSS("www/style.css"),
  br(),
  
  # Patient banner
  fluidRow(
    box(width = 12,
        title = "Patient Information",
        status = "primary",
        solidHeader = TRUE,
      uiOutput("patient_banner")
    )
  ),
  
  # "Risk Assessment - Diabetic Retinopathy" box
  fluidRow(
    box(width = 12,
      title = "Risk Assessment - Diabetic Retinopathy",
      status = "primary",
      solidHeader = TRUE,
        
      # Left image  
      box(
        width = 3,
        uiOutput("logo_l"),
        br(),
        "Left Eye",
        br(),
        "Image captured: 22-Sep-2015"
      ),
        
      # Right image  
      box(
        width = 3,
        uiOutput("logo_r"),
        br(),
        "Right Eye",
        br(),
        "Image captured: 22-Sep-2015"
      ),
        
      # Retinopathy Score and Descriptive text  
      box(
        uiOutput("choose_symbol"),
        "Risk scoring 22-Sep-2015",
        br(),
        br(),
        p("Diabetic retinopathy is a common complication of diabetes. It occurs when high blood sugar 
          levels damage the cells at the back of the eye (known as the retina). If it isn't treated, it can cause blindness."),
        p("It's important for people with diabetes to control their blood sugar levels. Everyone with diabetes who is 12 years 
          old or over should have their eyes examined once a year for signs of damage."),
        p("All people with diabetes are at risk of getting diabetic retinopathy, but good control of blood sugar levels,
          cholesterol and blood pressure minimises this risk."),
        br(),
        HTML("<a href=\"http://www.nhs.uk/conditions/diabetic-retinopathy\" target='_blank' class=\"btn btn-info btn-md\" role=\"button\"><i class=\"fa fa-question\"></i> Find out more</a>"),
        width = 6
      )
    )
  ),
  
  # Clinical History table
  fluidRow(
    box(
      title = "Clinical History - EHR",
      width = 12,
      solidHeader = TRUE, 
      status = "primary",
      dataTableOutput("clin_history"),
      br(),
      tags$p(actionButton("increment", "Next Patient", icon = icon("arrow-right"))),
      tags$style(type = "text/css", "#increment { width: 10%; float:right;}")
    )
  ),
  # Help 
  fluidRow(
    box(
      title = "Help",
      width = 12,
      solidHeader = TRUE,
      status = "primary",
      collapsible = TRUE,
      collapsed = TRUE,
      documentation_tab()
    )
  )
)

# Disable header and sidebar, and add body of app
dashboardPage(
  dashboardHeader(disable = TRUE),
  dashboardSidebar(disable = TRUE),
  body
)
