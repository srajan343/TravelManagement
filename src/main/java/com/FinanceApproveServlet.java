package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class FinanceApproveServlet
 */
@WebServlet(urlPatterns = {"/finance/FinanceApproveServlet","/admin/FinanceApproveServlet","/manager/FinanceApproveServlet"})
public class FinanceApproveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String empId = request.getParameter("empId");
		    String key = request.getParameter("key");
		    String status = request.getParameter("status");
		    String remarks = request.getParameter("remarks");
		    String usr = request.getParameter("user");
		    String timeStamp = request.getParameter("timeStamp");
		    System.out.println("timeStamp"+timeStamp);

		    // Log the inputs (you can remove or modify this based on actual logging implementation)
		    log(key);
		    log(empId);
		    log(status);
		    log(remarks);

		    // Read the existing users JSON
		    JSONObject users = JSONUtils.readAppJSONFile();

		    // Check if the user with the given key exists
		    if (users.containsKey(key)) {
		        System.out.println("hi inside condition " + key +" "+status);

		        // Get the user object
		        JSONObject user = (JSONObject) users.get(key);
		        System.out.println("users: " + users);
		        System.out.println("user: " + user);

		        // Only update the finance_status field
		        
		        if(usr.equals("finance")) {
		        	 if ("settled".equals(status)) {
				            user.put("finance_status", "settled");
				            user.put("finResponseOn", timeStamp);
				        } else {
				            user.put("finance_status", "rejected");
				            user.put("finResponseOn", timeStamp);				            
				            user.put("remarks", remarks);
				        }
		        }else if(usr.equals("admin")) {
		        	 if ("approved".equals(status)) {
				            user.put("admin_status", "approved");
				            user.put("adminResponseOn", timeStamp);
				        } else {
				            user.put("admin_status", "rejected");
				            user.put("adminResponseOn", timeStamp);
				            user.put("remarks", remarks);
				        }
		        }
		        else if(usr.equals("manager")) {
		        	 if ("approved".equals(status)) {
				            user.put("manager_status", "approved");
				            user.put("manResponseOn", timeStamp);
				        } else {
				            user.put("manager_status", "rejected");
				            user.put("manResponseOn", timeStamp);
				            user.put("finance_status", "rejected");
				            user.put("admin_status", "rejected");
				            user.put("remarks", remarks);
				        }
		        }
		       

		        // Save the updated users JSON back to the file
		        users.put(key, user); // Update the user data in the users JSON object
		        JSONUtils.writeAppJSONFile(users); // Save the updated JSON to the file
		    } else {
		        // If the user with the given key is not found
		        System.out.println("User not found with key: " + key);
		    }

		
		
		
	}

}
