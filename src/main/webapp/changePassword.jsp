<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>

<script>
        // Redirect to the login page after 2 seconds
        function redirectToLogin() {
            setTimeout(function () {
                window.location.href = "index.jsp";
            }, 2000); // 2000ms = 2 seconds
        }
    </script>
    
<style>

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
    background: #007BFF;
}




</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // Handle form submission with AJAX
    $('#changePwdForm').submit(function(event) {
        event.preventDefault(); // Prevent the form from submitting normally

        // Get form data
        var formData = $(this).serialize(); // Serialize the form data

        // Send AJAX request
        $.ajax({
            url: 'changePasswordServlet', // Target servlet
            type: 'POST',
            data: formData, // Send form data
            dataType: 'json', // Expecting JSON response
            success: function(response) {
                if (response.success) {
                    $('#msg_para').text(response.message).css("color", "green");
                    setTimeout(function() {
                        window.location.href = response.redirectURL;
                    }, 2000);
                } else {
                    $('#msg_para').text(response.message).css("color", "red");
                    
                }
            },
            error: function() {
                $('#msg_para').text('An error occurred. Please try again later.').css("color", "red");
                //window.location.href = './index.jsp';
            }
        });
    });
});
</script>

</head>
<body>
	<%@include file="/common/header.jsp" %>
	
	<% String user = (String)session.getAttribute("empId");%>
	 <div class="container">
        <div class="login-box">
            <h2 class="login-title">CHANGE PASSWORD</h2>
            
            <form class="login-form" id="changePwdForm" >
				 
				 	<div class="form-group">
		        		<label for="oldPwd">Old Password: </label>
		            	<input type="password" id="oldPwd" name="oldPwd" placeholder="Old Password" required><br>
		        	</div>
		        	<div class="form-group">
		        		<label for="newPwd">New Password: </label>
		            	<input type="password" id="newPwd" name="newPwd" placeholder="New Password" required><br>
		        	</div>
		        	
		        	<div class="form-group">
		        		<label for="cfPwd">Confirm Password: </label>
		            	<input type="password" id="cfPwd" name="cfPwd" placeholder="Confirm Password" required><br>
		        	</div>
		             
		            
		                <p id="msg_para"></p>
		            
		            <button type="submit" class="login-button">UPDATE</button>
		        
			</form>
            
            
         <!--    <form class="login-form" id="changePwdForm" action="changePasswordServlet" method="post">
				 <% 
		            // Check for success or error messages
		            String successMessage = (String) session.getAttribute("success");
		            String errorMessage = (String) session.getAttribute("Message");
		            
		            if (successMessage != null) { 
		        %>
		            <p style="color: green;"><%= successMessage %></p>
		            <script>
		                // Redirect after showing the success message
		                redirectToLogin();
		            </script>
		            <% 
		                // Remove the success message from session
		                session.removeAttribute("success");
		            } else { 
		        %>
		        	<div class="form-group">
		        		<label for="newPwd">New Password: </label>
		            	<input type="password" id="newPwd" name="newPwd" placeholder="New Password" required><br>
		        	</div>
		        	
		        	<div class="form-group">
		        		<label for="cfPwd">Confirm Password: </label>
		            	<input type="password" id="cfPwd" name="cfPwd" placeholder="Confirm Password" required><br>
		        	</div>
		             
		            <% 
		                // Display error message if present
		                if (errorMessage != null) { 
		            %>
		                <p style="color: red; margin:0px;" id="msg_para"><%= errorMessage %></p>
		            <% 
		                    session.removeAttribute("Message"); 
		                } 
		            %>
		            
		            <button type="submit" class="login-button">UPDATE</button>
		        <% } %>
			</form> -->
            
        </div>
     </div>
	
	
	<%@include file="/common/footer.jsp" %>
</body>
</html>