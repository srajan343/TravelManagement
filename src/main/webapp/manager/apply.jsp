<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Page</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        .form-section { margin: 20px; }
        table { margin-top: 10px; }
        .remove-row { color: red; cursor: pointer; }
        .containerDiv {
            width: 98%;
            display: flex;
            flex-direction: column;
            height: 94vh;
            color: #000;
            background-color: rgba(255, 255, 255, 1); /* Semi-transparent background */
            top: 100px;
            height: 80vh; /* Table height limited to allow scrolling */
            border-radius: 15px;
            position: relative; /* Ensures child sticky elements behave correctly */
            overflow-y: auto; /* Enables vertical scrolling for the table data */
            overflow-x: hidden;
        }
    </style>
</head>
<body>

<%@ include file="../common/side_nav.jsp" %>
<div class="main-content">
    <div class="containerDiv">
        <p id="msg_para"></p>
        <form id="formData" enctype="multipart/form-data">
            <div class="container form-section">
                <!-- Form Header -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="customerName" class="form-label">Customer Name:</label>
                        <input type="text" class="form-control" id="customerName" name="customerName" placeholder="Enter Name" required>
                    </div>
                    <div class="col-md-2">
                        <label for="selfArranged" class="form-label">Self Arranged:</label>
                        <select id="selfArranged" class="form-select" name="selfArranged">
                            <option value="no">No</option>
                            <option value="yes">Yes</option>
                        </select>
                    </div>
                    <div class="col-md-4 d-flex align-items-end justify-content-end">
                        <button type="submit" id="applyBtn" class="btn btn-primary me-2">Apply</button>
                        <button type="reset" id="resetBtn" class="btn btn-secondary me-2">Reset</button>
                        <button type="button" id="addRow" class="btn btn-success">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-bordered align-middle">
                        <thead class="table-light col-12">
                        <tr>
                            <th class="col-1">Type</th>
                            <th class="col-2">From</th>
                            <th class="col-2">To</th>
                            <th class="col-1">Date</th>
                            <th class="col-2">Receipt</th>
                            <th class="col-1">Amount</th>
                            <th class="col-1">Remove</th>
                        </tr>
                        </thead>
                        <tbody id="tableBody">
                        <!-- Default Row -->
                        <tr>
                            <td>
                                <select class="form-select type" name="type" required>
                                    <option>Bus</option>
                                    <option>Train</option>
                                    <option>Air</option>
                                </select>
                            </td>
                            <td>
                                <select class="form-select from" name="from" required>
                                    <option value="">Select Location</option>
                                    <option value="Bangalore">Bangalore</option>
                                    <option value="Chennai">Chennai</option>
                                    <option value="Pune">Pune</option>
                                    <option value="Kolkata">Kolkata</option>
                                    <option value="Mumbai">Mumbai</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Gurgaon">Gurgaon</option>
                                    <option value="Hyderabad">Hyderabad</option>
                                    <option value="Noida">Noida</option>
                                </select>
                            </td>
                            <td>
                                <select class="form-select to" name="to" required>
                                    <option value="">Select Location</option>
                                    <option value="Bangalore">Bangalore</option>
                                    <option value="Chennai">Chennai</option>
                                    <option value="Pune">Pune</option>
                                    <option value="Kolkata">Kolkata</option>
                                    <option value="Mumbai">Mumbai</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Gurgaon">Gurgaon</option>
                                    <option value="Hyderabad">Hyderabad</option>
                                    <option value="Noida">Noida</option>
                                </select>
                            </td>
                            <td><input type="date" class="form-control date" name="date" required></td>
                            <td><input type="file" class="form-control receipt" name="receipt[0]" disabled></td>
                            <td><input type="number" class="form-control amount" name="amount" disabled></td>
                            <td class="text-center">
                                <i class="fas fa-trash remove-row disabled"></i>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const tableBody = document.getElementById('tableBody');

    const updateDropdown = (selectA, selectB) => {
        const selectedValue = selectA.value;

        // Reset options in the other dropdown
        Array.from(selectB.options).forEach(option => {
            option.disabled = false;
        });

        // Disable the selected value in the other dropdown
        if (selectedValue) {
            Array.from(selectB.options).forEach(option => {
                if (option.value === selectedValue) {
                    option.disabled = true;
                }
            });
        }

        // Ensure the value is not set to the disabled one
        if (selectB.value === selectedValue) {
            selectB.value = '';
        }
    };

    tableBody.addEventListener('change', (event) => {
        const row = event.target.closest('tr');
        if (row) {
            const fromSelect = row.querySelector('.from');
            const toSelect = row.querySelector('.to');

            if (event.target === fromSelect) {
                updateDropdown(fromSelect, toSelect);
            } else if (event.target === toSelect) {
                updateDropdown(toSelect, fromSelect);
            }
        }
    });
});
</script>
<script>
    // Add Row Functionality
    
  document.getElementById('resetBtn').addEventListener('click', function () {
	  window.location.href = "apply.jsp";
	  
  });
    
   document.getElementById('addRow').addEventListener('click', function () {
    const rowIndex = document.querySelectorAll('#tableBody tr').length;
    var newRow = "<tr class='main-row'>";
    newRow += "<td>";
    newRow += "<select class='form-select type' name='type' required>";
    newRow += "<option>Bus</option>";
    newRow += "<option>Train</option>";
    newRow += "<option>Air</option>";
    newRow += "</select>";
    newRow += "</td>";
    newRow += "<td>";
    newRow += "<select class='form-select from' name='from' required>";
    
	newRow += "<option value=''>Select Location</option>";
    
    newRow += "<option value='Bangalore'>Bangalore</option>";
    newRow += "<option value='Chennai'>Chennai</option>";
    newRow += "<option value='Pune'>Pune</option>";
    newRow += "<option value='Kolkata'>Kolkata</option>";
    newRow += "<option value='Mumbai'>Mumbai</option>";
    newRow += "<option value='Delhi'>Delhi</option>";
    newRow += "<option value='Gurgaon'>Gurgaon</option>";
    newRow += "<option value='Hyderabad'>Hyderabad</option>";
    newRow += "<option value='Noida'>Noida</option>";
    newRow += "</select>";
    newRow += "</td>";
    newRow += "<td>";
    newRow += "<select class='form-select to' name='to' required>";
	newRow += "<option value=''>Select Location</option>";
    
    newRow += "<option value='Bangalore'>Bangalore</option>";
    newRow += "<option value='Chennai'>Chennai</option>";
    newRow += "<option value='Pune'>Pune</option>";
    newRow += "<option value='Kolkata'>Kolkata</option>";
    newRow += "<option value='Mumbai'>Mumbai</option>";
    newRow += "<option value='Delhi'>Delhi</option>";
    newRow += "<option value='Gurgaon'>Gurgaon</option>";
    newRow += "<option value='Hyderabad'>Hyderabad</option>";
    newRow += "<option value='Noida'>Noida</option>";
    newRow += "</select>";
    newRow += "</td>";
    newRow += "<td><input type='date' class='form-control date' name='date' required></td>";
    newRow += "<td><input type='file' class='form-control receipt' name='receipt[" + rowIndex + "]' disabled required></td>";
    newRow += "<td><input type='number' class='form-control amount' name='amount' disabled required></td>";
    newRow += "<td class='text-center'>";
    newRow += "<i class='fas fa-trash remove-row'></i>";
    newRow += "</td>";
    newRow += "</tr>";

    document.getElementById('tableBody').insertAdjacentHTML('beforeend', newRow);

    // Enable fields for newly added row if selfArranged is "yes"
    const isSelfArranged = document.getElementById('selfArranged').value === 'yes';
    if (isSelfArranged) {
        enableFields();
    }
});

