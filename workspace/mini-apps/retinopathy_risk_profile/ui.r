# Read in dataset 
dataset <- xap.read_table("retinopathy_sample_data")

# Create body of mini-app
body <- dashboardBody(
  br(),
  
  # Patient banner
  fluidRow(
    box(width = 12,
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
        paste0("Image captured: 22-Sep-2015")
      ),
        
      # Right image  
      box(
        width = 3,
        uiOutput("logo_r"),
        br(),
        "Right Eye",
        br(),
        paste0("Image captured: 22-Sep-2015")
      ),
        
      # Retinopathy Score and Descriptive text  
      box(
        uiOutput("choose_symbol"),
        paste0("Risk scoring 22-Sep-2015"),
        br(),
        br(),
        HTML("<p>Diabetic retinopathy is a common complication of diabetes. It occurs when high blood sugar levels damage the cells at the back of the eye (known as the retina). If it isn't treated, it can cause blindness.</p>
             <p>It's important for people with diabetes to control their blood sugar levels. Everyone with diabetes who is 12 years old or over should have their eyes examined once a year for signs of damage.</p>
             <p>All people with diabetes are at risk of getting diabetic retinopathy, but good control of blood sugar levels, cholesterol and blood pressure minimises this risk.</p>"),
        br(),
        HTML("<a href=\"http://www.nhs.uk/conditions/diabetic-retinopathy/Pages/Introduction.aspx\" target='_blank' class=\"btn btn-info btn-md\" role=\"button\"><i class=\"fa fa-question\"></i> Find out more</a>"),
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
  
  # CSS styling   
  tags$head(tags$style(HTML('
    .alignleft {
	    float: left;
    }

    .alignright {
	    text-align: right;
	    margin-bottom: 0px;
    }

    .box.box-solid.box-primary>.box-header {
	    background: #F05927;
    }

    .box.box-solid.box-primary {
	    border: 1px solid #F8ab93;
    }

    .box.box-primary {
        border: 3px solid #F05927;
    }

    .col-sm-3 > .box {
      border: 3px solid #F05927;  
    }

    .col-sm-6 > .box {
      border-top: none;
      box-shadow: none;
    }

    .skin-blue .main-header .logo {
        background-color: #3c8dbc;
    }

    .skin-blue .main-header .logo:hover {
        background-color: #3c8dbc;
    }

    .content-wrapper,
    .right-side {
        background-color: #0C4159;
    }

    .btn-info, .btn-default {
      /*  width:150px;
        font-size:1.2em; */
		color: #fff;
        background-color: #6A3163;
        border-color: #6A3163;
    }

    /*
    .btn-default {
		    width:195px;
        font-size:1.5em;
	  } 
    */	

    .btn-info:hover,
    .btn-info:focus,
    .btn-info.focus,
	  .btn-default:hover,
	  .btn-default.hover,
    .btn-default:focus, 
    .btn-default.focus,
    .open>.dropdown-toggle.btn-info,
	  .open>.dropdown-toggle.btn-default {
        color: #fff;
        background-color: #F05927 !important;
        border-color: #F05927;
    }

    .h3 {
        text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
    }

	  .strokeme {
        text-shadow:
        -1px -1px 0 #000,
        1px -1px 0 #000,
        -1px 1px 0 #000,
        1px 1px 0 #000;
        letter-spacing: 2px;
    }
  ')))
)

# Disable header and sidebar, and add body of app
dashboardPage(
  dashboardHeader(disable = TRUE),
  dashboardSidebar(disable = TRUE),
  body
)
