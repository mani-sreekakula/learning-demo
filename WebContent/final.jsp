<html>
<head>
<title>Third JSP page</title>
<script type="text/javascript" src="js/jquery-2.1.1.js"></script>
<style type="text/css">
	table, th, td {
		border: solid 1px #333;
		padding: 2px 4px;
		font: 15px Verdana;
	}
	
	th {
		font-weight: bold;
	}
	
	.button {
    background-color: #008CBA; /* Blue */
    border: none;
    color: white;
    padding: 10px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin-right: -250px;
    border-radius: 13px;
    cursor: pointer;
}
</style>
<script type="text/javascript">
var details1 = <%= session.getAttribute("details1") %>;
var details2 = <%= session.getAttribute("details2") %>;
var total1 = <%= session.getAttribute("total1") %>;
var total2 = <%= session.getAttribute("total2") %>;
details1 = details1.concat(details2);
function loadData(){
	// hardcoded data to show detailed results
	var details1Table = document.getElementById("details1");
	// Extract Subject names from details1 JSON
	var headers = ["Student Name"];
	for (var i = 0; i < details1.length; i++) {
    	var subjects = details1[i]["subjects"];
        for (var j = 0; j < subjects.length; j++) {
            if (headers.indexOf(subjects[j]["name"]) === -1) {
            	headers.push(subjects[j]["name"]);
            }
        }
    }
 	// CREATE HTML TABLE HEADER ROW USING THE EXTRACTED HEADERS ABOVE.

    var tr = details1Table.insertRow(-1);                   // TABLE ROW.

    for (var i = 0; i < headers.length; i++) {
        var th = document.createElement("th");      // TABLE HEADER.
        th.innerHTML = headers[i];
        tr.appendChild(th);
    }
 	// ADD JSON DATA TO THE TABLE AS ROWS.
    for (var i = 0; i < details1.length; i++) {

        tr = details1Table.insertRow(-1);
        var tabCell = tr.insertCell(-1);
        tabCell.innerHTML = details1[i]["name"];

        for (var j = 1; j < headers.length; j++) {
            var tabCell = tr.insertCell(-1);
            tabCell.innerHTML = details1[i]["subjects"][j-1]["score"];
        }
    }
 	
    var summary1Table = document.getElementById("summary1");
 	// ADD JSON DATA TO THE TABLE AS ROWS.
    for (var i = 0; i < total1.length; i++) {

        tr = summary1Table.insertRow(-1);
        var tabCell = tr.insertCell(-1);
        tabCell.innerHTML = total1[i]["name"];
        tabCell = tr.insertCell(-1);
        tabCell.innerHTML = total1[i]["score"]+total2[i]["score"];
    }
 	
}
</script>
</head>
<body align="center" onload="loadData()">
	<p>Tech Informatic</p>
	<table align="center" id="summary1">
		<thead>
			<tr>
				<th>Type</th>
				<th>Marks</th>
			</tr>
		</thead>
	</table>
	<br>
	<p>The Detailed Results are displayed below:</p>
	<br>
	<table align="center" id="details1"></table>
	<br>
</body>
</html>