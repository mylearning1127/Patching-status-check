#!/bin/bash

cd tmp
rm -rf *

URL=https://www.marketwatch.com/tools/markets/stocks/country/india/
for ((i = 1 ; i <= 26 ; i++)); do

wget ${URL}$i
cat $i | grep /investing/Stock/ > company_name
cat $i | grep /investing/Stock/ | awk '{print $1,$2,$3}' | sed "s,[^0-9.]*,,g" >> copmany_code
sed -i -e 's/<td.*">//' -e 's/<s.*d>//' company_name
cat company_name | awk '{print $1,$2,$3,$4}' >> company_list
paste -d "|" copmany_code company_list >> company_name_code
rm -v $i
done
        

