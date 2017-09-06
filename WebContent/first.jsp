<html>
<head>
<title>First JSP page</title>
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
var details1 = [{"name":"user1","subjects":[{"name":"Maths","score":10},{"name":"Physics","score":20},{"name":"Chemistry","score":30}]},
	{"name":"user2","subjects":[{"name":"Maths","score":40},{"name":"Physics","score":50},{"name":"Chemistry","score":60}]},
	{"name":"user3","subjects":[{"name":"Maths","score":70},{"name":"Physics","score":80},{"name":"Chemistry","score":90}]}];
var total1 = [];
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

    var pass = 0;
    var fail = 0;
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
            var score = details1[i]["subjects"][j-1]["score"];
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
 	total1.push(totalObj);
 	total1.push(passObj);
 	total1.push(failObj);
 	
 	var summary1Table = document.getElementById("summary1");
 	// ADD JSON DATA TO THE TABLE AS ROWS.
    for (var i = 0; i < total1.length; i++) {

        tr = summary1Table.insertRow(-1);
        var tabCell = tr.insertCell(-1);
        tabCell.innerHTML = total1[i]["name"];
        tabCell = tr.insertCell(-1);
        tabCell.innerHTML = total1[i]["score"];
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

function onNext() {
	data = {"details1":JSON.stringify(details1),"total1":JSON.stringify(total1)};
	sendGetAjaxRequest('firstAction',data,onsuccess);
	}
	
function onsuccess(url){
	window.location = url;
// 	alert("yes its true");
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
	<input type="button" class="button" onclick="onNext()" value="Next>>"></input>
</body>
</html>