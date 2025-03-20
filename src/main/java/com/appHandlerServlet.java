package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet implementation class appHandlerServlet
 */
@MultipartConfig
@WebServlet( urlPatterns = {"/appHandlerServlet","/manager/appHandlerServlet","/employee/appHandlerServlet"})
public class appHandlerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	//private static final String JSON_FILE_PATH = "/path/to/your/json/file.json";
    private static final String FILE_UPLOAD_PATH = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\src\\main\\webapp\\files\\";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("inside the post method");
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();

		try {
		    // Parse the application data sent in the request
		    String applicationDataJson = request.getParameter("applicationData");
		    JSONParser parser = new JSONParser();
		    JSONObject applicationData = (JSONObject) parser.parse(applicationDataJson);

		    // Retrieve empId from applicationData
		    String empId = (String) applicationData.get("empId");
		    
		    String timeStamp = (String) applicationData.get("timestamp");
		    System.out.println("timestamp::"+timeStamp);

		    // Read the employee JSON file using JSONUtils
		    JSONObject employeesJson = JSONUtils.readJSONFile();
		    JSONObject employeeData = (JSONObject) employeesJson.get(empId);

		    // Retrieve manager details and employee name
		    if (employeeData == null) {
		        throw new Exception("Employee not found for empId: " + empId);
		    }
		    String managerId = (String) employeeData.get("manager_id");
		    String managerName = (String) employeeData.get("manager_name");
		    String employeeName = (String) employeeData.get("name");

		    // Read the existing JSON file that stores the applications
		    JSONObject jsonFile = JSONUtils.readAppJSONFile();

		    // Generate a new application number
		    String newApplicationNumber = "T" + String.format("%03d", jsonFile.size() + 1);

		    // Create a new JSON object for the application
		    JSONObject newApplication = new JSONObject();
		    newApplication.put("customer_name", applicationData.get("customer_name"));
		    newApplication.put("self", applicationData.get("self"));
		    newApplication.put("empId", empId);
		    newApplication.put("manager_id", managerId);
		    newApplication.put("manager_name", managerName);
		    newApplication.put("name", employeeName);
		    newApplication.put("applied_on", timeStamp);
		    

		    // Add default statuses
		    newApplication.put("remarks", "");
		    newApplication.put("admin_status", "pending");
		    newApplication.put("manager_status", "pending");
		    newApplication.put("finance_status", "pending");

		    // Initialize arrays for date, amount, source, destination, type, and receipt
		    JSONArray dateArray = new JSONArray();
		    JSONArray amountArray = new JSONArray();
		    JSONArray sourceArray = new JSONArray();
		    JSONArray destinationArray = new JSONArray();
		    JSONArray typeArray = new JSONArray();
		    JSONArray receiptArray = new JSONArray();

		    boolean isSelfArranged = "yes".equalsIgnoreCase((String) applicationData.get("self"));

		    // Process the rows in the application data
		    for (int i = 0; i < ((JSONArray) applicationData.get("rows")).size(); i++) {
		        JSONObject row = (JSONObject) ((JSONArray) applicationData.get("rows")).get(i);

		        // Extract row details
		        String date = (String) row.get("date");
		        String from = (String) row.get("from");
		        String to = (String) row.get("to");
		        String type = (String) row.get("type");

		        // Add required fields to arrays
		        dateArray.add(date);
		        sourceArray.add(from);
		        destinationArray.add(to);
		        typeArray.add(type);

		        if (isSelfArranged) {
		            // Handle amount and receipt only if self is "yes"
		            String amount = (String) row.get("amount");
		            String receipt = (String) row.get("receipt");

		            amountArray.add(amount);
		            receiptArray.add(receipt);

		            // Handle file upload for each receipt
		            String receiptKey = "receipt_" + i;
		            Part receiptPart = request.getPart(receiptKey);
		            if (receiptPart != null && receipt != null && !receipt.isEmpty()) {
		                File file = new File(FILE_UPLOAD_PATH + File.separator + receipt);
		                receiptPart.write(file.getAbsolutePath());
		            }
		        } else {
		            // Add placeholders for non-self-arranged cases
		            amountArray.add("");
		            receiptArray.add("");
		        }
		    }

		    // Add the arrays to the new application JSON object
		    newApplication.put("date", dateArray);
		    newApplication.put("amount", amountArray);
		    newApplication.put("source", sourceArray);
		    newApplication.put("Destination", destinationArray);
		    newApplication.put("type", typeArray);
		    newApplication.put("receipt", receiptArray);

		    // Add the new application to the JSON file
		    jsonFile.put(newApplicationNumber, newApplication);

		    // Write the updated JSON data back to the file
		    JSONUtils.writeAppJSONFile(jsonFile);

		    // Send a success response
		    JSONObject result = new JSONObject();
		    result.put("success", true);
		    out.write(result.toJSONString());

		} catch (Exception e) {
		    e.printStackTrace();
		    // Send an error response if an exception occurs
		    JSONObject result = new JSONObject();
		    result.put("success", false);
		    result.put("error", e.getMessage());
		    out.write(result.toJSONString());
		}

	}

}
