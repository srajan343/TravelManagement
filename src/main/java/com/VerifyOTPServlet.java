package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.FileReader;
import java.io.IOException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet implementation class VerifyOTPServlet
 */
@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String emp_id = request.getParameter("emp_id");
	    String enteredOtp = request.getParameter("otp");

	    HttpSession session = request.getSession();

	    JSONObject result = new JSONObject();
	    JSONParser parser = new JSONParser();
	    boolean isValid = false;

	    try (FileReader fReader = new FileReader("D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\otp.json")) {
	        JSONArray userArray = (JSONArray) parser.parse(fReader);

	        for (Object obj : userArray) {
	            JSONObject user = (JSONObject) obj;
	            String empid = (String) user.get("empid");
	            String otp = (String) user.get("otp");

	            if (empid.equals(emp_id) && otp.equals(enteredOtp)) {
	                isValid = true;
	                
	                session.setAttribute("emp_id", emp_id);
	                break;
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    if (isValid) {
	        result.put("success", true);
	        result.put("message", "OTP Verified");
	    } else {
	        result.put("success", false);
	        result.put("message", "OTP is incorrect");
	    }
	    session.setAttribute("empId",emp_id);
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(result.toJSONString());
	}


}
