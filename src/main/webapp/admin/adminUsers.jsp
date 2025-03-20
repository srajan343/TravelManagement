<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Admin Users </title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
.main-content {
    color: #fff;
    
    
}
.containerDiv{
	width:98%;
	display:flex;
    flex-direction:column;
    
    height:94vh;

}

.requestDiv {
    background-color: rgba(255, 255, 255, 0.2); /* Semi-transparent background */
    top:100px;
    height: 80vh; /* Table height limited to allow scrolling */
    border-radius: 15px;
    position: relative; /* Ensures child sticky elements behave correctly */
    /*padding: 0px 15px;*/
    overflow-y: auto; /* Enables vertical scrolling for the table data */
    overflow-x: hidden; /* Avoid horizontal overflow */
}

.requestDiv table {
    margin-bottom: 0; /* Prevent table bottom margin from breaking the layout */
    border-collapse: collapse; /* Consistent table layout */
}

thead th {
	
    position: sticky; /* Keep header row fixed while scrolling */
    top: 0; /* Sticks the header at the top */
    z-index: 10; /* Ensures header is rendered above the body */
   /* background-color: #f8f9fa; /* Opaque light background for header */
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1); /* Add shadow for separation */
    border-bottom: 2px solid #dee2e6; /* Define a solid border to emphasize the header */
    padding: 10px  ; /* Consistent padding */
    text-align: center; /* Align text properly */
    //border-radius:5px;
}

tbody tr td {
    /*background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent row background */
    padding: 10px; /* Consistent padding */
    text-align:center;
    
}

.table-class{
text-align:center;
}

.table-striped-row {
        background-color: #f8f9fa; /* Light gray for striping */
    }
    .subtable-wrapper {
        padding: 20px;
}
</style>
</head>
<body>

<%@include file="../common/side_nav.jsp" %>

	<div class="main-content">
		<div class="containerDiv">
			
			
			<div class="d-flex justify-content-end mb-3" style="width: 100%;margin-bottom:0px !important; position:relative;top:70px"> <!-- Flexbox for right alignment -->
				<button  id="addUser" class="btn btn-primary" style="margin-right:10px"> <i class="fa-solid fa-user-plus"></i>&nbsp;Add User</button>
		        <div class="input-group" style="width: 350px;"> <!-- Adjusting width to accommodate dropdown -->
		            
		           
		
		            <!-- Input field -->
		            <input id="myInput" type="text" class="form-control" placeholder="Search..." aria-label="Search" aria-describedby="search-addon">
					 <!-- Dropdown for accept/reject options with 'All' as the default -->
		            <select class="form-select" id="myDropdown" style="width: 50px;">
		                <option value="all" selected>All</option> <!-- Default value set to 'All' -->
		                <option value="active">Active</option>
		                <option value="inactive">Inactive</option>
		            </select>
		            <!-- Search icon -->
		            <span class="input-group-text" id="search-addon"><i class="fas fa-search"></i></span>
        </div>
    </div>
		<div class="requestDiv">
			
			
            <table class="table table-striped table-light table-borderless col-12">
                <thead class="table-light head-table col-12">
                    <tr>
                        <th class="col-1">Emp ID</th>
                        <th class="col-2">Name</th>
                        <th class="col-2">Manager Id</th>
                        <th class="col-2">Manager</th>
                        <th class="col-2">Email Id</th>
                        <th class="col-1">Location</th>
                        <th class="col-1">State</th>
                        <th class="col-1">Edit Users</th>
                        
                       	
                    </tr>
                </thead>
                <tbody class="table-class">
                    <!-- Rows will be dynamically populated by JavaScript -->
                </tbody>
            </table>  
            <div id="noDataMessage" style="display: none; text-align: center; margin-top: 20px;">
            No matching data found.
        </div>    
        </div>
         
	</div>
	</div>