// Remove Row Functionality
   document.addEventListener('click', function (e) {
       if (e.target.classList.contains('remove-row')) {
           const tableBody = document.getElementById('tableBody');
           const rows = tableBody.querySelectorAll('tr');
           
           // Ensure at least one row remains
           if (rows.length > 1) {
               e.target.closest('tr').remove();
           } else {
               alert("At least one row must remain in the table.");
           }
       }
   });

// Enable/Disable Receipt and Amount Fields
document.getElementById('selfArranged').addEventListener('change', function () {
    const isSelfArranged = this.value === 'yes';
    if (isSelfArranged) {
        enableFields();
    } else {
        disableFields();
    }
});

// Function to Enable Fields
function enableFields() {
    document.querySelectorAll('.receipt, .amount').forEach(function (input) {
        input.disabled = false;
    });
}

// Function to Disable Fields
function disableFields() {
    document.querySelectorAll('.receipt, .amount').forEach(function (input) {
        input.disabled = true;
    });
}

// Handle form submission
$('#formData').submit(function (event) {
    var empId = "<%= session.getAttribute("empId") %>"; // Retrieve empId from the session

    event.preventDefault(); // Prevent normal form submission

    const isSelfArranged = $('#selfArranged').val() === 'yes';
    const formData = new FormData();
    const currentTimestamp = new Date().toISOString(); // Capture current date and time in ISO format
    
     // Example ISO timestamp
    const date = new Date(currentTimestamp);

    // Format the date and time (e.g., "20-12-2024 18:22")
    const formattedDate = date.toLocaleString('en-GB', { 
        day: '2-digit', 
        month: '2-digit', 
        year: 'numeric', 
        hour: '2-digit', 
        minute: '2-digit',
        hour12: false // 24-hour format
    });

    console.log(formattedDate); // Output: "20/12/2024, 18:22"

    
    
    const applicationData = {
        customer_name: $('#customerName').val() || '',
        empId: empId, // Add empId to the application data
        self: isSelfArranged ? 'yes' : 'no',
        timestamp: formattedDate, // Add timestamp to the application data
        rows: [],
    };

    let hasError = false;

    // Collect data from table rows
    $('#tableBody tr').each(function (index, row) {
        const rowData = {
            type: $(row).find('.type').val() || '',
            from: $(row).find('.from').val() || '',
            to: $(row).find('.to').val() || '',
            date: $(row).find('.date').val() || '',
            amount: $(row).find('.amount').val() || '',
            receipt: '', // Will be populated if selfArranged is "yes"
        };

        if (isSelfArranged) {
            const receiptInput = $(row).find('.receipt')[0];
            if (receiptInput && receiptInput.files.length > 0) {
                const file = receiptInput.files[0];
                const uniqueFileName = "file_" + Date.now() + "_" + index + "_" + empId + ".pdf";
                formData.append("receipt_" + index, file, uniqueFileName);
                rowData.receipt = uniqueFileName;
            }
        }

        applicationData.rows.push(rowData);
    });

    try {
        const jsonString = JSON.stringify(applicationData);
        console.log("Stringified JSON:", jsonString);

        formData.append('applicationData', jsonString);
    } catch (err) {
        console.error("Error during JSON.stringify:", err);
        $('#msg_para').html('<p style="color: red;">Error preparing form data.</p>');
        hasError = true;
    }

    if (hasError) {
        return; // Stop submission if there's an error
    }

    // Submit the form data via AJAX
    $.ajax({
        url: 'appHandlerServlet',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
            alert("Application Submitted Successfully");
            document.getElementById('formData').reset();
            window.location.href = "apply.jsp";
        },
        error: function (xhr, status, error) {
            alert("Error occurred while submitting application");
        }
    });
});





    
</script>
</body>
</html>
