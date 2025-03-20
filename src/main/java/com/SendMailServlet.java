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
 * Servlet implementation class SendMailServlet
 */
@WebServlet(urlPatterns = {"/SendMailServlet" , "/finance/SendMailServlet","/admin/SendMailServlet","/manager/SendMailServlet"})
public class SendMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//MailUtil.sendMail(LEGACY_DO_HEAD, LEGACY_DO_HEAD, LEGACY_DO_HEAD)
		
		
		HttpSession session = request.getSession();
		String usr = (String)session.getAttribute("user");
		
		
		
		String name = request.getParameter("name");
		String appno = request.getParameter("key");
		String action = request.getParameter("action");
		String remarks = request.getParameter("remarks");
		String empId = request.getParameter("empId");
		String amount = request.getParameter("amount");
		String email = "";
		String subject = "";
		String content = "";
		System.out.println("&&&&&"+name+" "+appno+" "+action+" "+remarks+" "+empId+"user:: "+usr );
		
		
		if("finance".equals(usr)) {
			if(action.equals("SETTLE")) {
				subject = "Application Approved by Finance Dept";
				content = "<html><body><h2>Dear Applicant, "+name +" </h2><br><h2> Your App no: "+appno+ " Has been <strong>Approved</strong> by the Finance Dept, And Rs."+ amount+" will be reflected soon into your bank account</h2><br><h3>Thank you for applying, and for any clarification please contact Finance Team</h3></body></html>";
		
			}
			else if(action.equals("REJECT")) {
				subject = "Application Rejected by Finance Dept";
				content = "<html><body><h2>Dear Applicant, "+name +" </h2><br><h2> Your App no: "+appno+ " Has been <strong>Rejected</strong> by the Finance Dept, And Remarks are '  "+ remarks+"  '</h2><br><h3>For any clarification please contact Finance Team</h3></body></html>";
			}
		}
		else if("admin".equals(usr)) {
			if(action.equals("APPROVE")) {
				log("content");
				subject = "Application Approved by Admin Dept";
				content = "<html><body><h2>Dear Applicant, "+name +" </h2><br><h2> Your App no: "+appno+ " Has been <strong>Approved</strong> by the Admin Dept, And the booking details will be shared shortly.</h2><br><h3>Thank you for applying, and for any clarification please contact Admin Team</h3></body></html>";
		
			}
			else if(action.equals("REJECT")) {
				subject = "Application Rejected by Admin Dept";
				content = "<html><body><h2>Dear Applicant, "+name +" </h2><br><h2> Your App no: "+appno+ " Has been <strong>Rejected</strong> by the Admin Dept, And Remarks are '  "+ remarks+"  '</h2><br><h3>For any clarification please contact Admin Team</h3></body></html>";
			}
		}
		else if("manager".equals(usr)) {
			if(action.equals("APPROVE")) {
				subject = "Application Approved by Manager";
				content = "<html><body><h2>Dear Applicant, "+name +" </h2><br><h2> Your App no: "+appno+ " Has been <strong>Approved</strong> by the Manager, And forwarded to the respective department for approval.</h2><br><h3>Thank you for applying, and for any clarification please contact Manager</h3></body></html>";
		
			}
			else if(action.equals("REJECT")) {
				subject = "Application Rejected by Manager";
				content = "<html><body><h2>Dear Applicant, "+name +" </h2><br><h2> Your App no: "+appno+ " Has been <strong>Rejected</strong> by the Manager, And Remarks are '  "+ remarks+"  '</h2><br><h3>For any clarification please contact Manager</h3></body></html>";
			}
		}
		
		
		JSONObject users = JSONUtils.readJSONFile();
		if (users.containsKey(empId)) {
			JSONObject user = (JSONObject) users.get(empId);
			email = (String) user.get("email");
			System.out.println("email"+email);
			
		}
		
		//boolean status = MailUtil.sendMail(email, subject, content);
		
		MailUtil.sendMailAsync(email, subject, content);
		//if(status) {
			//System.out.println("mail has been sent");
	//	}
		//else {
	//		System.out.println("mail not sent");
	//	}
		
		

	}
	

}
