<!-- Include Bootstrap and Chart.js as already in your code -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dept</title>
<style>


.main-content {
    color: #fff;
    
    
}
.containerDiv{
	width: 98%;
	display:flex;
    flex-direction:column;
    justify-content:space-around;
    height:94vh;

}
.graph1 {
	display: flex;
	align-items: center;
	flex-direction:column;
	justify-content: center;
    background-color: rgba(255, 255, 255, 0.2); /* Semi-transparent background */
    width: 30vw;
    height: 35vh;
    border-radius: 15px;

}
.para{
display: flex;
flex-direction: row;
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

<%@include file="../common/side_nav.jsp" %>
<div class="main-content">
    
    <div class="containerDiv">
        <div class="graphDiv">
            <div class="graph1">
                <canvas id="myChart"  width="250" height="250"></canvas>
                <div class="para">
                	<p style="display:inline">No Records Found <span id="p0"></span></p>&nbsp;&nbsp;
                	<p style="display:inline">Accepted: <span id="p1"></span></p>&nbsp;&nbsp;
                	<p style="display:inline"> Rejected: <span id="p2"></span></p>&nbsp;&nbsp;
                	<p style="display:inline">Pending: <span  id="p3"></span></p>&nbsp;&nbsp;
                </div>
            </div>
            <div class="graph1">
                <canvas id="myChart1" style="width:100%;height:230px"></canvas>
            </div> 
        </div>
        <div class="requestDiv">
            <table class="table table-striped table-hover table-dark table-borderless align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Application No</th>
                        <th>Employee ID</th>
                        <th>Name</th>
                        <th>Manager Name</th>
                        <th>Source</th>
                        <th>Destination</th>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody class="table-class">
                    <!-- Rows will be dynamically populated by JavaScript -->
                </tbody>
            </table>      
        </div>
    </div>
</div>

<!-- Accept Modal -->
<div class="modal fade" id="acceptModal" tabindex="-1" aria-labelledby="acceptModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="acceptModalLabel">Confirm Accept</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to accept this application?
                <p><strong>Application No: </strong> <span id="accept-appNo"></span></p>
                <p><strong>Employee ID: </strong> <span id="accept-empId"></span></p>
                <p><strong>Name: </strong> <span id="accept-empName"></span></p>
                <p><strong>Manager Name: </strong> <span id="accept-managerName"></span></p>
                <p><strong>Type: </strong> <span id="accept-type"></span></p>
                <p><strong>Source: </strong> <span id="accept-source"></span></p>
                <p><strong>Destination: </strong> <span id="accept-destination"></span></p>
                <p><strong>Date: </strong> <span id="accept-date"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-success" id="confirmAcceptBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>

<!-- Reject Modal -->
<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="rejectModalLabel">Reject Application</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>Application No:</strong> <span id="reject-appNo"></span></p>
                <textarea id="reject-reason" class="form-control" placeholder="Enter reason for rejection"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirmRejectBtn" disabled>Reject</button>
            </div>
        </div>
    </div>
</div>
<!-- <script>


document.addEventListener("DOMContentLoaded", function () {
    fetchApplications();

    // Event delegation for Accept and Reject buttons
    document.querySelector("tbody").addEventListener("click", function (e) {
        if (e.target.classList.contains("accept-btn")) {
            const row = e.target.closest("tr");
            const appNo = row.cells[0].textContent;
            const empId = row.cells[1].textContent;
            const empName = row.cells[2].textContent;
            const managerName = row.cells[3].textContent;
            const source = row.cells[4].textContent;
            const destination = row.cells[5].textContent;
            const date = row.cells[6].textContent;
            const type = row.cells[7].textContent;
            

            // Populate modal fields
            document.getElementById("accept-appNo").textContent = appNo;
            document.getElementById("accept-empId").textContent = empId;
            document.getElementById("accept-empName").textContent = empName;
            document.getElementById("accept-managerName").textContent = managerName;
            document.getElementById("accept-source").textContent = source;
            document.getElementById("accept-destination").textContent = destination;
            document.getElementById("accept-date").textContent = date;
            document.getElementById("accept-type").textContent = type;

            new bootstrap.Modal(document.getElementById("acceptModal")).show();
        }

        if (e.target.classList.contains("reject-btn")) {
            const row = e.target.closest("tr");
            const appNo = row.cells[0].textContent;
            document.getElementById("reject-appNo").textContent = appNo;
            new bootstrap.Modal(document.getElementById("rejectModal")).show();
        }
    });

    // Enable Reject button when text is entered
    document.getElementById("reject-reason").addEventListener("input", function () {
        document.getElementById("confirmRejectBtn").disabled = !this.value.trim();
    });

    // Confirm Accept action
    document.getElementById("confirmAcceptBtn").addEventListener("click", function () {
        const appNo = document.getElementById("accept-appNo").textContent;
        updateApplicationStatus(appNo, "approve");
        fetchApplications();
    });

    // Confirm Reject action
    document.getElementById("confirmRejectBtn").addEventListener("click", function () {
        const appNo = document.getElementById("reject-appNo").textContent;
        const reason = document.getElementById("reject-reason").value;
        updateApplicationStatus(appNo, "reject", reason);
    });

    // Function to update the application status
    function updateApplicationStatus(appNo, status, reason = "") {
        const payload = { appNo, status, reason };
        fetch("../testAdminDash", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("Application updated successfully!");
                fetchApplications(); // Refresh the table
            } else {
                alert("Failed to update application.");
                fetchApplications(); // Refresh the table
            }
        })
        .catch(error => console.error("Error:", error));
    }
});
document.addEventListener("DOMContentLoaded", function () {
    fetchApplications();
});

