<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Dashboard </title>

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
        <div class="input-group" style="width: 350px;"> <!-- Adjusting width to accommodate dropdown -->
            
           

            <!-- Input field -->
            <input id="myInput" type="text" class="form-control" placeholder="Search..." aria-label="Search" aria-describedby="search-addon">
			 <!-- Dropdown for accept/reject options with 'All' as the default -->
            <select class="form-select" id="myDropdown" style="width: 50px;">
                <option value="all" selected>All</option> <!-- Default value set to 'All' -->
                <option value="accepted">Accepted</option>
                <option value="rejected">Rejected</option>
            </select>
            <!-- Search icon -->
            <span class="input-group-text" id="search-addon"><i class="fas fa-search"></i></span>
        </div>
    </div>
		<div class="requestDiv">
			
			
            <table class="table table-striped table-light table-borderless col-12">
                <thead class="table-light head-table col-12">
                    <tr>
                        <th class="col-1">App No</th>
                        <th class="col-1">Manager Id</th>
                        <th class="col-2">Manager Name</th>
                        
                        <th class="col-1">Self</th>
                        <th class="col-1">Amount</th>
                        <th class="col-2">Applied On</th>
                        <th class="col-2">Manager Action</th>
                        <th class="col-1">Status</th>
                       	
                        
                    </tr>
                </thead>
                <tbody class="table-class">
                    <!-- Rows will be dynamically populated by JavaScript -->
                </tbody>
            </table>  
            <div id="noDataMessage" style="display: none; text-align: center; margin-top: 20px;">
            No matching data found.
        </div> 
         <div id="noDataMessage1" style="display: none; text-align: center; margin-top: 20px;">
           	 No Application Submitted.
        	</div>   
        </div>
         
	</div>
	</div>


