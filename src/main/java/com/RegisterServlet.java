package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String empName = request.getParameter("emp_name");
        String empId = request.getParameter("emp_id");
        String email = request.getParameter("email");
        String location = request.getParameter("location");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
       

        HttpSession session = request.getSession();

        // Read the JSON file to get existing users
        JSONObject users = JSONUtils.readJSONFile();

        JSONObject result = new JSONObject();
        // Checking if emp_id already exists
        if (users.containsKey(empId)) {
            result.put("success", false);
            result.put("message", "User already exists!");
            response.setContentType("application/json");
            response.getWriter().write(result.toJSONString());
            return;
        }

        if (!password.equals(confirmPassword)) {
            result.put("success", false);
            result.put("message", "Password Mismatch.");
            response.setContentType("application/json");
            response.getWriter().write(result.toJSONString());
            return;
        }

        String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        if (!password.matches(passwordRegex)) {
            result.put("success", false);
            result.put("message", "Password must be at least 8 characters and include upper, lowercase, digit, and special character.");
            response.setContentType("application/json");
            response.getWriter().write(result.toJSONString());
            return;
        }

        // Add new user to the JSON object
        JSONObject newUser = new JSONObject();
        newUser.put("name", empName);
        newUser.put("email", email);
        newUser.put("password", password);
        newUser.put("location", location);
        newUser.put("isManager", false);
        newUser.put("manager_name", "");
        newUser.put("manager_id", "");
        newUser.put("app_no", "");
        newUser.put("empType", "user");
        newUser.put("profileImg","static/profile-img/default-img.png");
        newUser.put("active", "yes");

        users.put(empId, newUser); // Add new user to the data
        JSONUtils.writeJSONFile(users); // Save the updated data

        
       String subject = "Login Credentials for TMS ";
       String content = "<html><body><h2>Dear Applicant, "+empName +" </h2><br><h2> Your Login Credential for TMS is</h2> <br><h2> USERNAME: <strong>"+empId+"</strong> </h2><h2>PASSWORD: <strong>"+password+"</strong></h2><br><h3>Registration is complete, Login to your account Thank You. </h3></body></html>\";";
        
        
//        boolean sentMail = MailUtil.sendMail(email, subject, content);
//        if(sentMail) {
//        	result.put("mailSent", true);
//        }else {
//        	result.put("mailSent",false);
//        }
       MailUtil.sendMailAsync(email, subject, content) ;
       
        // Successful registration response
        result.put("success", true);
        result.put("message", "Registration successful! Redirecting to login...");
        response.setContentType("application/json");
        response.getWriter().write(result.toJSONString());
    }

	}