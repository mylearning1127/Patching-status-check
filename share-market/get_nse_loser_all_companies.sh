#!/bin/bash

rm -rf tmp/*
wget -o - https://www.moneycontrol.com/stocks/marketstats/nse-loser/all-companies_-2/more/
mv index.html tmp
if [ -f index.html ]; then
		echo "index.html available"
	else
		echo "index.html not avilable"
fi
count=`cat tmp/index.html | grep td | grep /www.moneycontrol.com | wc -l`
echo "count $count"

cat tmp/index.html | grep td | grep /www.moneycontrol.com  > tmp/weblinks

sed -i '1d' tmp/weblinks
sed -i '/^$/d' tmp/weblinks

cat tmp/weblinks |  awk '{print $6}' | cut -c 7-100> tmp/url
sed -i s/.$// tmp/url
count=`cat url | wc -l`

cd tmp

for i in `cat url`; do
# sed -n '/<tbody/,/<\/tbody>/p' SL19\'

wget $i
url="$i"
file_name=`ls -lt | grep -v total | sed -n "1 p" |awk '{print $9}'`
company=`cat $file_name | grep "var nseId" | awk '{print $4}' | tr -d '"' | tr -d ';'`
company_name="$company"
open_amt=`cat $file_name | grep nseopn  | sed "s,[^0-9.]*,,g"`
Previous_Close=`cat $file_name | grep "Previous Close"  | sed "s,[^0-9.]*,,g"`
UC_Limit=`cat $file_name | grep "UC Limit" | sed "s,[^0-9.]*,,g"`
LC_Limit=`cat $file_name | grep "LC Limit" | sed "s,[^0-9.]*,,g"`

echo "open_amt $open_amt" >> ${company_name}_value
echo "Previous_Close $Previous_Close" >>${company_name}_value
echo "UC_Limit $UC_Limit" >> ${company_name}_value
echo "LC_Limit $LC_Limit" >> ${company_name}_value
mysql -u root -pLalgudi@567  << EOF
use share_market;
INSERT INTO sharedetails (company_name,Open_Amt,Previuos_close,UC_Limit,LC_Limit,url) VALUES('$company_name', '$open_amt', '$Previous_Close', '$UC_Limit', '$LC_Limit', '$url');
EOF

done

