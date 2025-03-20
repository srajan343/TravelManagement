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
 * Servlet implementation class AuthServlet
 */
@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get the existing session (if any)

        if (session == null || session.getAttribute("empId") == null) {
            response.sendRedirect("index.jsp"); // Redirect to login if no session found
        } else {
            String empId = (String) session.getAttribute("empId");

            // Fetch user data from JSON to check for specific roles or permissions
            JSONObject users = JSONUtils.readJSONFile();
            JSONObject user = (JSONObject) users.get(empId);

            // Check user's role or other criteria to determine dashboard
            if (user != null) {
                String role = user.get("role") != null ? (String) user.get("role") : "user";

                // Redirect based on role
                if ("admin".equals(role)) {
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    response.sendRedirect("empDashboard.jsp");
                }
            } else {
                response.sendRedirect("index.jsp");
            }
        }
    }


}
