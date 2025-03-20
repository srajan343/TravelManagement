package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class UpdateManagerForEmployeesServlet
 */

    
	@WebServlet(urlPatterns = {"/UpdateManagerForEmployeesServlet", "/admin/UpdateManagerForEmployeesServlet"})
	public class UpdateManagerForEmployeesServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        response.setContentType("application/json");
	        PrintWriter out = response.getWriter();

	        String newManagerId = request.getParameter("managerId");
	        String employeesData = request.getParameter("employees");

	        if (newManagerId == null || newManagerId.isEmpty() || employeesData == null || employeesData.isEmpty()) {
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            out.write("{\"message\": \"Manager ID and employee list are required\"}");
	            out.flush();
	            return;
	        }

	        try {
	            // Read the users JSON file
	            JSONObject usersJson = JSONUtils.readJSONFile();

	            // Parse the employeesData string
	            JSONParser parser = new JSONParser();
	            JSONObject employeesJson = (JSONObject) parser.parse(employeesData);

	            // Identify and update the previous manager's active status to "no"
	            for (Object key : employeesJson.keySet()) {
	                String employeeId = (String) key;
	                JSONObject employeeDetails = (JSONObject) usersJson.get(employeeId);

	                if (employeeDetails != null) {
	                    String previousManagerId = (String) employeeDetails.get("manager_id");
	                    if (previousManagerId != null) {
	                        JSONObject previousManager = (JSONObject) usersJson.get(previousManagerId);
	                        if (previousManager != null) {
	                            previousManager.put("active", "no");
	                            usersJson.put(previousManagerId, previousManager);
	                        }
	                    }
	                }
	            }

	            // Fetch the new manager's details
	            JSONObject newManager = (JSONObject) usersJson.get(newManagerId);
	            if (newManager == null) {
	                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	                out.write("{\"message\": \"New manager ID not found\"}");
	                out.flush();
	                return;
	            }
	            String newManagerName = (String) newManager.get("name");

	            // Traverse the employee list and update manager details
	            for (Object key : employeesJson.keySet()) {
	                String employeeId = (String) key;
	                JSONObject employeeDetails = (JSONObject) employeesJson.get(employeeId);

	                // Update manager_id and manager_name for the employee
	                employeeDetails.put("manager_id", newManagerId);
	                employeeDetails.put("manager_name", newManagerName);

	                // Save the updated employee details back to the main JSON
	                usersJson.put(employeeId, employeeDetails);
	            }

	            // Save the updated JSON back to the file
	            JSONUtils.writeJSONFile(usersJson);

	            // Respond with success
	            JSONObject result = new JSONObject();
	            result.put("success", true);
	            result.put("message", "Manager updated successfully");
	            out.write(result.toJSONString());
	            out.flush();
	        } catch (ParseException e) {
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            out.write("{\"message\": \"Failed to parse employee data\"}");
	            e.printStackTrace();
	        } catch (Exception e) {
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            out.write("{\"message\": \"An error occurred while processing the data\"}");
	            e.printStackTrace();
	        }
	        }
	        
	        
	        }
	
//		private boolean updateManagerType(String employeeId) {
//			// TODO Auto-generated method stub
//			JSONObject users = JSONUtils.readJSONFile();
//			JSONObject updateMangerType = new JSONObject();
//			if(users.containsKey(employeeId)) {
//				
//				JSONObject user = (JSONObject) users.get(employeeId);
//
//	        // Parse the employees data (using JSON.simple or other parsing libraries)
	//JSONObject employeesJson = (JSONObject) JSONUtils.parseJson(employeesData);
	
	
//	        // Read the current users JSON data
//	        JSONObject usersJson = JSONUtils.readJSONFile();
//	        
//	        // Loop through each employee and update their manager ID
//	        for (Object key : employeesJson.keySet()) {
//	            String employeeId = (String) key;
//	            JSONObject employee = (JSONObject) employeesJson.get(employeeId);
//	            
//	            // Set the new manager ID for this employee
//	            employee.put("manager_id", newManagerId);
//	            
//	            // Update the employee back in the main users JSON
//	            usersJson.put(employeeId, employee);
//	        }
//
//	        // Save the updated users JSON back to the file
//	        JSONUtils.writeJSONFile(usersJson);
//	        
//	        // Send response
//	        JSONObject jsonResponse = new JSONObject();
//	        if (updateSuccess) {
//	            jsonResponse.put("success", true);
//	            jsonResponse.put("message", "Manager updated successfully.");
//	        } else {
//	            jsonResponse.put("success", false);
//	            jsonResponse.put("message", "Error updating manager.");
//	        }
//
//	        out.write(jsonResponse.toJSONString());
//	        out.flush();
//				System.out.println("boolearn user"+user);
//				//updateMangerType.put("empType", "manager");
//				return true;
//				
//			}else {
//				return false;
//			}
//			
//			
//			
//		}
		
