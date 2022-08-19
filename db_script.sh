#!/bin/bash

hostname = {hostname}
#PGPASSWORD= psql -h $hostname puppetdb  puppetdb  << EOF
#\o //opt/patchreport
#select hostname,patchsuccessful,patchfailed,bapscheduledtime,kernelrelease,targetkernel,acversion,environment from patchreportview;
#\o
#EOF

#sed -i '1,2d' /opt/patchreport
server_count=`cat /opt/patchreport | wc -l`
loop_count=`cat /opt/patchreport | wc -l`

echo -e "\n<!DOCTYPE html>\n<html>\n<head>\n<title>Patch Report</title>\n\n<link rel=\"stylesheet\" type=\"text/css\" href=\"mystyle.css\">\n<style>\nh1\n{\ntext-align: center;\n}\n\nbody {\nbackground-color: lemonchiffon;\n}\n</style>\n</head>\n<body>\n<div class=\"myTable\">\n<table class=customers-list>\n<colgroup>\n<col span=\"1\" style=\"width: 3%;\">\n<col span=\"1\" style=\"width: 3%;\">\n<col span=\"1\" style=\"width: 10%;\">\n<col span=\"1\" style=\"width: 15%;\">\n<col span=\"1\" style=\"width: 30%;\">\n<col span=\"1\" style=\"width: 15%;\">\n<col span=\"1\" style=\"width: 15%;\">\n<col span=\"1\" style=\"width: 15%;\">\n<col span=\"1\" style=\"width: 10%;\">\n</colgroup>\n<h1>Linux Server Patching Details</h1>\n<div class=\"center\"><button id=\"myBtn\"><img src=\"img_snow.jpg\" width=\"30\" height=\"30\" style=\"float: left;\"/></button></div>\n<div id=\"myModal\" class=\"modal\">\n<div class=\"modal-content\">\n<span class=\"close\">&times;</span>\n<p><b><h3 style="text-align:center">This Website helps us to Get the patching details of all Linux servers in Nets Environment.</h3></b><br>&nbsp;&nbsp;1. <b>Env</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;=> &emsp;Shows the environment of server belongs to.&nbsp; Ex: ST, TT, PP, KT, P <br><br>&nbsp;&nbsp;2. <b>Hostname</b> &nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&emsp;&emsp;&emsp;&emsp;=> &emsp; Name of the server<br><br>&nbsp;&nbsp;3. <b>Patch Successful</b>&emsp;&nbsp;&emsp;&emsp;=> &emsp; Shows the patch successful date, If the Column is empty that means server patch is not successful in last 30 days <br><br>&nbsp;&nbsp;4. <b>Patch Failed</b> &nbsp;&nbsp;&nbsp;&emsp;&emsp;&emsp;&emsp; =>&emsp; If "Patch Successful" column is empty then "Patch Failed" should have value, specifically it shows most recent patch got failed date.<br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; Below you can see most possible ways logs messages avialable and it's description<br><br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <b>No Logs Found</b>&emsp;=> &nbsp;There is no BAP Logs, RoadRunner didn't make a single attempt to patch the server.<br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; Server maybe recently deployed<br><br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<b>Server not pached last 30 days, maybe server not patched very longtime</b> &emsp;=> &nbsp;we don't have patch successful log in last days, at <br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;the same time we don't have patch failed Logs also. When server not got patched very long time, will shows this log. <br><br> &nbsp;5. <b>Patch Schedule Time</b>&emsp;&nbsp;&nbsp; =>&emsp;Shows patch  schduled pattern/Date on RoadRunner.&emsp;&nbsp;&nbsp;<br><br>&nbsp;&nbsp;6. <b>Kernel Version</b>&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp; =>&emsp;Current Kernel version shows here.&emsp; <br><br>&nbsp;&nbsp;7. <b>Target Kernel</b> &emsp;&emsp;&emsp;&emsp; => &emsp;In Nets, Kernal patch happened based on this value. If Traget version is next on next patch cycle kernal patch got applied. &emsp;<br><br>&nbsp;&nbsp;8. <b>ACVersion</b>&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp; =>&emsp; Installed AccessControl version available Here.&emsp;</p>\n</div>\n</div>\n<h4><div class=\"title\">\n<label class=\"search\"></label>\n<input type=\"search\" placeholder=\"Search...\" class=\"form-control search-input\" data-table=\"customers-list\" align=\"right\"/>\n</div> </h4><br><br>\n<div class=\"scroll-left\">\n<p>NOTE: If patch_successful column is empty that means server not patched in last 30 days . . . &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; To get more details about columns Description and Log Description click on HELP button . . . </p>\n</div>\n<tr>\n<th>S.No</th>\n<th>Env</th>\n<th>Hostname</th>\n<th>Patch Successful</th>\n<th>Patch Failed</th>\n<th>Patch Schedule Time</th>\n<th>Kernel Version</th>\n<th>Target Kernel</th>\n<th>ACVersion</th>\n</tr>" > /opt/index.html

