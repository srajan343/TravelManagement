package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet implementation class ApplicationDataServlet
 */
@WebServlet("/ApplicationDataServlet")
public class ApplicationDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String JSON_FILE ="D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\application.json";
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        
        
        try (FileReader reader = new FileReader(JSON_FILE)) {
            JSONParser parser = new JSONParser();
            JSONObject data = (JSONObject) parser.parse(reader);

            JSONArray applications = new JSONArray();
            JSONObject statistics = new JSONObject();
            Map<String, Integer> statusCounts = new HashMap<>();

            // Process application data
            for (Object key : data.keySet()) {
                JSONObject application = (JSONObject) data.get(key);
                applications.add(application);

                // Update status counts
                String status = (String) application.get("status");
                statusCounts.put(status, statusCounts.getOrDefault(status, 0) + 1);
            }

            // Prepare statistics
            statistics.put("labels", Arrays.asList("Accepted", "Rejected", "Pending"));
            statistics.put("statusCounts", Arrays.asList(
                statusCounts.getOrDefault("accepted", 0),
                statusCounts.getOrDefault("rejected", 0),
                statusCounts.getOrDefault("pending", 0)
            ));

            JSONObject result = new JSONObject();
            result.put("success", true);
            result.put("applications", applications);
            result.put("statistics", statistics);

            out.write(result.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject error = new JSONObject();
            error.put("success", false);
            error.put("message", "Error fetching application data.");
            out.write(error.toJSONString());
        }
    }

}
