package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.Authenticator.RequestorType;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;

/**
 * Servlet implementation class SendOTPServlet
 */
@WebServlet("/SendOTPServlet")
public class SendOTPServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	
	private String generateOTP(int length) {
        Random random = new Random();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otp.append(random.nextInt(10));
        }
        return otp.toString();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String empid = request.getParameter("emp_id");
        String otp = generateOTP(6);

        HttpSession session = request.getSession();
        session.setAttribute("empId", empid);

        // Read the JSON file with user data
        JSONObject users = JSONUtils.readJSONFile();

        JSONObject result = new JSONObject();

        // Check if the user exists
        if (!users.containsKey(empid)) {
            result.put("success", false);
            result.put("message", "User not found!");
            response.setContentType("application/json");
            response.getWriter().write(result.toJSONString());
            return;
        } else {
//        	result.put("emp_id", empid);
            JSONObject user = (JSONObject) users.get(empid);
            String email = (String) user.get("email");

           
                // Read the existing data from the JSON file
                JSONParser parser = new JSONParser();
                JSONArray userArray = new JSONArray();
                boolean isUpdated = false;

                try (FileReader reader = new FileReader("D:\\\\Vinayak-Intern\\\\OneDrive - EDS Technologies Pvt Ltd\\\\Desktop\\\\Eclipse\\\\TravelManagementSystem\\\\otp.json")) {
                    userArray = (JSONArray) parser.parse(reader);
                } catch (Exception e) {
                    // If the file doesn't exist or is empty, initialize a new JSONArray
                    userArray = new JSONArray();
                }

                // Check if the empid already exists in the JSON array
                for (Object obj : userArray) {
                    JSONObject user1 = (JSONObject) obj;
                    if (user1.get("empid").equals(empid)) {
                        // Update the OTP for the existing empid
                        user1.put("otp", otp);
                        isUpdated = true;
                        break;
                    }
                }

                // If empid doesn't exist, create a new entry
                if (!isUpdated) {
                    JSONObject newUser = new JSONObject();
                    newUser.put("empid", empid);
                    newUser.put("otp", otp);
                    userArray.add(newUser);
                }

                // Write the updated JSON array back to the file
                try (FileWriter writer = new FileWriter("D:\\\\Vinayak-Intern\\\\OneDrive - EDS Technologies Pvt Ltd\\\\Desktop\\\\Eclipse\\\\TravelManagementSystem\\\\otp.json")) {
                    writer.write(userArray.toJSONString());
                    writer.flush();
                }

                String subject = "OTP Code for Password Reset";
                String content = "<html><body><h2>Reset your password using the OTP code:</h2><h2><strong>" + otp + "</strong></h2></body></html>";
                MailUtil.sendMailAsync(email, subject, content);
                
                // Send success response
                result.put("success", true);
                session.setAttribute("emp_id", empid);
                result.put("message", "OTP sent successfully! Please check your email.");
                response.setContentType("application/json");
                response.getWriter().write(result.toJSONString());

         
        }
    }
}