for ((i = 1; i <= $loop_count; i++));
do
SNo=$i
environment=`cat /opt/patchreport | cut -d "|" -f 8 | sed -n "$i p"`
Hostname=`cat //opt/patchreport | cut -d "|" -f 1 | sed -n "$i p"`
patch_successful=`cat /opt/patchreport | cut -d "|" -f 2 | sed -n "$i p"`
patch_failed=`cat /opt/patchreport | cut -d "|" -f 3 | sed -n "$i p"`
bapscheduledtime=`cat /opt/patchreport | cut -d "|" -f 4 | sed -n "$i p"`
kernelrelease=`cat /opt/patchreport | cut -d "|" -f 5 | sed -n "$i p"`
targetkernel=`cat /opt/patchreport | cut -d "|" -f 6 | sed -n "$i p"`
acversion=`cat /opt/patchreport | cut -d "|" -f 7 | sed -n "$i p"`

echo -e "\n<tr>\n<td>$SNo</td>\n<td>$environment</td>\n<td>$Hostname</td>\n<td>$patch_successful</td>\n<td>$patch_failed</td>\n<td>$bapscheduledtime</td>\n<td>$kernelrelease</td>\n<td>$targetkernel</td>\n<td>$acversion</td>\n</tr> " >> /opt/index.html

done

echo -e "\n</table>\n</div>\n<script>\n(function(document) {\n'use strict';\nvar TableFilter = (function(myArray) {\nvar search_input; \nfunction _onInputSearch(e) {\nsearch_input = e.target;\nvar tables = document.getElementsByClassName(search_input.getAttribute('data-table'));\nmyArray.forEach.call(tables, function(table) {\nmyArray.forEach.call(table.tBodies, function(tbody) {\nmyArray.forEach.call(tbody.rows, function(row) {\nvar text_content = row.textContent.toLowerCase();\nvar search_val = search_input.value.toLowerCase();\nrow.style.display = text_content.indexOf(search_val) > -1 ? '' : 'none';\n});\n});\n});\n}\nreturn {\ninit: function() {\nvar inputs = document.getElementsByClassName('search-input');\nmyArray.forEach.call(inputs, function(input) {\ninput.oninput = _onInputSearch;\n});\n}\n};\n})(Array.prototype);\ndocument.addEventListener('readystatechange', function() {\nif (document.readyState === 'complete') {\nTableFilter.init();\n}\n});\n})(document);\n</script>\n<script>\nvar modal = document.getElementById(\"myModal\");\nvar btn = document.getElementById(\"myBtn\");\nvar span = document.getElementsByClassName(\"close\")[0];\nbtn.onclick = function() {\nmodal.style.display = \"block\";\n}\nspan.onclick = function() {\nmodal.style.display = \"none\";\n}\nwindow.onclick = function(event) {\nif (event.target == modal) {\nmodal.style.display = \"none\";\n}\n}\n</script>\n</body>\n</html>" >> /opt/index.html



