# Retinopathy Risk

**Retinopathy** is characterised by a damaged retina, which is the back of the eyes and the surface that senses light. Retinopathy is normally caused by an abnormal blood flow to the retina, which can appear due to several diseases and can lead to partial or complete loss of vision. 
**Diabetic Retinopathy** is the ocular manifestation of diabetes and is the most common cause of retinopathy. In those cases, the persistent high blood sugar levels in diabetic patients cause damage in the retina's blood vessels. 

This RShiny mini-app provides a reinopathy image viewer and a calculated risk score for each patient, as well as, the clinical history of the patient.

## About the mini-app

This app is formed by three distinguished boxes:
                       
- The first box contains the information of the current patient. Here you can see the name, date of birth (DOB), gender and address of the patient, amongst others.
- The second box prints the image of the patient's retina and the risk score. The Risk score is divided into five categories: None, Mild. Moderate, Severe and Proliferative.
- The next box displays the clinical history of the patient. You can sort the table clicking on the different column names. Just below the table, there is the button to jump to the next patient.

## Checkout and run

You can clone this repository by using the command:

```
git clone https://github.com/aridhia/demo-retinopathy-risk-profile
```

Open the .Rproj file in RStudio and use `runApp()` to start the app.

## Deploying to the workspace

1. Create a new mini-app in the workspace called "retinopathy-risk" and delete the folder created for it
2. Download this GitHub repo as a .ZIP file, or zip all the files
3. Upload the .ZIP file to the workspace and upzip it inside a folder called "retinopathy-risk"
4. Run the app in your workspace




