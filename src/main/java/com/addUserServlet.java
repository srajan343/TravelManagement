package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class addUserServlet
 */
@WebServlet(urlPatterns = {"/addUserServlet","/admin/addUserServlet"})
public class addUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String empId = request.getParameter("empid");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String assign_manager = request.getParameter("assign-manager");
        String location = request.getParameter("location");
        String addAsManager = request.getParameter("addAsManager");
        String empName = request.getParameter("name");
        
        System.out.println("name: "+empName+"assign_manager:"+assign_manager);
        
        //setting the emptype
        String empType = "";
        if(addAsManager.equals("yes")) {
        	empType="manager";
        	System.out.println("empType1::"+empType);
        }
        else {
        	empType = "user";
        	System.out.println("empType2::"+empType);
        }
        
        System.out.println("empType3::"+empType);
        
        //setting the manager name
        
        
        
        
        JSONObject result = new JSONObject();
        
        JSONObject users = JSONUtils.readJSONFile();
        
        if (users.containsKey(empId)) {
            result.put("success", false);
            result.put("message", "User already exists!");
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
        
        String manager_name = "";
        if(users.containsKey(assign_manager)) {
        	JSONObject user = (JSONObject) users.get(assign_manager);
        	manager_name = (String) user.get("name");
        	System.out.println("manager_name:::"+manager_name);
        }
        
        
        JSONObject newUser = new JSONObject();
        newUser.put("name", empName);
        newUser.put("email", email);
        newUser.put("password", password);
        newUser.put("location", location);
        newUser.put("empType", empType);
        newUser.put("manager_name", manager_name);
        newUser.put("manager_id", assign_manager);
        newUser.put("app_no", "");
        newUser.put("profileImg","static/profile-img/default-img.png");
        newUser.put("active", "yes");

        users.put(empId, newUser); // Add new user to the data
        JSONUtils.writeJSONFile(users); 
        
        
        
        String subject = empName+" Your account has been created!";
       String content ="<html><body><h2>The account details are below: <h3>Employee Id: "+ empId +"<br> Password: "+ password+" </h3> <br><h4> Please login and change the password.<br> Thank You</h4></body></html>";
        
        MailUtil.sendMailAsync(email, subject, content);
       // if(mailStatus) {
        //	result.put("mail", "Mail has been sent");
       // }else {
        //	result.put("mail", "Mail has not been sent");
       // }
        
        result.put("success", true);
        result.put("redirectURL", "addUser.jsp");
        response.setContentType("application/json");
        response.getWriter().write(result.toJSONString());

	}

}
