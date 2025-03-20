<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration</title>
<style>
	
/* styles.css */
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #007BFF, #00C6FF);
    color: #333;
    /* display: flex;
    justify-content: center;
    align-items: center; */
    /* height: 100vh; */
   
    overflow: hidden;
    background-image: url(static/image/back-img.jpg);
    background-size: 100vw 100vh;
    background-repeat: no-repeat;
}

/* css for the location*/

/*.styled-select {
    width: 100%;
    padding: 10px;
    font-size: 1rem;
    border: 1px solid #ccc;
    border-radius: 15px;
    outline: none;
    background: white;
    /*appearance: ; /* Removes default arrow in some browsers 
    -moz-appearance: none;
    -webkit-appearance: none;
    background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"%3E%3Cpath fill="%23333" d="M2 0L0 2h4z"/%3E%3C/svg%3E');
    background-repeat: no-repeat;
    background-position: right 10px center;
    background-size: 10px; 
}

.styled-select:focus {
    border-color: #007BFF;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
}

.styled-select option {
    color: #555;
    background: white;
}
 */

.container {
    
    max-width: 400px;
    text-align: center;
    margin:auto;
    position: relative;
    top:10px;
    
    
  
}


.login-box {
    background: white;
    border-radius: 10px;
    padding: 10px 30px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.login-title {
    
    margin-bottom: 20px;
    color: #333;
}

.login-form {
    display: flex;
    flex-direction: column;
    gap: 2px;
}

.form-group {
    text-align: left;
    width:94%;
    
}

label {
    display: block;
    font-size: 0.9rem;
    margin-bottom: 5px;
    color: #555;
}

select{
width:340px !important;

}
input , select{
    width: 100%;
    padding: 10px;
    font-size: 1rem;
    border: 1px solid #ccc;
    border-radius: 15px;
    outline: none;
}

input:focus , select:focus {
    border-color: #007BFF;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
}

.forgot-password {
    text-align: right;
    
}


#forgot_para{
float:right;
}
#msg_para{
float:left;
font-size:small;
font-weight:bold;
}

.login-button {
    background: #4FD1C5;
    color: white;
    font-size: 1rem;
    padding: 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.login-button:hover {
    background: #0D92F4;
}

.signup-link {
    font-size: 0.9rem;
    
}
.signup-link p{
display:inline;
margin:1px;
}

.signup-link a {
    color:#4FD1C5;;
    text-decoration: none;
}

.signup-link a:hover {
    text-decoration: underline;
}


</style>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    // Handle form submission with AJAX
    $(document).ready(function() {
        $('form').submit(function(event) {
            event.preventDefault(); // Prevent the form from submitting normally

            // Get form data
            var formData = $(this).serialize();

            // Send AJAX request
            $.ajax({
                url: 'RegisterServlet', // Target servlet
                type: 'POST',
                data: formData, // Send form data
                dataType: 'json', // Expecting JSON response
                success: function(response) {
                    // Check if the response is a success or failure message
                    if (response.success) {
                        // Display success message
                        $('#msg_para').html('<p style="color: green;">' + response.message + '</p>');
                        // Redirect after a short delay (if needed)
                        setTimeout(function() {
                            window.location.href = 'index.jsp'; // Redirect to login page
                        }, 2000);
                    } else {
                        // Display error message
                        $('#msg_para').html('<p style="color: red;">' + response.message + '</p>');
                    }
                },
                error: function() {
                    $('#msg_para').html('<p style="color: red;">An error occurred. Please try again later.</p>');
                }
            });
        });
    });
</script>
</head>
<body>
	<%@include file="/common/header.jsp" %>	
	<div class="container">
        <div class="login-box">
            <h2 class="login-title">Registration</h2>
            <form class="login-form" id="registerForm" action="RegisterServlet" method="post">
                <div class="form-group">
                    <label for="emp_id">Employee ID:</label>
                    <input type="text" name="emp_id" placeholder="Enter your EmpId" required>
                </div>
                <div class="form-group">
                    <label for="emp_name">Name:</label>
                    <input type="text" name="emp_name" placeholder="Enter your Name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" name="email" placeholder="Enter your Email" required>
                </div>
                <div class="form-group">
                     <label for="location">Location:</label>
                   <!--  <input type="text" name="location" placeholder="Enter your Location" required> --> 
                    
					    <!-- <label for="location">Location:</label> -->
					    <select name="location" id="location" class="styled-select" required>
					        <option value="" selected >Select your location</option>
					        <option value="Bangalore">Bangalore</option>
					        <option value="Chennai">Chennai</option>
					        <option value="Pune">Pune</option>
					        <option value="Coimbatore">Coimbatore</option>
					        <option value="Gurgaon">Gurgaon</option>
					    </select> 
					</div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" name="password" id="pwd" placeholder="Enter your password" required>
                </div>
                <div class="form-group">
                    <label for="confirm_password">Confirm Password:</label>
                    <input type="password" id="cfpwd" name="confirm_password" placeholder="Enter your confirm password" required>
                </div>
                
                <div class="signup-link">
                    <p id="msg_para"></p> <!-- Display messages here -->
                    <p id="forgot_para">Have an account? <a href="index.jsp">Login</a></p>
                </div>

                <button type="submit" class="login-button">REGISTER</button>
            </form>
        </div>
        </div>
	<!-- 
	<form action="RegisterServlet" method="post">
	    <label for="emp_name">Employee Name:</label><input type="text" name="emp_name" required><br>
	    
	    <label for="emp_id">Employee ID:</label><input type="text" name="emp_id" required><br>
	    
	    <label for="email">Email:</label><input type="email" name="email" required><br>
	    
	    <label for="location">Location:</label>
	    <select name="location" required>
        <option value="" disabled selected>Select your location</option>
        <option value="Bangalore">Bangalore</option>
        <option value="Chennai">Chennai</option>
        <option value="Pune">Pune</option>
        <option value="Coimbatore">Coimbatore</option>
        <option value="Gurgaon">Gurgaon</option>
        
    </select><br>
	    
	    <label for="password">Password:</label><input type="password" name="password" required><br>
	    
	    <label for="confirm_password">Confirm Password:</label><input type="password" name="confirm_password" required><br>
	    
	    <button type="submit">Register</button>
	    
	    <p>Have an account? <a href="index.jsp">Login</a></p>
	</form>
	 -->
	<%@ include file="/common/footer.jsp" %>
	
</body>
</html>