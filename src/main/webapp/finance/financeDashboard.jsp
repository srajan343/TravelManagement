<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Finance Dept</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>


.main-content {
    color: #fff;
    
    
}
.containerDiv{
	width:98%;
	display:flex;
    flex-direction:column;
    justify-content:space-around;
    height:94vh;

}
.graph1 {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction:column;
    background-color: rgba(255, 255, 255, 0.2); /* Semi-transparent background */
    width: 30vw;
    height: 35vh;
    border-radius: 15px;

}

.graphDiv {
	
	margin-top: 20px;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
}


.requestDiv {
    background-color: rgba(255, 255, 255, 0.2); /* Semi-transparent background */
    
    height: 50vh; /* Table height limited to allow scrolling */
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


.para{
display: flex;
flex-direction: row;
}

.table-striped-row {
        background-color: #f8f9fa; /* Light gray for striping */
    }
    .subtable-wrapper {
        padding: 20px;
}

/* Ensure buttons are aligned side by side */
.action-column {
    display: flex;
    justify-content: space-between; /* Ensure space between the buttons */
    gap: 10px; /* Optional: Adjust the gap between the buttons */
}

</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>
<body>
<!-- <h1>Welocme Finance person</h1> -->
<%@include file="../common/side_nav.jsp" %>
<div class="main-content">
    <!-- <h2 style="margin:0">Admin</h2> -->
    <div class="containerDiv">
        <div class="graphDiv">
            <div class="graph1" >
                <canvas id="myChart" width="250" height="250" style=""></canvas>
                <p style="margin-bottom:0px">Applications</p>
                <div class="para">
	                <p style="display:none" id="p0">No Records Found </p>&nbsp;&nbsp;
                </div>
            </div>
            <!-- <div class="graph1">
                <canvas id="myChart1"  width="250" height="250"></canvas>
            </div> --> 
        </div>
        <div class="requestDiv">
            <table class="table table-striped table-light table-borderless col-12">
                <thead class="table-light head-table col-12">
                    <tr>
                        <th class="col-1">App No</th>
                        <th class="col-2">Employee ID</th>
                        <th class="col-2">Name</th>
                        <th class="col-2">Manager Id</th>
                        <th class="col-2">Manager Name</th>
                       <th class="col-2">Total Amount</th>
                        <th class="col-2">Action</th>
                    </tr>
                </thead>
                <tbody class="table-class">
                    <!-- Rows will be dynamically populated by JavaScript -->
                </tbody>
            </table>    
            <div id="noDataMessage" style="display: none; text-align: center; margin-top: 20px;">
           	 No Recent Applicaiton Received.
        	</div>  
        </div>
    </div>
</div>

<!-- Modal for Accept/Reject action -->
<div class="modal fade" id="actionModal" tabindex="-1" aria-labelledby="actionModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="actionModalLabel">Action Confirmation</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>App No:</strong> <span id="employeeKey"></span></p>
                    <p><strong>Employee Name:</strong> <span id="modalEmployeeName"></span></p>
                    <p><strong>Employee ID:</strong> <span id="modalEmployeeId"></span></p>
                    <p><strong>Amount:</strong> <span id="modalAmount"></span></p>
                    <p>Do you want to <span id="modalAction"></span> this employee application? </p>

                    <!-- Remarks input for rejection -->
                    <div id="rejectRemarksDiv" style="display: none;">
                        <p><strong>Reason for rejection:</strong></p>
                        <textarea id="rejectRemarks" class="form-control" rows="4" placeholder="Enter reason for rejection"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="confirmAction" disabled>Confirm</button>
                </div>
            </div>
        </div>
    </div>

<script>
$(document).ready(function(){
	 loadRequests();
	 
	 $("#noDataMessage").hide();
	 
	 var contextPath = "<%= request.getContextPath() %>";
	 console.log("contextPath",contextPath);
	 
	 //var dis = document.getElementById("p0");
	 //console.log("display here",dis.innerText);
	 
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
	 
	 /*async function getUsers() {
			return $.ajax({
				url: "ListUserServlet",
				type: "GET",
				dataType: 'json',
				success:function(response){
					console.log(response);
				},
				error: function (xhr, status, error) {
	                console.error(error);
	            }
				
			})
		}*/
	 
	// async function loadRequests(){
			
		var countAccept = 0;
		 var countReject = 0;
		 var countPending = 0;
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
				 console.log(response);
				 
				 countAccept=0;
				 countReject = 0;
				 countPending = 0;
				 Object.keys(response).forEach(function (key) {
					 
				 if(response[key].self =="yes"){
					 
					 var finance_status = response[key].finance_status;
					 var manager_status = response[key].manager_status;
					 if(finance_status === "settled" && manager_status === "approved") countAccept++;
					 else if(finance_status === "rejected" && manager_status!=="rejected") countReject++;
					 else if(finance_status === "pending" && manager_status==="approved") countPending++;
				 	}
					
				 })
				 
				 if(countAccept ==0&&countReject==0&&countPending==0){
					 document.getElementById("p0").style.display = "inline";
					 document.getElementById("myChart").style.display = "none";
				 }
				tableData(response);	
				 console.log(countAccept, countReject, countPending);
				 loadInsights();
			 },
			 
			 error: function (xhr, status, error) {
	                console.error(error);
	            }
			 
			 
		 })
		 
		 
		 
	 }
	 
	 
	 function tableData(jsonData){
		 
	        const mainTableBody = $(".table-class");
	        mainTableBody.empty(); // Clear existing table content
	        if (Object.keys(jsonData).length === 0 && jsonData.constructor === Object) {
	        	$("#noDataMessage").show();
	        }else{
			        Object.keys(jsonData).forEach((key, index) => {
			            const item = jsonData[key];
			            console.log("itmess",item);
			            console.log("key: ",key,"index: ",index);
			            console.log("*****************jsonData",item["empId"]);
			            const collapseId = "collapse-" + index;
			           // var self = (item["manager_status"] ==="approved"&&item["self"] ==="yes")
			            if((item["self"] ==="yes") && (item["manager_status"] ==="approved")){
				        if( item["finance_status"]==="pending"){
						
				            var totalAmount = 0;
				            var length1 = item.Destination.length;
				            for (let i = 0; i < length1; i++) {
				                totalAmount += parseFloat(item.amount[i] || 0); // Add the amount to totalAmount
				            }
		
				        	
			            // Main row with class "main-row"
			            var row = "<tr class='main-row'>";
			            row += "  <td>";
			            row += "<a href='#' style='text-decoration:none;color:#000;' class='toggle-collapse' data-toggle='collapse' data-target='#" + collapseId + "' role='button' aria-expanded='false' aria-controls='" + collapseId + "'>";
			            row += "<i class='toggle-icon fas fa-chevron-down' id='icon-" + index + "'></i>&nbsp;&nbsp; " + key;
			            row += "</a>";
			            row += " </td>";
			            row += "  <td>" + item["empId"] + "</td>";
			            row += "  <td>" + item["name"] + "</td>";
			            row += "  <td>" + item["manager_id"] + "</td>";
			            row += "  <td>" + item["manager_name"] + "</td>";
			            row += "<td>"+totalAmount.toFixed(2) + "</td>";
			            
			            row += " <td class='action-column'>";
			            row += "   <button class='btn btn-success btn-sm Approve-btn' data-empid='"+ item["empId"] +"' data-key='"+ key+"' data-amount='"+totalAmount.toFixed(2)+"' data-empname='"+item["name"]+"'>Accept</button>";
			            row += "   <button class='btn btn-danger btn-sm Reject-btn' data-empid='"+ item["empId"] +"' data-key='"+ key +"' data-empname='"+item["name"]+"' data-amount='"+totalAmount.toFixed(2)+"'>Reject</button>";
			            row += " </td>";
			            row += " </tr>";
		
			            // Subtable row (not part of the striped rows)
			            row += " <tr>";
			            row += "   <td colspan='7' class='p-0'>";
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
			            row += "               <th>Receipt</th>";
			            row += "               <th>Amount</th>";
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
			                if (item.receipt[i]) {
			                    var filePath = contextPath + "/files/" + item.receipt[i];
			                    row += '               <td><a href="' + filePath + '" target="_blank"><i class="fa fa-file-text" aria-hidden="true"></i></a></td>';
			                } else {
			                    row += "               <td></td>"; // Empty cell if no receipt
			                }
			                row += "               <td>" + (item.amount[i] || "") + "</td>";
			                row += "             </tr>";
			            }
		
			            row += "           </tbody>";
			            row += "         </table>";
			            row += "       </div>";
			            row += "     </div>";
			            row += "   </td>";
			            row += "</tr>";
		
			            mainTableBody.append(row);
			        }
				        
			        }// Append the row to the main table body
			        });
			        if (count === 0) {
			            $("#noDataMessage").show();
			        } else {
			            $("#noDataMessage").hide();
			        }
		
			        // Add striping manually
			        mainTableBody.find('.main-row:even').addClass('table-striped-row');
			        
	 		}
	    }
	 
	 
	 
	 $(".table-class").on("click",".Approve-btn",function(){
		 	var empId = $(this).data('empid');
	    	var key = $(this).data('key');
	    	//console.log("Date" + date);
	    	var name = $(this).data('empname');
	    	var amount = $(this).data('amount');
	    	var status = "settled";
	    	var action = "SETTLE";
         console.log("empId:",empId);

         //function for AJAX request to approve the trip
         		//statusRequest(empId,key,status);
         //sendMail();
         
         //loadRequests();
         
          $("#modalEmployeeName").text(name);
                $("#modalEmployeeId").text(empId);
                $("#modalAction").text(action);
                $("#employeeKey").text(key);
               $("#modalAmount").text(amount);
                

                // Show the modal
                $("#actionModal").modal("show");
				$("#rejectRemarksDiv").hide();
                $("#confirmAction").prop("disabled", false); // Enable confirm button
  
	 })
	 
	 //after confirming the data 
	    $("#confirmAction").on("click", function () {
            var key = $("#employeeKey").text();
            var empId = $("#modalEmployeeId").text();
            var action = $("#modalAction").text();
            var amount = $("#modalAmount").text();
            var name = $("#modalEmployeeName").text();
            var remarks = $("#rejectRemarks").text();
            console.log("empId 2",empId);
            //var financeStatus = action.toLowerCase(); // "accept" or "reject"
            var remarks =  $("#rejectRemarks").val();
            console.log("remarks::",remarks);

            
 			const currentTimestamp = new Date().toISOString(); // Capture current date and time in ISO format
            
            // Example ISO timestamp
           const date = new Date(currentTimestamp);

           // Format the date and time (e.g., "20-12-2024 18:22")
           var formattedDate = date.toLocaleString('en-GB', { 
               day: '2-digit', 
               month: '2-digit', 
               year: 'numeric', 
               hour: '2-digit', 
               minute: '2-digit',
               hour12: false // 24-hour format
           });
            
            
            var user =  "finance";
            
            if(action === "SETTLE"){
            	
            	
            	$.ajax({
                    url: 'SendMailServlet', // Servlet URL for updates
                    method: 'POST',
                    //contentType: 'application/json',
                    data: { key: key,
                        name: name,
                        amount :amount,
                        empId:empId,
                        user:user,
                        timeStamp:formattedDate,
                        action :action},
                    success: function (response) {
                        // Remove the row dynamically from the table
                        //$("#row-" + key).remove();
                        //console.log("actojn action",action);
                        var status = "settled"
                        $("#actionModal").modal('hide');
                        statusRequest(empId,key,status,remarks,user,formattedDate);
                    },
                    error: function (xhr, status, error) {
                        alert('Error updating application.');
                    }
                });
            	
            	
            	
            }else if(action ==="REJECT"){
            	
            	
            	$.ajax({
                    url: 'SendMailServlet', // Servlet URL for updates
                    method: 'POST',
                    //contentType: 'application/json',
                    data: {key: key,
                        
                        name:name,
                        amount:amount,
                        action:action,
                        remarks: remarks,
                        empId:empId,
                        timeStamp:formattedDate
                       
                        },
                    success: function (response) {
                        // Remove the row dynamically from the table
                        //$("#row-" + key).remove();
						var status = "rejected"
                        $("#actionModal").modal('hide');
                        statusRequest(empId,key,status,remarks,user,formattedDate);
                    },
                    error: function (xhr, status, error) {
                        alert('Error updating application.');
                    }
                });
            }

            console.log("inside the confirmaction.. after accept.....");

            /*$.ajax({
                url: 'testingUpdateServlet', // Servlet URL for updates
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(updateData),
                success: function (response) {
                    // Remove the row dynamically from the table
                    $("#row-" + key).remove();
                    $("#actionModal").modal('hide');
                },
                error: function (xhr, status, error) {
                    alert('Error updating application.');
                }
            });*/
        });
	 
	 
	 $(".table-class").on("click",".Reject-btn",function(){
		 	var empId = $(this).data('empid');
	    	var key = $(this).data('key');
	    	console.log("reject btn");
	    	var name = $(this).data('empname');
	    	var amount = $(this).data('amount');
	    	var status = "rejected";
	    	
         	var action = "REJECT";

         //function for AJAX request to approve the trip
         		//statusRequest(empId,key,status);
         //sendMail();
         
        // loadRequests();
        
         $("#modalEmployeeName").text(name);
                $("#modalEmployeeId").text(empId);
                $("#modalAction").text(action);
                $("#employeeKey").text(key);
                $("#modalAmount").text(amount);

                // Show the modal
                $("#actionModal").modal("show");
                $("#rejectRemarksDiv").show();
                $("#rejectRemarks").val(""); // Clear remarks input
                $("#confirmAction").prop("disabled", true);
	 
	 });
	 
	 //to block the confirm button
	 $("#rejectRemarks").on("input", function () {
         var remarks = $(this).val();
         if (remarks.trim() !== "") {
             $("#confirmAction").prop("disabled", false);
         } else {
             $("#confirmAction").prop("disabled", true);
         }
     });

	 
	 
	 function statusRequest(empId,key,status,remarks,user,formattedDate){
		 console.log("insdie the status req:::",remarks);
		 $.ajax({
			 url: "FinanceApproveServlet",
			 type:"POST",
			 data: {key: key, empId: empId,status :status,remarks:remarks,user:user,timeStamp:formattedDate},
			 success: function() {
				 console.log("success",status);
				 
				 loadRequests();
					//window.location.href = "./financeDashboard.jsp";
			 },error: function (xhr, status, error) {
	                console.error(error);
	            }		 
			 })
 
	 }
	 

	 
	 //chart function
	 
	 
	let myChart = null; // Declare the global variable to hold the chart instance
	 function loadInsights() {
	     
	             if (myChart != null) {
	                 myChart.destroy(); // Destroy the existing chart before creating a new one
	             }
		 console.log("entering into load insights");

	             // Get the canvas context for the chart
	             const ctx = document.getElementById('myChart').getContext('2d');

	             // Clear the canvas before creating a new chart
	             ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
				console.log(countPending, countAccept, countReject);
	             // Re-create the chart
	             myChart = new Chart(ctx, {
	                 type: 'doughnut',
	                 data: {
	                     labels: ['Pending', 'Settled', 'Rejected'],
	                     datasets: [{
	                         data: [countPending, countAccept, countReject],
	                         backgroundColor: ['#FFCA28', '#4CAF50', '#F44336']
	                     }]
	                 },
	                 options: {
	                     responsive: false, // Ensure responsiveness
	                     //maintainAspectRatio: true, // Maintain the aspect ratio
	                     plugins: {
	                         legend: {
	                             position: 'right',
	                             labels: {
	                                 font: {
	                                     size: 14,
	                                     family: "'Arial', sans-serif",
	                                     color: '#fff'
	                                 },
	                                 color: '#fff',
	                                 boxWidth: 20,
	                                 padding: 10
	                             }
	                         }
	                     },
	                     layout: {
	                         padding: {
	                             left: 10,
	                             right: 10,
	                             top: 10,
	                             bottom: 10
	                         }
	                     }
	                 }
	             });

	             // Update the displayed counts
	            //// document.getElementById("p1").innerHTML = approved;
	             //document.getElementById("p2").innerHTML = cancelled;
	             //document.getElementById("p3").innerHTML = pending;

	         
	 }


	 
 });
 
 </script>
 
</body>

</html>