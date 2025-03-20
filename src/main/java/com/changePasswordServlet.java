package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class changePasswordServlet
 */
@WebServlet("/changePasswordServlet")
public class changePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		String newPwd = request.getParameter("newPwd");
		String cfPwd = request.getParameter("cfPwd");
		
		
		
		HttpSession session = request.getSession();
		JSONObject result = new JSONObject();
		
		String empId =(String) session.getAttribute("empId");
		
		
		
		JSONObject users = JSONUtils.readJSONFile();
		JSONObject user = (JSONObject) users.get(empId);
		String oldUserPwd = (String)user.get("password"); 
		
		
		
			if(!newPwd.equals(cfPwd)) {
	//			String mismatch = "Password Mismatch";
	//			session.setAttribute("Message", mismatch);
	//			response.sendRedirect("./changePassword.jsp");
				result.put("success", false);
				result.put("message", "Password Mismatch");
				
				 response.setContentType("application/json");
		         response.getWriter().write(result.toJSONString());
				return;
				
			}
			 String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
		        if (!newPwd.matches(passwordRegex)) {
		            result.put("success", false);
		            result.put("message", "Password must be at least 8 characters and include upper, lowercase, digit, and special character.");
		            response.setContentType("application/json");
		            response.getWriter().write(result.toJSONString());
		            return;
		        }
			
			else {
			
			             user.put("password", newPwd);
			             users.put(empId, user);
			             JSONUtils.writeJSONFile(users);
			             
//			             String set = "Password updated";
//			             session.setAttribute("success", set);
//			             response.sendRedirect("./changePassword.jsp");
			             result.put("message","Password Updated");
			             result.put("success", true);
			             result.put("redirectURL", "./index.jsp");
			             response.setContentType("application/json");
				         response.getWriter().write(result.toJSONString());
			             
				}
		
			}
}