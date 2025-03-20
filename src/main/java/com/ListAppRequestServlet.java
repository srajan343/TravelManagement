package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class ListAppRequestServlet
 */
@WebServlet(urlPatterns = {"/ListAppRequestServlet" ,"/admin/ListAppRequestServlet","/finance/ListAppRequestServlet","/manager/ListAppRequestServlet","/employee/ListAppRequestServlet"})
public class ListAppRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONObject appList = JSONUtils.readAppJSONFile();
		System.out.println("chartList"+appList);
		response.setContentType("application/json");
        response.getWriter().write(appList.toString());
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
