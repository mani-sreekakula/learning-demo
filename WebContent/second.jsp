<html>
<head>
<title>Second JSP page</title>
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
var details2 = [{"name":"user5","subjects":[{"name":"Maths","score":1},{"name":"Physics","score":2},{"name":"Chemistry","score":3}]},
	{"name":"user6","subjects":[{"name":"Maths","score":4},{"name":"Physics","score":5},{"name":"Chemistry","score":6}]},
	{"name":"user7","subjects":[{"name":"Maths","score":7},{"name":"Physics","score":8},{"name":"Chemistry","score":9}]}];
var total2 = [];
function loadData(){
	// hardcoded data to show detailed results
	var details2Table = document.getElementById("details2");
	// Extract Subject names from details1 JSON
	var headers = ["Student Name"];
    for (var i = 0; i < details2.length; i++) {
    	var subjects = details2[i]["subjects"];
        for (var j = 0; j < subjects.length; j++) {
            if (headers.indexOf(subjects[j]["name"]) === -1) {
            	headers.push(subjects[j]["name"]);
            }
        }
    }
 	// CREATE HTML TABLE HEADER ROW USING THE EXTRACTED HEADERS ABOVE.

    var tr = details2Table.insertRow(-1);                   // TABLE ROW.

    var pass = 0;
    var fail = 0;
    for (var i = 0; i < headers.length; i++) {
        var th = document.createElement("th");      // TABLE HEADER.
        th.innerHTML = headers[i];
        tr.appendChild(th);
    }
 	// ADD JSON DATA TO THE TABLE AS ROWS.
    for (var i = 0; i < details2.length; i++) {

        tr = details2Table.insertRow(-1);
        var tabCell = tr.insertCell(-1);
        tabCell.innerHTML = details2[i]["name"];

        for (var j = 1; j < headers.length; j++) {
            var tabCell = tr.insertCell(-1);
            var score = details2[i]["subjects"][j-1]["score"];
            tabCell.innerHTML = score;
            if(score > 70){
            	pass+=score;
            }else{
            	fail+=score;
            }
        }
    }
 	var totalScore = pass+fail;
 	var totalObj = {"name":"Total","score":totalScore};
 	var passObj = {"name":"Pass","score":pass};
 	var failObj = {"name":"Fail","score":fail};
 	total2.push(totalObj);
 	total2.push(passObj);
 	total2.push(failObj);
 	
 	var summary2Table = document.getElementById("summary2");
 	// ADD JSON DATA TO THE TABLE AS ROWS.
    for (var i = 0; i < total2.length; i++) {

        tr = summary2Table.insertRow(-1);
        var tabCell = tr.insertCell(-1);
        tabCell.innerHTML = total2[i]["name"];
        tabCell = tr.insertCell(-1);
        tabCell.innerHTML = total2[i]["score"];
    }
 	
}

function sendAjaxRequest(name, data, callBack, type) {
	var url = getContextPath() + "/" + name + "?s=s";
	console.log(url);
	console.log(type);
	console.log(data);

	$.ajax({
		url : url,
		type : type,
		data : data,
		success : callBack,
		error : function(request, error, errorName) {
			console.log("inside error function");
			console.log(request, error);
			callBack(null);
		}
	});
}
function sendGetAjaxRequest(name, data, callBack) {
	sendAjaxRequest(name, data, callBack, 'GET');
}

function getContextPath() {
	return window.location.pathname.substring(0, window.location.pathname
			.indexOf("/", 2));
}

function onFinish() {
	data = {"details2":JSON.stringify(details2),"total2":JSON.stringify(total2)};
		sendGetAjaxRequest('secondAction',data,onsuccess);
	}
	
function onsuccess(url){
	window.location = url;
}
</script>
</head>
<body align="center" onload="loadData()">
	<p>Tech Informatic</p>
	<table align="center" id="summary2">
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
	<table align="center" id="details2"></table>
	<br>
	<input type="button" class="button" onclick="onFinish()" value="Finish"></input>
</body>
</html>