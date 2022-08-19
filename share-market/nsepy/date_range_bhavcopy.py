from random import randint
from datetime import date
from jugaad_data.nse import bhavcopy_save
import time
import pandas as pd
from jugaad_data.holidays import holidays

date_range = pd.bdate_range(start='12/01/2020', end = '12/31/2020', 
                         freq='C', holidays = holidays(2020,12))

#bdate = business days (weekends excluded by default)
# start and end dates in "MM-DD-YYYY" format
# holidays() function in (year,month) format
#freq = 'C' is for custom

print(date_range)

for dates in date_range:
     try:
          bhavcopy_save(dates, "tmp")
          time.sleep(randint(1,4)) #adding random delay of 1-4 seconds
     except (ConnectionError, ReadTimeoutError) as e:
          time.sleep(10) #stop program for 10 seconds and try again.
          try:
               bhavcopy_save(dates, "tmp")
               time.sleep(randint(1,4))
          except (ConnectionError, ReadTimeoutError) as e:
               print(f'{dates}: File not Found')
