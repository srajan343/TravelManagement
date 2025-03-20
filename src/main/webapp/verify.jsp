<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
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

.container {
    
    max-width: 400px;
    text-align: center;
    margin:auto;
    position: relative;
    top:50px
  
}

.login-box {
    background: white;
    border-radius: 10px;
    padding: 20px 30px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.login-title {
    font-size: 1.8rem;
    margin-bottom: 20px;
    color: #333;
}

.login-form {
    display: flex;
    flex-direction: column;
    gap: 10px;
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

input {
    width: 100%;
    padding: 10px;
    font-size: 1rem;
    border: 1px solid #ccc;
    border-radius: 15px;
    outline: none;
}

input:focus {
    border-color: #007BFF;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
}

#msg_para{
margin:0px;
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



</style>

<!--  <script>

$(document).ready(function() {
    // Handle form submission with AJAX
    $('#verifyForm').submit(function(event) {
        event.preventDefault(); // Prevent the form from submitting normally

        // Get form data
        var formData = $(this).serialize(); // Serialize the form data

        // Send AJAX request
        $.ajax({
            url: 'VerifyOTPServlet', // Target servlet
            type: 'POST',
            data: formData, // Send form data
            dataType: 'json', // Expecting JSON response
            success: function(response) {
                // Check if the response is success or failure
                if (response.success) {
                    // Display success message
                    $('#msg_para').text( response.message).css("color","green");
                    // Optionally, redirect to another page (e.g., OTP verification page)
                    setTimeout(function() {
                    	
                        window.location.href = 'changePassword.jsp'; // Redirect to verify OTP page
                    }, 1000);
                } else {
                    // Display error message
                    $('#msg_para').text( response.message).css("color","red");
                }
            },
            error: function() {
                $('#msg_para').text('An error occurred. Please try again later.');
            }
        });
    });
});


</script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // Handle form submission with AJAX
    $('#verifyForm').submit(function(event) {
        event.preventDefault(); // Prevent the form from submitting normally

        // Get form data
        var formData = $(this).serialize(); // Serialize the form data

        // Send AJAX request
        $.ajax({
            url: 'VerifyOTPServlet', // Target servlet
            type: 'POST',
            data: formData, // Send form data
            dataType: 'json', // Expecting JSON response
            success: function(response) {
                if (response.success) {
                    $('#msg_para').text(response.message).css("color", "green");
                    setTimeout(function() {
                        window.location.href = 'changePassword.jsp';
                    }, 1000);
                } else {
                    $('#msg_para').text(response.message).css("color", "red");
                }
            },
            error: function() {
                $('#msg_para').text('An error occurred. Please try again later.').css("color", "red");
            }
        });
    });
});
</script>


</head>
<body>
    <%@include file="/common/header.jsp" %>
    <%HttpSession sessoin = request.getSession();
    	String emp_id = (String)session.getAttribute("emp_id");
    	
    	if(emp_id==null){
    		response.sendRedirect("./forgetPassword.jsp");
    		return;
    	}
    
    %>
    <div class="container">
    <div class="login-box">
        <h2 class="login-title">FORGOT PASSWORD</h2>
        <form class="login-form" id="verifyForm" action="VerifyOTPServlet" method="post">
            <div class="form-group">
                <label for="emp_id">Employee ID:</label>
                <input type="text" name="emp_id" hidden value="<%= emp_id %>">
                <input type="text" id="emp_id" name="emp_id" value="<%= emp_id %>" disabled><br>
            </div>
            <div class="form-group">
                <label for="otp">OTP:</label>
                <input type="text" name="otp" placeholder="Enter your otp" required><br>
            </div>
            <p id="msg_para"></p>
            <button type="submit" class="login-button">VERIFY OTP</button>
        </form>
    </div>
</div>

   
    
    <%@include file="/common/footer.jsp" %>
</body>
</html>
