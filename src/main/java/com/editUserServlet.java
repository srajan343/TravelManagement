package com;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class editUserServlet
 */
@WebServlet(urlPatterns = {"/editUserServlet","/admin/editUserServlet"})
public class editUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String editUserId = request.getParameter("editUserId");
		System.out.println("editUsrrId::"+editUserId);
		if(editUserId!= null) {
			HttpSession session = request.getSession();
			session.setAttribute("editUserId", editUserId);
			
		}
		System.out.println("session empId edite"+editUserId);
		//forward to the editUser,jsp
		//request.getRequestDispatcher("editUser.jsp").forward(request, response);
		response.sendRedirect("editUser.jsp");
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String empId = (String) session.getAttribute("editUserId");

		System.out.println("empId"+empId);
		String name = (String) request.getParameter("name");
		
		String email = (String) request.getParameter("email");
		String location = (String) request.getParameter("location");
		String empStatus = (String) request.getParameter("activeStatus");
		String addAsManager = (String) request.getParameter("addAsManager");
		String changeManager = (String)request.getParameter("assign-manager");
		
		
		
		System.out.println("here is te details:::"+name+empId+email+location+empStatus+addAsManager+changeManager);
		String status = "";
		String asManager = "";
		if(empStatus.equals("active")) {
			status = "yes";
		}else {
			status = "no";
		}
		
		if(addAsManager.equals("yes")) {
			asManager = "manager";
		}else {
			asManager = "user";
		}
		
		JSONObject result = new JSONObject();
		//gettting manager name using the empId 
		String manager_name = "";
		if(changeManager.equals("none")) {
			manager_name = "";
			changeManager = "";
			
		}
		else {
			
			JSONObject managerUsers = JSONUtils.readJSONFile();
			System.out.println("managersUsers"+managerUsers);
			JSONObject getManager = (JSONObject) managerUsers.get(changeManager);
			manager_name = (String)getManager.get("name");
			System.out.println("manager_name"+manager_name);
		}
		
		//updating the emp details
		JSONObject users = JSONUtils.readJSONFile();
		JSONObject editUser = (JSONObject) users.get(empId);
		
		editUser.put("name",name);
		editUser.put("email", email);
		editUser.put("active",status);
		editUser.put("empType", asManager);
		editUser.put("location",location);
		editUser.put("manager_id",changeManager);
		editUser.put("manager_name",manager_name);
		
		
		users.put(empId, editUser); // Add new user to the data
        JSONUtils.writeJSONFile(users); // Save the updated data
        
        
        
        JSONObject applications = JSONUtils.readAppJSONFile();

     // Traverse through all applications and update the manager details for the matching empId
     for (Object key : applications.keySet()) {
         String applicationKey = (String) key; // Key for each application (e.g., "T008")
         JSONObject application = (JSONObject) applications.get(applicationKey);

         // Check if the empId matches
         String applicationEmpId = (String) application.get("empId");
         String manager_stat = (String)application.get("manager_status");
         if (empId.equals(applicationEmpId) && manager_stat.equals("pending")) {
             // Update manager_id and manager_name for this application
             application.put("manager_id", changeManager);
             application.put("manager_name", manager_name);

             // Save the updated application back into the applications object
             applications.put(applicationKey, application);
         }
     }

     // Write the updated applications object back to the JSON file
     JSONUtils.writeAppJSONFile(applications);

        
        

        // Successful registration response
        result.put("success", true);
        result.put("message", "Edit is successfull");
        result.put("redirectURL", "adminUsers.jsp");
        response.setContentType("application/json");
        response.getWriter().write(result.toJSONString());
		
		
		
	}
	

	
}
