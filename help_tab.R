documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(width = 12,
                     fluidRow(column(
                       6,
                       h2("Retinopathy Risk"), 
                       p("Very briefly, retinopathy is defined as any dmage to the back of the eyes of the eyes (retina), which can cause impared vision.
                       High blood sugar levels in diabetic patients can lead damage in the retina, this is a diabetic retinopathy and may lead to blindness if untreated."),
                       p("This RShiny mini-app provides a reinopathy image viewer and a calculated risk score for each patient, as well as, the clinical history of the patient."),
                       
                       h3("How to use the app"),
                       p("This app is formed by three distinguished boxes:"),
                       tags$ol(
                         tags$li("The first box contains the information of the current patient. Here you can see the name, date of birth (DOB), 
                                          gender and address of the patient, amongst others"),
                         tags$li("The second box prints the image of the patient's retina and the risk score. The Risk score is divided into five categories: None, Mild. Moderate, 
                                          Severe and Proliferative"),
                         tags$li("The next box displays the clinical history of the patient. You can sort the table clicking on the different column names. Just below the table, there is
                                 the button to jump to the next patient.")
                       ),
                      ),
                     column(
                       6,
                       h2("Walkthrough video"),
                       tags$video(src="retinopathy-risk.mp4", type = "video/mp4", width="100%", height = "350", frameborder = "0", controls = NA),
                       p(class = "nb", "NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised at user's 
                       risk. If you plan to use this mini-app to inform your study, please review the code and ensure you are 
                       comfortable with the calculations made before proceeding. ")
                       
                     )
                     
           ))

           )}