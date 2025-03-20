package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class GetEmployeesUnderManagerServlet
 */
@WebServlet(urlPatterns = {"/GetEmployeesUnderManagerServlet" ,"/admin/GetEmployeesUnderManagerServlet"})
public class GetEmployeesUnderManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String managerId = request.getParameter("managerId"); // Get the manager's ID from request
        //String managerId = "test03";
        if (managerId == null || managerId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("{\"message\": \"Manager ID is required\"}");
            out.flush();
            return;
        }

        // Read JSON data from the file using your utility method
        //String jsonFilePath = getServletContext().getRealPath("/path/to/your/users.json");
        JSONObject usersJson = JSONUtils.readJSONFile();

        // Filter employees under the manager with the given managerId
        JSONObject employeesUnderManager = new JSONObject();

        // Loop through the JSON and find users who have the same manager_id
        for (Object key : usersJson.keySet()) {
            String userId = (String) key;
            JSONObject user = (JSONObject) usersJson.get(userId);

            String userManagerId = (String) user.get("manager_id");
            //String userManagerId = (String) user.get("manager_id");

            if (managerId.equals(userManagerId)) {
                // Add this user to the result as they are under the given manager
                employeesUnderManager.put(userId, user);
            }
        }

        // Return the filtered employee data as JSON response
        out.write(employeesUnderManager.toJSONString());
        out.flush();
	}

	

}
