#!/bin/bash

server_count=`cat server_list| wc -l`

echo -e " \n<!DOCTYPE html> \n<html>\n<head>\n<title>Example</title>\n\n<!-- CSS -->\n<style> \nh1 \n{ \ntext-align: center;\n}\n.myTable {\n  width: 80%;\n  text-align: left;\n  background-color: lemonchiffon;\n  }\n.myTable th {\n  background-color: goldenrod;\n  width: 10px;\n  color: white;\n  }\n.myTable td,\n.myTable th {\n  padding: 10px;\n  width: 400px;\n  border: 1px solid goldenrod;\n  }\n</style>\n\n</head>\n<body>\n\n<!-- HTML -->\n<table class="myTable">\n      <col style="width:10%">\n      <col style="width:40%">\n      <col style="width:40%">\n<h1>Linux Server Patching Details</h1> <p>On below we can see server name and last patched date.</p><p>\n Total non-patched servers = $server_count</p>\n\n      <tr>\n              <th>S.No</th>\n              <th>Server Name</th> \n       <th>Last Patch date</th>\n</tr> " > /var/www/html/index.html

for i in `cat server_list`
do
   s_no=$(echo $i | cut -d ":" -f 1)
   server_name=$(echo $i | cut -d ":" -f 2)
   patch_date=$(echo $i | cut -d ":" -f 3)

echo -e "\n<tr> \n<td>$s_no</td> \n<td>$server_name</td>       \n<td>$patch_date</td> \n</tr> " >> /var/www/html/index.html

done

echo -e "\n</table> \n</body> \n</html>" >>/var/www/html/index.html
