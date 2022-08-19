#Making all necessary imports for the code
from datetime import date
from jugaad_data.nse import bhavcopy_save

#Saving the Bhavcopy file for 01-01-2021
bhavcopy_save(date(2021,6,11), "tmp")

#Tip: You can use "." instead of "path/to/folder"
#If you want to save your File where your code file is. 
#If unsure where your code file is, import os and run os.getcwd()
