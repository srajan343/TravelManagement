package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class dashboardServlet
 */
@WebServlet("/dashboardServlet")
public class dashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String empId = (String) session.getAttribute("empId");
		JSONObject users = JSONUtils.readJSONFile();
		JSONObject user = (JSONObject)users.get(empId);
		int size = users.size();
		request.setAttribute("totalApp", size);
		request.getRequestDispatcher("/admin/adminDashboard2.jsp").forward(request, response);
	}

	
	

}
