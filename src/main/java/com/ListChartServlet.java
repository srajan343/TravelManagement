package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class ListChartServlet
 */
@WebServlet(urlPatterns = {"/ListChartServlet","/admin/ListChartServlet","/finance/ListChartServlet","/manager/ListChartServlet","/employee/ListChartServlet"})
public class ListChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONObject chartList = JSONUtils.readAppJSONFile();
		//System.out.println("chartList"+chartList);
		response.setContentType("application/json");
        response.getWriter().write(chartList.toString());
		
	}

	

}
