<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
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
    gap: 15px;
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
text-align:center;
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



        .otp-input {
            width: 40px;
            height: 50px;
            font-size: 24px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .otp-input:focus {
            border-color: #007bff;
            outline: none;
        }
	input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button {
  		-webkit-appearance: none;
  			margin: 0;
	}
	

</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <script>
    $(document).ready(function() {
        // Handle form submission with AJAX
        $('#forgotPasswordForm').submit(function(event) {
            event.preventDefault(); // Prevent the form from submitting normally
		
            // Get form data
            var formData = $(this).serialize(); // Serialize the form data

            // Send AJAX request
            $.ajax({
                url: 'SendOTPServlet', // Target servlet
                type: 'POST',
                data: formData, // Send form data
                dataType: 'json', // Expecting JSON response
                success: function(response) {
                    // Check if the response is success or failure
                    if (response.success) {
                        // Display success message
                        $('#msg_para').text(response.message).css("color","green");
                        // Optionally, redirect to another page (e.g., OTP verification page)
                        setTimeout(function() {
                        	
                            window.location.href = 'verify.jsp'; // Redirect to verify OTP page
                        }, 1000);
                    } else {
                        // Display error message
                        $('#msg_para').text(response.message).css("color","red");
                    }
                },
                error: function() {
                    $('#msg_para').html('<p style="color: red; margin:0px">An error occurred. Please try again later.</p>');
                }
            });
        });
    });
</script> -->
<script>






$(document).ready(function() {
	
	function start() {
		$("#changePwdForm").hide();
		$('#changepwd-title').hide();
		$("#verifyOTPForm").hide();
		//
		
	}
	
	start();
    // Handle SEND OTP form submission
    $('#sendOTPForm').submit(function(event) {
        event.preventDefault(); // Prevent normal form submission
        
        const formData = $(this).serialize(); // Serialize form data
        
        $.ajax({
            url: 'SendOTPServlet', // Call SendOTPServlet
            type: 'POST',
            data: formData,
            dataType: 'json', // Expect JSON response
            success: function(response) {
                if (response.success) {
                    // Display success message
                    $('#sendOTP_msg').text(response.message).css('color', 'green');
                    
                    // Hide SEND OTP form and show VERIFY OTP form
                    alert("OTP has been sent to your Registred Email");
                    $('#sendOTPForm').hide();
                    $('#verifyOTPForm').show();
                    $('#changepwd-title').hide();
                    $('#changePwdForm').hide();

                    // Fill the emp_id in VERIFY OTP form
                    $('#emp_id_disabled').val($('#emp_id').val());
                    $('#emp_id_hidden').val($('#emp_id').val());
                } else {
                    // Display error message
                    $('#sendOTP_msg').text(response.message).css('color', 'red');
                }
            },
            error: function() {
                $('#sendOTP_msg').text('An error occurred. Please try again later.').css('color', 'red');
            }
        });
    });

    // Handle VERIFY OTP form submission
    $('#verifyOTPForm').submit(function(event) {
        event.preventDefault(); // Prevent normal form submission

        const formData = $(this).serialize(); // Serialize form data

        $.ajax({
            url: 'VerifyOTPServlet', // Call VerifyOTPServlet
            type: 'POST',
            data: formData,
            dataType: 'json', // Expect JSON response
            success: function(response) {
                if (response.success) {
                    // Display success message
                    $('#verifyOTP_msg').text(response.message).css('color', 'green');
                    $('#sendOTPForm').hide();
                    $('#forgot-title').hide();
                    $('#verifyOTPForm').hide();
                    $('#changepwd-title').show();
                    $('#changePwdForm').show();
                    // Redirect to changePassword.jsp after OTP verification
                    //setTimeout(function() {
                     //   window.location.href = 'changePassword.jsp';
                   // }, 1000);
                    $
                } else {
                    // Display error message
                    $('#verifyOTP_msg').text(response.message).css('color', 'red');
                }
            },
            error: function() {
                $('#verifyOTP_msg').text('An error occurred. Please try again later.').css('color', 'red');
            }
        });
    });
    
    $('#changePwdForm').submit(function(event) {
        event.preventDefault(); // Prevent normal form submission

        const formData = $(this).serialize(); // Serialize form data

        $.ajax({
            url: 'changePasswordServlet', // Call VerifyOTPServlet
            type: 'POST',
            data: formData,
            dataType: 'json', // Expect JSON response
            success: function(response) {
                if (response.success) {
                    // Display success message
                    $('#changePwd_msg').text(response.message).css('color', 'green');
                   
                    // Redirect to changePassword.jsp after OTP verification
                    setTimeout(function() {
                       window.location.href = 'index.jsp';
                    }, 2000);
                    $
                } else {
                    // Display error message
                    $('#changePwd_msg').text(response.message).css('color', 'red');
                }
            },
            error: function() {
                $('#changePwd_msg').text('An error occurred. Please try again later.').css('color', 'red');
            }
        });
    });
    
});
</script>
</head>
<body>
	<%@include file="/common/header.jsp" %>
	
	
	<!-- <div class="container">
        <div class="login-box">
            <h2 class="login-title">FORGOT PASSWORD</h2>
            <form class="login-form" action="SendOTPServlet" method="post">
                <div class="form-group">
                    <label for="emp_id">Employee ID:</label><input type="text" name="emp_id"  placeholder="Enter your EmpId" required><br>
                </div>
               
					<% String msg = session.getAttribute("Message") != null ? (String) session.getAttribute("Message") : ""; %>
					
					<p style="color:red;" id="msg_para"><%out.println(msg);%></p>
					<% session.removeAttribute("Message"); %>
              
                <button type="submit" class="login-button">SEND OTP</button>
                
            </form>
        </div>
     </div>  -->
     
     <!-- working thing down here -->
     
     <!-- <div class="container">
        <div class="login-box">
            <h2 class="login-title">FORGOT PASSWORD</h2>
            <form class="login-form" id="forgotPasswordForm" action="SendOTPServlet" method="post">
                <div class="form-group">
                    <label for="emp_id">Employee ID:</label>
                    <input type="text" name="emp_id" placeholder="Enter your EmpId" required><br>
                </div>
                <p  id="msg_para"></p> 
                <button type="submit" id="login-button" class="login-button">SEND OTP</button>
            </form>
        </div>
    </div> -->
	
	
	<!-- testing -->
	<% String user = (String)session.getAttribute("empId");%>
	
			<div class="container">
		    <div class="login-box">
		        <h2 class="login-title" id="forgot-title">FORGOT PASSWORD</h2>
		        
		        <!-- SEND OTP FORM -->
		        <form class="login-form" id="sendOTPForm" action="SendOTPServlet" method="post">
		            <div class="form-group">
		                <label for="emp_id">Employee ID:</label>
		                <input type="text" id="emp_id" name="emp_id" placeholder="Enter your EmpId" required><br>
		            </div>
		            <p id="sendOTP_msg" style="margin:0px"></p> <!-- Display messages here -->
		            <button type="submit" id="sendOTPButton" class="login-button">SEND OTP</button>
		        </form>
		        
		        <!-- VERIFY OTP FORM -->
		        <form class="login-form" id="verifyOTPForm" action="VerifyOTPServlet" method="post" style="display: none;">
		            <div class="form-group">
		                <label for="emp_id_disabled">Employee ID:</label>
		                <input type="text" id="emp_id_disabled" name="emp_id_disabled" disabled>
		                <input type="hidden" id="emp_id_hidden" name="emp_id"> <!-- Hidden field for sending emp_id -->
		            </div>
		            <div class="form-group otp-container">
		                <label for="otp">OTP:</label>
		                <input type="number" id="otp" name="otp" maxlength="6" placeholder="Enter your OTP" required><br> 
		               <!--  <input type="number" maxlength="1" class="otp-input" id="otp-1">
					    <input type="number" maxlength="1" class="otp-input" id="otp-2">
					    <input type="number" maxlength="1" class="otp-input" id="otp-3">
					    <input type="number" maxlength="1" class="otp-input" id="otp-4">
					    <input type="number" maxlength="1" class="otp-input" id="otp-5">
					    <input type="number" maxlength="1" class="otp-input" id="otp-6">  -->
		            </div>
		            <p id="verifyOTP_msg" style="margin:0px"></p> <!-- Display messages here -->
		            <button type="submit" id="verifyOTPButton" class="login-button">VERIFY OTP</button>
		        </form>
		        
		        <!-- ChangePassword -->
		        <h2 class="login-title" id="changepwd-title">CHANGE PASSWORD</h2>
		        <form class="login-form" id="changePwdForm" action="changePasswordServlet" method="post">
				 
				
		        	<div class="form-group">
		        		<label for="newPwd">New Password: </label>
		            	<input type="password" id="newPwd" name="newPwd" placeholder="New Password" required><br>
		        	</div>
		        	
		        	<div class="form-group">
		        		<label for="cfPwd">Confirm Password: </label>
		            	<input type="password" id="cfPwd" name="cfPwd" placeholder="Confirm Password" required><br>
		        	</div>
		             
		            
		                <p id="changePwd_msg" style="margin:0px"></p>
		            
		            <button type="submit" class="login-button">UPDATE</button>
		        
			</form>
		        
		    </div>
		</div>
	
	<%@include file="/common/footer.jsp" %>

</body>
</html>