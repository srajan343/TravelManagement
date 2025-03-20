<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
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
    padding: 10px 30px;
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

.forgot-password {
    text-align: right;
    
}

.forgot-password p{
margin:0px;
display:inline;
}
#forgot_para{
float:right;
}
#msg_para{
float:left;
}
.forgot-password a {
    font-size: 0.9rem;
    color: #A0AEC0;
    text-decoration: none;
}

.forgot-password a:hover {
    text-decoration: underline;
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
    margin-top: 10px;
}

.signup-link a {
    color:#4FD1C5;;
    text-decoration: none;
}

.signup-link a:hover {
    text-decoration: underline;
}


</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        $('#loginForm').submit(function (e) {
            e.preventDefault(); // Prevent default form submission

            const formData = $(this).serialize(); // Serialize form data

            $.ajax({
                url: 'LoginServlet',
                type: 'POST',
                data: formData,
                success: function (response) {
                    // Parse the JSON response from the servlet
                    const result = response;

                    if (result.success) {
                        // If login is successful, redirect to the dashboard
                        
                        window.location.href = result.redirectURL;
                    } else {
                        // If login failed, show the error message
                        $('#msg_para').css('color', 'red').text(result.message);
                    }
                },
                error: function () {
                    // Handle errors if any during AJAX request
                    $('#msg_para').css('color', 'red').text("An error occurred. Please try again.");
                }
            });
        });
    });
</script>


</head>
<body>
	<%@include file="/common/header.jsp" %>
	 
	 
	 <!-- TODO: need to forward to verify the user first after login who is logged in kinda thing in the action when submitted-->
	 
	 <div class="container">
        <div class="login-box">
            <h2 class="login-title">LOGIN</h2>
			<form id="loginForm" class="login-form" action="LoginServlet" method="post">
			    <div class="form-group">
			        <label for="emp_id">Employee ID:</label>
			        <input
			        id = "emp_id"
			            type="text"
			            name="emp_id"
			            placeholder="Enter your EmpId"
			            value="<%= request.getAttribute("emp_id") != null ? request.getAttribute("emp_id") : "" %>"
			            required
			        >
			        <br>
			    </div>
			    <div class="form-group">
			        <label for="password">Password:</label>
			        <input
			        id="password"
			            type="password"
			            name="password"
			            placeholder="Enter your password"
			            required
			        >
			        <br>
			    </div>
			    <div class="forgot-password">
			        <p style="color:red; margin:0px;" id="msg_para">
			            
			        </p>
			        <p id="forgot_para">
			            <a href="forgetPassword.jsp">Forgot Password?</a>
			        </p>
			    </div>
			    <button type="submit" class="login-button">LOGIN</button>
			    <div class="signup-link">
			        Don't have an account? <a href="register.jsp">Sign Up</a>
			    </div>
			</form>

        </div>
     </div>
	
	<%@include file="/common/footer.jsp" %>
</body>
</html>