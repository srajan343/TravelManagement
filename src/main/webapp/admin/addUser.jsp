<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Add User</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* General styles */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f0f0f0;
    background: linear-gradient(135deg, #007BFF, #00C6FF);
    color: #333;
    overflow: hidden;
    background-size: 100vw 100vh;
    background-repeat: no-repeat;
}

.containerDiv {
    width: 100%;
    display: flex;
    justify-content: center;
    /*align-items: center;*/
    flex-direction: column;
}

.form-container {
    background: rgba(255, 255, 255, 0.2);
    color:#fff;
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
    width: 100%; /* default full width */
    margin-bottom: 20px;
}

.form-group label {
    /*display: block;*/
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
    text-align: center;
    width: 80px;
    /*margin-bottom: 20px;  Space between button and form */
}

.back-button:hover {
    background-color: #0056b3;
}

/* Media Queries for Responsiveness */
@media (min-width: 600px) {
    .form-group {
        width: 45%; /* 2 columns on larger screens */
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
        width: 100%; /* Full width on smaller screens */
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
        font-size: 12px; /* Smaller text on very small screens */
    }
}
</style>
</head>
<body>
<%@include file="../common/side_nav.jsp"%>
<div class="main-content">
    <div class="containerDiv">
        <!-- Back Button -->
        <button class="back-button" onclick="window.location.href='adminUsers.jsp';">Back</button>

        <!-- Form -->
        	<p id="msg_para"></p>
        <form class="form-container" id="addUserForm">
        	
            <div class="form-group">
                <label for="empid">Employee ID</label>
                <input type="text" id="empid" name="empid" placeholder="Enter Employee ID" required>

                <label for="email">Email ID</label>
                <input type="email" id="email" name="email" placeholder="Enter Email ID" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter Password" required>

                <label for="assign-manager">Assign Manager</label>
                <select id="assign-manager" name="assign-manager" required></select>
            </div>

            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter Name" required>

                <label for="location">Location</label>
                <select id="location" name="location" required>
                    <option value="" selected >Select your location</option>
					        <option value="Bangalore">Bangalore</option>
					        <option value="Chennai">Chennai</option>
					        <option value="Pune">Pune</option>
					        <option value="Coimbatore">Coimbatore</option>
					        <option value="Gurgaon">Gurgaon</option>
                </select>

                <label for="assign-as-manager">Add as Manager</label>
                <select id="addAsManager" name="addAsManager" required>
                    
                    <option value="no">No</option>
                    <option value="yes">Yes</option>
                </select>

                <button type="submit" style="background-color:#4FD1C5">Add</button>
                
            </div>
        </form>
    </div>
</div>

<script>
$(document).ready(function() {
    populateManagerOptions();

    function populateManagerOptions() {
        $.ajax({
            url: "ListUserServlet",
            type: "GET",
            dataType: "json",
            success: function(users) {
                var options = "<option value=''>Select Manager</option>";
                console.log("users:", users);
                Object.keys(users).forEach((key) => {
                    const item = users[key];
                    console.log("users::", users, "key::", key);

                    if (item["empType"] == "manager") {
                        options += "<option value='" + key + "'>" + item["name"] + "</option>";
                    }
                });
                //options += "<option value=''>-- None --</option>";
                $("select#assign-manager").html(options);
            },

            error: function() {
                console.log("error");
            }
        });

        // Add the change event listener to the select element
        $("select#assign-manager").on("change", function() {
            var selectedManagerId = $(this).val(); // Get the selected value
            console.log("Selected Manager ID:", selectedManagerId);
        });
    }

    $('form').submit(function(event) {
        event.preventDefault(); // Prevent the form from submitting normally

        // Get form data
        var formData = $(this).serialize();
        console.log("formData", formData);

        // Send AJAX request
        $.ajax({
            url: 'addUserServlet', // Target servlet
            type: 'POST',
            data: formData, // Send form data
            dataType: 'json', // Expecting JSON response
            success: function(response) {
                if (response.success) {
                    console.log("response success");
                    console.log("response msg", response.message);
                    
                    alert("User added successfully & mail has been sent");
                    window.location.href = response.redirectURL;
                } else {
                	alert("User already exists!!");
                   // $('#msg_para').html('<p style="color: red;">' + response.message + '</p>');
                }
            },
            error: function() {
                $('#msg_para').html('<p style="color: red;">An error occurred. Please try again later.</p>');
            }
        });
    });
});
</script>

</body>
</html>