<script>
$(document).ready(function(){
	
	$("#noDataMessage1").hide();
	
	var empId = "<%= session.getAttribute("empId") %>";
	 var contextPath = "<%= request.getContextPath() %>";
	 console.log("contextPath",contextPath);
	
	$("#search-addon").on("click", function () {
	    var searchValue = $("#myInput").val().toLowerCase(); // Get the search text
	    var dropdownValue = $("#myDropdown").val(); // Get the dropdown value (All, Accept, Reject)

	    console.log("clicked");
	    console.log("searchValue:", searchValue);
	    console.log("dropdownValue:", dropdownValue);

	    // Filter only the odd rows (main rows)
	    var rows = $(".table-class .main-row");
	    var hasVisibleRow = false;

	    rows.each(function () {
	        var rowText = $(this).text().toLowerCase();
	        var matchesSearch = searchValue === "" || rowText.indexOf(searchValue) > -1;
	
	        console.log("rowText",rowText);
	        // Check dropdown filter
	        var matchesDropdown =
	            dropdownValue === "all" ||
	            (dropdownValue === "accepted" && rowText.includes("accepted")) ||
	            (dropdownValue === "rejected" && rowText.includes("rejected"));

	        var shouldDisplay = matchesSearch && matchesDropdown;

	        if (shouldDisplay) {
	            $(this).show(); // Show the main row
	            $(this).next().show(); // Show the associated subtable row
	            hasVisibleRow = true; // Mark as having at least one visible row

	            
	        } else {
	            $(this).hide(); // Hide the main row
	            $(this).next().hide(); // Hide the associated subtable row
	            
	        }
	    });

	    // Show or hide the "No Matching Data" message
	    if (hasVisibleRow) {
	        $("#noDataMessage").hide();
	    } else {
	        $("#noDataMessage").show();
	    }
	});



	
	 loadRequests();
	 
	 $(document).on('shown.bs.collapse', function (e) {
         const collapseId = $(e.target).attr('id');
         const index = collapseId.split('-')[1];
         $('#icon-' + index).removeClass('fa-chevron-down').addClass('fa-chevron-up');
     });

     $(document).on('hidden.bs.collapse', function (e) {
         const collapseId = $(e.target).attr('id');
         const index = collapseId.split('-')[1];
         $('#icon-' + index).removeClass('fa-chevron-up').addClass('fa-chevron-down');
     });

     // Ensure clicking on the dropdown icon will toggle the collapse
     $(document).on('click', '.toggle-collapse', function (e) {
         e.preventDefault(); // Prevent the default link behavior
         const collapseId = $(this).data('target').substring(1); // Remove the '#' symbol
         $('#' + collapseId).collapse('toggle');
     });
     
     
	 
	 function loadRequests(){
		 //var users = await getUsers();
		 var empId = "<%= session.getAttribute("empId") %>";
		 //console.log("****Users",users);
		 $.ajax({
			 url:"ListAppRequestServlet",
			 type:"GET",
			 dataType:"json",
			 success:function(response){
				 //var tableBody = $('.table-class');
				tableData(response);	 
			 },
			 
			 error: function (xhr, status, error) {
	                console.error(error);
	            }
			 
			 
		 })
		 
		 
		 
	 }
	 
	 function tableData(jsonData){
	        const mainTableBody = $(".table-class");
	        mainTableBody.empty(); // Clear existing table content
			console.log("data data",jsonData);
	        
			 if (Object.keys(jsonData).length === 0 && jsonData.constructor === Object) {
		        	$("#noDataMessage1").show();
		        }else{
	        
			        Object.keys(jsonData).forEach((key, index) => {
			            const item = jsonData[key];
			            console.log("key: ",key,"index: ",index);
			            console.log("*****************jsonData",item["empId"]);
			            const collapseId = "collapse-" + index;
						
			            var count=0;
						var self = (item["manager_status"] ==="approved" && item["self"] ==="no")
			            
				         
				        	console.log("mepId",empId);
				        	console.log("key",key);
				        	
			           if(item["empId"]===empId){
			        	   count++;
			        	   var totalAmount = 0;
				            var length1 = item.amount.length;
				            for (let i = 0; i < length1; i++) {
				                totalAmount += parseFloat(item.amount[i] || 0); // Add the amount to totalAmount
				            }
			            // Main row with class "main-row"
			            var status = "";
			           
			            
			            if(item["self"]==="no"){
			            	status = "admin_status";
			            }else{
			            	status="finance_status";
			            }
			            
			            if (item[status] === "pending" ){
			            
			            var row = "<tr class='main-row'>";
			            row += "  <td>";
			            row += "<a href='#' style='text-decoration:none;color:#000;' class='toggle-collapse' data-toggle='collapse' data-target='#" + collapseId + "' role='button' aria-expanded='false' aria-controls='" + collapseId + "'>";
			            row += "<i class='toggle-icon fas fa-chevron-down' id='icon-" + index + "'></i>&nbsp;&nbsp; " + key;
			            row += "</a>";
			            row += " </td>";
			            row += "  <td>" + item["manager_id"] + "</td>";
			            row += "  <td>" + item["manager_name"] + "</td>";
			            
			            if(item["self"]==="no"){
				            row += "  <td> No </td>";            	
			            }
			            else if(item["self"]==="yes"){
				            row += "  <td> Yes </td>";            	
			            }
			            row += "<td>"+totalAmount.toFixed(2) + "</td>";
			            row+= "<td>"+item["applied_on"]+"</td>";
			            
			            if(item["manager_status"]==="pending") {
			            	row += " <td>";
			            	row += "   <button class='btn btn-primary btn-sm Approve-btn' data-empid='"+ item["empId"] +"' data-key='"+ key+"'>Pending</button>";
			            	row += " </td>";
			            }
			            else if(item["manager_status"]==="approved"){
			            	row += " <td>";
			            	row += "   <button class='btn btn-success btn-sm Approve-btn' data-empid='"+ item["empId"] +"' data-key='"+ key+"'>Approved</button>";
			            	row += " </td>";
			            }
			            if((item["admin_status"]==="pending") ||(item["finance_status"]==="pending")){
			            	row += " <td>";
			            	row += "   <button class='btn btn-primary btn-sm Reject-btn' data-empid='"+ item["empId"] +"' data-key='"+ key +"'>Pending</button>";
			            	row += " </td>";
			            }
			            
			            
			           // row += " </td>";
			            row += " </tr>";
		
			            // Subtable row (not part of the striped rows)
			            row += " <tr>";
			            row += "   <td colspan='8' class='p-0'>";
			            row += "     <div id='" + collapseId + "' class='collapse collapse-content'>";
			            row += "       <div class='subtable-wrapper'>";
			            row += "         <table class='table table-sm table-striped table-bordered m-0 '>";
			            row += "           <thead>";
			            row += "             <h3> Travel Details </h3>";
			            row += "             <tr>";
			            row += "               <th>Type</th>";
			            row += "               <th>From</th>";
			            row += "               <th>To</th>";
			            row += "               <th>Date</th>";
			            if(item.self==="yes"){
			            row += "               <th>Receipt</th>";
			            }
			            if(item.self==="yes"){
			            row += "               <th>Amount</th>";
			            }
			            row += "             </tr>";
			            row += "           </thead>";
			            row += "           <tbody>";
		
			            // Handling the arrays inside the object
			            const length = item.Destination.length;
		
			            for (let i = 0; i < length; i++) {
			                row += "             <tr>";
			                row += "               <td>" + (item.type[i] || "") + "</td>";
			                row += "               <td>" + (item.source[i] || "") + "</td>";
			                row += "               <td>" + (item.Destination[i] || "") + "</td>";
			                row += "               <td>" + (item.date[i] || "") + "</td>";
			                if(item.self==="yes"){
			                	var filePath = contextPath + "/files/" + item.receipt[i];
			                    row += '               <td><a href="' + filePath + '" target="_blank"><i class="fa fa-file-text" aria-hidden="true"></i></a></td>';
			                }
			                if(item.self==="yes"){
			                row += "               <td>" + (item.amount[i] || "") + "</td>";
			                }
			                row += "             </tr>";
			            }
		
			            row += "           </tbody>";
			            row += "         </table>";
			            row += "       </div>";
			            row += "     </div>";
			            row += "   </td>";
			            row += "</tr>";
		
			            mainTableBody.append(row);
			        }// Append the row to the main table body
		
			            
			            }
			        });
			        if (count === 0) {
			            $("#noDataMessage1").show();
			        } else {
			            $("#noDataMessage1").hide();
			        }
		
			        // Add striping manually
			        mainTableBody.find('.main-row:even').addClass('table-striped-row');
		        }  
			        
	    }
	 


});
</script>

</body>
</html>