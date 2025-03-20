package com;

import java.io.BufferedReader;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet implementation class testAdminDash
 */
@WebServlet("/testAdminDash")
public class testAdminDash extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Read application.json file
//	        JSONObject applications = JSONUtils.readAppJSONFile();
//
//	        // Pass the data to the JSP
//	        request.setAttribute("applications", applications);
//	        
//	        // Forward to the JSP
//	        request.getRequestDispatcher("/admin/adminDashboard2.jsp").forward(request, response);
//	        
	        JSONObject applications = JSONUtils.readAppJSONFile();
	        System.out.println("app: "+applications);

	        // Set response type to JSON
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");

	        // Write JSON data to response
	        response.getWriter().write(applications.toJSONString());
	    }
	 
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    
		    JSONObject responseJson = new JSONObject();

		    try {
		        // Logic to update application.json
		        StringBuilder requestBody = new StringBuilder();
		        BufferedReader reader = request.getReader();
		        String line;
		        while ((line = reader.readLine()) != null) {
		            requestBody.append(line);
		        }

		        JSONObject requestData = (JSONObject) new JSONParser().parse(requestBody.toString());
		        String appNo = (String) requestData.get("appNo");
		        String status = (String) requestData.get("status");
		        String reason = (String) requestData.get("reason");

		        // Simulate updating application.json
		        JSONObject applications = JSONUtils.readAppJSONFile1();
		        JSONObject appDetails = (JSONObject) applications.get(appNo);
		        if (appDetails != null) {
		            appDetails.put("admin_status", status);
		            if ("reject".equals(status)) {
		                appDetails.put("reason", reason);
		            }
		            JSONUtils.writeAppJSONFile(applications);
		            responseJson.put("success", true);
		        } else {
		            responseJson.put("success", false);
		            responseJson.put("message", "Application not found.");
		        }
		    } catch (Exception e) {
		        responseJson.put("success", false);
		        responseJson.put("message", "Error processing request.");
		        e.printStackTrace();
		    }

		    response.getWriter().write(responseJson.toJSONString());
		}
}