// Function to fetch applications from the servlet
function fetchApplications() {
    fetch('../testAdminDash') // Replace 'YourAppName' with the actual context path
        .then(response => response.json())
        .then(data => {
        	console.log("dataabjbadjs:",data);
            updateTable(data);
            var chartData = processAcceptanceRejectionData(data);
            updateChart(chartData);
            //updateChart(data);
            
        })
        .catch(error => console.error('Error fetching data:', error));
}

// Function to dynamically populate the table
function updateTable(data) {
    const tableBody = document.querySelector("tbody");
    tableBody.innerHTML = ""; // Clear existing table rows

    for (const appNo in data) {
        const appDetails = data[appNo];
        console.log("appdetails:",appDetails);
        console.log("appdetails self:",appDetails.self);
        // Skip rows where self is "yes"
        if (appDetails.self === "yes" && (appDetails.admin_status == "approve" ||appDetails.admin_status == "reject" )) {
            continue;
        }

        // Construct the table row for valid data
        var row = "<tr>";
        row += "<td>" + appNo + "</td>";
        row += "<td>" + appDetails.empId + "</td>"; 
        row += "<td>" + appDetails.name + "</td>"; 
        row += "<td>" + appDetails.manager_name + "</td>";
        row += "<td>" + appDetails.source + "</td>";
        row += "<td>" + appDetails.Destination + "</td>";
        row += "<td>" + appDetails.date + "</td>";
        row += "<td>" + appDetails.type + "</td>";
        row += "<td>";
        row += "<button class='btn btn-success btn-sm accept-btn'>Accept</button>&nbsp;&nbsp;";
        row += "<button class='btn btn-danger btn-sm reject-btn'>Reject</button>";
        row += "</td>";
        row += "</tr>";

        tableBody.innerHTML += row;
        console.log("data:", appDetails);
    }
}

// Fetch applications data and update the chart
//document.addEventListener("DOMContentLoaded", function () {
 //   fetch('../testAdminDash') // Replace with the correct servlet URL
   //     .then(response => response.json())
     //   .then(data => {
       //     var chartData = processAcceptanceRejectionData(data);
         //   updateChart(chartData);
        //})
        //.catch(error => console.error('Error fetching data:', error));
//});

</script>
 -->
 <script>
 $(document).ready(function(){
	 console.log("hello insdei the script");
	 loadInsights();
	 console.log("hello insdei the script 2");
	 $("#p0").hide();
 })
 
 function loadInsights() {
        // Fetch Booking Data
        $.ajax({
            url: "ListChartServlet",
            type: "GET",
            dataType: "json",
            success: function (data) {
                console.log(data);
                console.log(Chart.version);
                var pending = 0, approved = 0, cancelled = 0;
                Object.keys(data).forEach(function (key) {
                    var adminStatus = data[key].admin_status; // Access the admin_status of each entry

                    if (adminStatus === "pending") pending++;
                    else if (adminStatus === "approve") approved++;
                    else if (adminStatus === "reject") cancelled++;
                });
 					console.log("***************");
 					console.log(pending,"",approved,"",cancelled);
                // Donut Chart
                const ctx = document.getElementById('myChart').getContext('2d');
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Pending', 'Approved', 'Rejected'],
                        datasets: [{
                            data: [pending, approved, cancelled],
                            backgroundColor: ['#FFCA28', '#4CAF50', '#F44336']
                        }]
                    },
                    options: {
                        responsive: false,
                        plugins: {
                            legend: {
                                position: 'top', // Position of legend
                                
                                labels: {
                                    font: {
                                        size: 14, // Adjust font size
                                        family: "'Arial', sans-serif", // Font family
                                        color: '#fff' // Font color
                                    },
                                    color: '#fff',
                                    boxWidth: 20, // Width of the legend color box
                                    padding: 10 // Padding around legend items
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
                document.getElementById("p1").innerHTML = approved;
                document.getElementById("p2").innerHTML = cancelled;
                document.getElementById("p3").innerHTML = pending;
                
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        })

 };
 
 
 
 </script>
</body>
</html>
