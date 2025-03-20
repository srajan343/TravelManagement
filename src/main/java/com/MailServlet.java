package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet implementation class MailServlet
 */
@WebServlet("/MailServlet")
public class MailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 private static final String JSON_FILE = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\application.json"; // Path to your JSON file

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
	        response.setContentType("application/json");
	        PrintWriter out = response.getWriter();

	        try {
	            // Parse the incoming request
	            BufferedReader reader = request.getReader();
	            StringBuilder sb = new StringBuilder();
	            String line;
	            while ((line = reader.readLine()) != null) {
	                sb.append(line);
	            }
	            JSONObject requestData = (JSONObject) new JSONParser().parse(sb.toString());

	            String appNo = (String) requestData.get("appNo");
	            String status = (String) requestData.get("status");
	            String reason = (String) requestData.getOrDefault("reason", "");

	            // Load JSON file
	            FileReader fileReader = new FileReader(JSON_FILE);
	            JSONParser parser = new JSONParser();
	            JSONObject data = (JSONObject) parser.parse(fileReader);
	            fileReader.close();

	            // Update application status
	            JSONObject application = (JSONObject) data.get(appNo);
	            if (application != null) {
	                application.put("status", status);

	                if (status.equals("rejected")) {
	                    application.put("reason", reason);
	                }

	                // Save changes to JSON file
	                try (FileWriter fileWriter = new FileWriter(JSON_FILE)) {
	                    fileWriter.write(data.toJSONString());
	                    fileWriter.flush();
	                }

	                // Send email logic (stubbed)
	                boolean mailSent = sendEmail(application, status, reason);

	                JSONObject result = new JSONObject();
	                result.put("success", mailSent);
	                result.put("message", mailSent ? "Email sent successfully!" : "Failed to send email.");
	                out.write(result.toJSONString());
	            } else {
	                throw new Exception("Application not found.");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            JSONObject error = new JSONObject();
	            error.put("success", false);
	            error.put("message", "Error processing the request.");
	            out.write(error.toJSONString());
	        }
	    }

	    // Mock email sending logic
	    private boolean sendEmail(JSONObject application, String status, String reason) {
	        System.out.println("Sending email...");
	        System.out.println("Application No: " + application.get("appNo"));
	        System.out.println("Status: " + status);
	        if (status.equals("rejected")) {
	            System.out.println("Reason: " + reason);
	        }
	        // Return true for success
	        return true;
	    }

}
