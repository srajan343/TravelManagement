<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f0f0f0;
    color: #333;
    overflow: hidden;
}

.containerDiv {
    width: 100%;
    display: flex;
    justify-content: center;
    flex-direction: column;
}

.form-container {
    background: rgba(255, 255, 255, 0.2);
    color: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 900px;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.form-group {
    width: 100%;
    margin-bottom: 20px;
}

.form-group label {
    margin-bottom: 5px;
    font-weight: bold;
}

.form-group input, .form-group select, .form-group button {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
}

.form-group button {
    background-color: #4FD1C5;
    color: white;
    border: none;
    cursor: pointer;
    font-size: 16px;
}

.form-group button:hover {
    background-color: #38B2AC;
}

/* Back Button Styling */
.back-button {
    background-color: #007BFF;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    width: 80px;
    display: flex;
    justify-content: left;
}

.back-button:hover {
    background-color: #0056b3;
}

/* Modal Styles */
#changeManagerModal{
	margin-left:35%;
	margin-top:10%;
	width:50%;
	height:50%;
}
.modal {
    position: relative;
    top: 30%;
    left: 30%;
    width: 100%;
    height: 100%;
    //background-color: rgba(0, 0, 0, 0.7);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

.modal-content {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    width: 50%;
    max-width: 600px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.modal-footer {
    text-align: right;
}

.modal-footer .btn {
    background-color: #4FD1C5;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
}

.modal-footer .btn:hover {
    background-color: #38B2AC;
}

/* Media Queries for Responsiveness */
@media (min-width: 600px) {
    .form-group {
        width: 45%;
    }

    .form-group:first-of-type {
        margin-right: 20px;
    }

    .form-container {
        max-width: 900px;
    }
}

@media (max-width: 600px) {
    .form-group {
        width: 100%;
    }

    .form-container {
        padding: 20px;
    }

    .form-group button {
        font-size: 14px;
    }
}

@media (max-width: 400px) {
    .form-group input, .form-group select, .form-group button {
        font-size: 12px;
    }
}
</style>
</head>
<body>
<%@include file="../common/side_nav.jsp" %>

<%
    HttpSession session1  = request.getSession();
    String userId = (String) session1.getAttribute("editUserId");
%>

<div class="main-content">
    <div class="containerDiv">
        <button id="backButton" class="back-button" style="display:block" onclick="window.history.back();">Back</button>

        <p id="msg_para"></p>

        <form class="form-container" id="editUserForm">
            <div class="form-group">
                <label for="empid">Employee ID</label>
                <input type="text" style="color:#fff" id="empid" name="empid" placeholder="Enter Employee ID" readonly disabled required>

                <label for="email">Email ID</label>
                <input type="email" id="email" name="email" placeholder="Enter Email ID" required>

                <label for="activeStatus">Employee Status</label>
                <select id="activeStatus" name="activeStatus" required>
                    <option value="">Select Status</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                </select>

                <label for="assign-manager">Assign Manager</label>
                <select id="assign-manager" name="assign-manager" required></select>
            </div>

            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter Name" required>

                <label for="location">Location</label>
                <select name="location" id="location" required>
                    <option value="" disabled selected>Select your location</option>
                    <option value="Bangalore">Bangalore</option>
                    <option value="Chennai">Chennai</option>
                    <option value="Pune">Pune</option>
                    <option value="Coimbatore">Coimbatore</option>
                    <option value="Gurgaon">Gurgaon</option>
                </select>

                <label for="addAsManager">Add as Manager</label>
                <select id="addAsManager" name="addAsManager" required>
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>

                <button type="submit">Update</button>
            </div>
        </form>

        <!-- Modal for manager inactive -->
        
        <div id="changeManagerModal" class="modal">
            <div class="modal-content">
                <h4>Change Manager</h4>
                <p>You are about to deactivate this manager. Please select a new manager for their employees.</p>
                
                <label for="newManager">Select New Manager</label>
                <select id="newManager" name="newManager" required></select>
        
                <div id="employeeList"></div> <!-- List of employees affected by this change -->
        
                <div class="modal-footer">
                    <button id="cancelChange" class="btn">Cancel</button>
                    <button id="confirmChange" class="btn">Confirm Change</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function(){
    getUserData();

    $("#editUserForm").hide(); // Hide the form initially
    $("#backButton").show(); // Show the back button initially

    let isManager = false; // To track if the user is a manager
    let managedEmployees = []; // To store the list of employees managed by this manager

    function getUserData(){
        $.ajax({
            url: 'ListUserServlet',
            method: 'GET',
            datatype: 'json',
            success: function(response) {
                var userId = "<%= userId %>"; // Get the current user ID to edit
                var userData = response[userId]; // Retrieve the specific user data

                if (userData) {
                    // Populate the form fields with user data
                    $('#empid').val(userId); // Employee ID
                    $('#email').val(userData.email); // Email
                    $('#name').val(userData.name); // Name
                    $('#activeStatus').val(userData.active === "yes" ? "active" : "inactive"); // Active Status
                    $('#location').val(userData.location); // Location
                    $('#addAsManager').val(userData.empType === "manager" ? "yes" : "no"); // Manager Status

                    // If the current user is the top-level manager, disable the edit options
                     if (isSuperManager(userData)) {
                        disableEditOptions(); // Disable the fields for top-level manager
                    }

                    console.log("selected man id",userData.manager_id);
                    // Call the existing function to populate manager options
                    populateManagerOptions(userId, userData.manager_id);

                    // Show the form after populating
                    $('#editUserForm').show();
                } else {
                    $('#msg_para').html('<p style="color: red;">User data not found.</p>');
                }
            },
            error: function() {
                $('#msg_para').html('<p style="color: red;">An error occurred. Please try again later.</p>');
            }
        });
    }

    // Function to check if the user is the top-level manager
    function isSuperManager(userData) {
        return userData.empType === "superManager"; // Check if the empType is superManager
    }


    // Disable the fields if the user is the top-level manager
    function disableEditOptions() {
        $('#addAsManager').prop('disabled', true); // Disable "Add as Manager" dropdown
        $('#activeStatus').prop('disabled', true); // Disable "Active/Inactive" status dropdown
        $('#editUserForm button').prop('disabled', true); // Disable the edit button (optional)
        $('#assign-manager').prop('disabled', true);
    }

    var usersList = "";

    function populateManagerOptions(editedUserId, selectedManagerId) {
        $.ajax({
            url: 'ListUserServlet',
            type: 'GET',
            dataType: 'json',
            success: function(users) {
                usersList = users;  // Populating usersList with all users
		
                console.log("users in the list",users);
                
                //modal implementation
                console.log("editedUserId",editedUserId);
                populateEmployeeList(users,editedUserId);
                var options = "<option value='' disabled>Select Manager</option>";

                // Loop through the users and populate the manager dropdown
                $.each(users, function(key, item) {
                    if (item.empType === "manager" && key !== editedUserId && item.active === "yes") {
                        // Check if the user is already in the hierarchy to prevent circular relationships
                        var isCircular = checkCircularRelationship(users, editedUserId, key);
                        if (!isCircular) {
                            var isSelected = key === selectedManagerId ? "selected" : "";
                            options += "<option value='" + key + "' " + isSelected + ">" + item.name + "</option>";
                        }
                    }
                });

                $("select#assign-manager").html(options);
            },
            error: function() {
                console.log("Error fetching manager data.");
            }
        });
    }

    // Recursive function to check circular relationships
    function checkCircularRelationship(users, editedUserId, potentialManagerId) {
        // Base case: If no manager is assigned or loop reaches a non-manager
        if (!users[potentialManagerId] || !users[potentialManagerId].manager_id) {
            return false;
        }

        // Check if the potential manager eventually manages the edited user
        if (users[potentialManagerId].manager_id === editedUserId) {
            return true; // Circular relationship detected
        }

        // Recursively check up the hierarchy
        return checkCircularRelationship(users, editedUserId, users[potentialManagerId].manager_id);
    }

    // Listen for status change
    $('#activeStatus').on('change', function() {
        var selectedStatus = $(this).val();
        
        if (selectedStatus === "inactive" && $('#addAsManager').val() === "yes") {
            // Fetch employees managed by this user (only if they are a manager)
            fetchManagedEmployees();
        }
    });

    // Fetch employees managed by the current manager
    function fetchManagedEmployees() {
        var managerId = $('#empid').val(); 
        var managerName = $('#name').val();// Get the current manager's ID

        $.ajax({
            url: 'GetEmployeesUnderManagerServlet',
            type: 'GET',
            data: { managerId: managerId },
            dataType: 'json',
            success: function(employees) {
                // Get the number of keys in the employees object
                var employeeCount = Object.keys(employees).length;

                if (employeeCount > 0) {
                    managedEmployees = employees; // Store the employees data
                    //populateEmployeeList(employees); // Populate the employee list in the modal
                    $('#changeManagerModal').show(); // Show the modal for manager transfer
                } else {
                    // No employees under this manager
                    alert('This manager has no employees to transfer.');
                    $('#activeStatus').val('active'); // Keep the status active
                }
            },
            error: function() {
                console.log("Error fetching employees under manager.");
            }
        });
    }

    // Populate the employee list in the modal
    function populateEmployeeList(employees,editedUserId) {
        var employeeListHTML = "<option value='' selected>Select Manager</option>";
        Object.keys(employees).forEach(function(employeeKey) {
    	//console.log("function call",employees);
            var employee = employees[employeeKey]; // Access the actual employee object
            if (employee["empType"] === "manager" && editedUserId!= employeeKey) {
                console.log("Checking employee for circular check:", employee);
                // Prevent circular relationships like the "Assign Manager" dropdown
                var isCircular = checkCircularRelationship(usersList, $('#empid').val(), employeeKey);
                if (!isCircular) {
                    employeeListHTML += "<option value='" + employeeKey + "'>";
                    employeeListHTML += employee.name + " (" + employeeKey + ")";
                    employeeListHTML += "</option>";
                }
            }
        });
        employeeListHTML += "</select>";
        $('select#newManager').html(employeeListHTML);
    }

    // Modal buttons
    $('#cancelChange').click(function() {
        $('#changeManagerModal').hide();
        $('#activeStatus').val('active'); // Reset status to active if cancelled
    });

    $('#confirmChange').click(function() {
        var newManagerId = $('#newManager').val();

        if (!newManagerId) {
            alert('Please select a new manager.');
            return;
        }

        $.ajax({
            url: 'UpdateManagerForEmployeesServlet',
            type: 'POST',
            data: {
                managerId: newManagerId,
                employees: JSON.stringify(managedEmployees)
            },
            success: function(response) {
                if (response.success) {
                    alert('Manager updated successfully for the employees.');
                    $('#changeManagerModal').hide();
                    // Update the status to inactive after successful reassignment
                    updateUserStatusToInactive();
                } else {
                    alert('Error updating manager.');
                }
            },
            error: function() {
                alert('An error occurred. Please try again.');
            }
        });
    });

    // Update the user status to inactive
    function updateUserStatusToInactive() {
        var formData = $('#editUserForm').serialize();
        
        $.ajax({
            url: 'editUserServlet',
            method: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    alert("User status updated to inactive.");
                    window.location.href = response.redirectURL; // Redirect after successful update
                } else {
                    $('#msg_para').html('<p style="color: red;">' + response.message + '</p>');
                }
            },
            error: function() {
                $('#msg_para').html('<p style="color: red;">An error occurred. Please try again later.</p>');
            }
        });
    }

    // Handle form submission for user update
    $('#editUserForm').submit(function(event) {
        event.preventDefault(); // Prevent the default form submission

        var formData = $(this).serialize();

        if ($('#activeStatus').val() === "inactive" && $('#addAsManager').val() === "yes" && managedEmployees.length > 0) {
            // If the manager has employees to transfer, proceed with the reassignment
            $('#changeManagerModal').show();
        } else {
            $.ajax({
                url: 'editUserServlet',
                method: 'POST',
                data: formData,
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert("User updated successfully.");
                        window.location.href = response.redirectURL; // Redirect after successful update
                    } else {
                        $('#msg_para').html('<p style="color: red;">' + response.message + '</p>');
                    }
                },
                error: function() {
                    $('#msg_para').html('<p style="color: red;">An error occurred. Please try again later.</p>');
                }
            });
        }
    });
});

</script>


</body>
</html>
