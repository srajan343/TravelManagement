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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String empId = request.getParameter("emp_id");
//        String password = request.getParameter("password");
//
//        // Reading the JSON file to get users
//        JSONObject users = JSONUtils.readJSONFile();
//
//        HttpSession session = request.getSession();
//        if (users.containsKey(empId)) {
//            JSONObject user = (JSONObject) users.get(empId);
//            if (user.get("password").equals(password)) {
//                session.setAttribute("empId", empId);
//
//                // Redirect dashboard logic
//                if ("admin".equals(empId)) {
//                    session.setAttribute("admin", true);
//                    response.sendRedirect("adminDashboard.jsp");
//                } else if ("finance".equals(empId)) {
//                    session.setAttribute("finance", true);
//                    response.sendRedirect("financeDashboard.jsp");
//                } else {
//                    boolean isActive = user.get("active") != null && (boolean) user.get("active");
//                    if (!isActive) {
//                        session.setAttribute("Message", "Inactive, Contact Admin");
//                        response.sendRedirect("./index.jsp");
//                        return;
//                    }
//                    boolean isManager = user.get("isManager") != null && (boolean) user.get("isManager");
//                    session.setAttribute("manager", isManager);
//                    response.sendRedirect("empDashboard.jsp");
//                }
//            } else {
//                request.setAttribute("error", "Incorrect Credentials.");
//                request.setAttribute("emp_id", empId);
//                request.getRequestDispatcher("./index.jsp").forward(request, response);
//            }
//        } else {
//            request.setAttribute("error", "User not found!");
//            request.setAttribute("emp_id", empId);
//            request.getRequestDispatcher("./index.jsp").forward(request, response);
//        }
//    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        String empId = request.getParameter("emp_id");
        String password = request.getParameter("password");

        // Reading the JSON file to get users
        JSONObject users = JSONUtils.readJSONFile();

        // Set the response type to JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        JSONObject jsonResponse = new JSONObject();

        HttpSession session = request.getSession();
        if (users.containsKey(empId)) {
            JSONObject user = (JSONObject) users.get(empId);
            
            if (user.get("password").equals(password)) {
            	//getting the user name
            	String empName = (String) user.get("name");
            	session.setAttribute("empName", empName);
            	
                session.setAttribute("empId", empId);

                // Redirect dashboard logic
               // if ("admin".equals(empId)) {
                    //session.setAttribute("user", "admin");
                    //jsonResponse.put("success", true);
                    //jsonResponse.put("redirectURL", "admin/adminDashboard2.jsp");

                //trial make this to the appropriate designation which is above
                
                    if ("admin".equals(empId)) {
                        session.setAttribute("user", "admin");
                        jsonResponse.put("success", true);
                        jsonResponse.put("redirectURL", "admin/adminDashboard.jsp");
                    
                } else if ("finance".equals(empId)) {
                    session.setAttribute("user", "finance");
                    jsonResponse.put("success", true);
                    jsonResponse.put("redirectURL", "finance/financeDashboard.jsp");
                } else {
                   // String isActive = user.get("active") != null && (String) user.get("active");
                	String isActive = (String)user.get("active");
                    //if (!isActive) {
                	if(isActive.equals("no")) {
                        session.setAttribute("Message", "Inactive, Contact Admin");
                        jsonResponse.put("success", false);
                        jsonResponse.put("message", "Inactive, Contact Admin");
                    } else {
                        //boolean isManager = user.get("isManager") != null && (boolean) user.get("isManager");
                        String empType = (String)user.get("empType");
                        if(empType.equals("manager")) {
                        	session.setAttribute("user", "manager");
                        	session.setAttribute("empId", empId);
                        	session.setAttribute("isManager", true);
                            jsonResponse.put("success", true);
                            jsonResponse.put("redirectURL", "manager/managerDashboard.jsp");
                        }
                        else if (empType.equals("user")){
                        	session.setAttribute("user", "employee");
                        	session.setAttribute("empId", empId);
                            jsonResponse.put("success", true);
                            jsonResponse.put("redirectURL", "employee/empDashboard.jsp");
                        	
                        }
                        
                    }
                }
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Incorrect Credentials.");
            }
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "User not found!");
        }

        // Send the JSON response
        out.print(jsonResponse.toString());
        out.flush();
    }

}