<script>
$(document).ready(function(){
	loadRequests();
	
	
	//$("#addUser").on("click",function(){
		
	
		//})
	
	
	
	
	$("#search-addon").on("click", function () {
	    var searchValue = $("#myInput").val().toLowerCase(); // Get the search text
	    var dropdownValue = $("#myDropdown").val(); // Get the dropdown value (All, Active, Inactive)
	    console.log("dropdownvalue", dropdownValue);

	    console.log("clicked");
	    console.log("searchValue:", searchValue);
	    console.log("dropdownValue:", dropdownValue);

	    // Filter only the odd rows (main rows)
	    var rows = $(".table-class .main-row");
	    var hasVisibleRow = false;

	    rows.each(function () {
	        var rowText = $(this).text().toLowerCase();
	        var matchesSearch = searchValue === "" || rowText.indexOf(searchValue) > -1;

	        // Check dropdown filter
	        var matchesDropdown = false;
	        if (dropdownValue === "all") {
	            matchesDropdown = true;
	        } else {
	            var stateCell = $(this).find("td:nth-child(7)").text().trim().toLowerCase();
	            //console.log("statecell",stateCell);// Get the state column text
	            if ((dropdownValue === "active" && stateCell === "active") ||
	                (dropdownValue === "inactive" && stateCell === "inactive")) {
	                matchesDropdown = true;
	            }
	        }

	        var shouldDisplay = matchesSearch && matchesDropdown;

	        if (shouldDisplay) {
	            $(this).show(); // Show the main row
	            hasVisibleRow = true; // Mark as having at least one visible row
	        } else {
	            $(this).hide(); // Hide the main row
	        }
	    });

	    // Show or hide the "No Matching Data" message
	    if (hasVisibleRow) {
	        $("#noDataMessage").hide();
	    } else {
	        $("#noDataMessage").show();
	    }
	});


	
	 
     
     
	 
	 function loadRequests(){
		 //var users = await getUsers();
		 var empId = "<%= session.getAttribute("empId") %>";
		 //console.log("****Users",users);
		 $.ajax({
			 url:"ListUserServlet",
			 type:"GET",
			 dataType:"json",
			 success:function(response){
				 //var tableBody = $('.table-class');
				 console.log("response of userServlet",response);
				tableData(response);	 
			 },
			 
			 error: function (xhr, status, error) {
	                console.error(error);
	            }
			 
			 
		 })
		 
		 
		 
	 }
	 
	 function tableData(jsonData){
		 console.log("inside 2 tabledata",jsonData);
	        const mainTableBody = $(".table-class");
	        mainTableBody.empty(); // Clear existing table content
			console.log("data data",jsonData);
	        Object.keys(jsonData).forEach((key, index) => {
	            const item = jsonData[key];
	            console.log("key: ",key,"index: ",index);
	            console.log("*****************jsonData",item["empId"]);
	            const collapseId = "collapse-" + index;
				
				//var self = (item["manager_status"] ==="approved"&&item["self"] ==="no")
	            
		        //if( self &&((item["admin_status"]==="approved")||(item["admin_status"]==="rejected"))){ 
	          if (key !== "admin" && key !== "finance") {
	        	  // var totalAmount = 0;
		          //  var length1 = item.Destination.length;
		          //  for (let i = 0; i < length1; i++) {
		          //      totalAmount += parseFloat(item.amount[i] || 0); // Add the amount to totalAmount
		          //  }
	            // Main row with class "main-row"
	            var row = "<tr class='main-row'>";
	            //row += "  <td>";
	            //row += "<a href='#' style='text-decoration:none;color:#000;' class='toggle-collapse' data-toggle='collapse' data-target='#" + collapseId + "' role='button' aria-expanded='false' aria-controls='" + collapseId + "'>";
	            //row += "<i class='toggle-icon fas fa-chevron-down' id='icon-" + index + "'></i>&nbsp;&nbsp; " + key;
	            //row += "</a>";
	            //row += " </td>";
	            row += "  <td>" + key + "</td>";
	            row += "  <td>" + item["name"] + "</td>";
	            row += "  <td>" + item["manager_id"] + "</td>";
	            row += "  <td>" + item["manager_name"] + "</td>";
	            row += "  <td>" + item["email"] + "</td>";
	            row += "  <td>" + item["location"] + "</td>";
	            //row += "<td>"+totalAmount.toFixed(2) + "</td>";
	            
	           	var usrState = item["active"];
	           	var Active ;
	           	//var Inactive = "";
	           	if(usrState==="yes"){
	           		Active = " Active";
	           		color="green";
	           		
	           	}
	           	else{
	           		Active = " Inactive";
	           		color = "red";
	           		
	           	}
	           		
	           	row+="<td style='color:"+color+"'>"+ Active +"</td>";
	            row += " <td>";
	            row+= "<button class='btn btn-outline-primary edit-btn' data-key='"+key+"'  ><i class='fa-solid fa-pencil'></i>&nbsp;Edit</button>";
	            //if(item["admin_status"]==="approved"){
	            //	row += "   <button class='btn btn-success btn-sm Approve-btn' data-empid='"+ item["empId"] +"' data-key='"+ key+"'>Accepted</button>";	
	            //}
	            //else if(item["admin_status"]==="rejected"){
	            //	row += "   <button class='btn btn-danger btn-sm Reject-btn' data-empid='"+ item["empId"] +"' data-key='"+ key +"'>Rejected</button>";
	            //}
	            
	            
	            row += " </td>";
	            row += " </tr>";
	            
	            mainTableBody.append(row);
	        }// Append the row to the main table body
	        });

	        // Add striping manually
	        mainTableBody.find('.main-row:even').addClass('table-striped-row');
	        
	        
	    }
	        
	        $(".table-class").on("click",".edit-btn", function(){
	        	var key = $(this).data('key');
	        	console.log("key inside the click edit btn:::",key);
	        	window.location.href = "editUserServlet?editUserId="+key;
	        	
	        
	        	})
	        $("#addUser").on("click",function(){
	        
	        	console.log("add user btn clicked:::");
	        	window.location.href = "addUser.jsp";
	        })
	        
	 


});
</script>

</body>
</html>