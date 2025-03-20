package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Servlet implementation class MailUtil
 */
@WebServlet("/MailUtilTesting")
public class MailUtil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public static boolean sendMail(String recipientEmail, String subject, String content) {
		
		
		
        String fromEmail = "tms.edstechnologies@gmail.com"; // Your email
        String password = "oipcrwslwkplujkl"; // Your email password
 
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.connectiontimeout", "10000"); // 10 seconds
        properties.put("mail.smtp.timeout", "10000"); // 10 seconds
        properties.put("mail.smtp.writetimeout", "10000"); // 10 seconds
 
        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };
 
        Session session = Session.getInstance(properties, auth);
 
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);
            message.setContent(content, "text/html");
 
            Transport.send(message);
 
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
	public static void sendMailAsync(String empMail,String subject, String content) {
        new Thread(() -> {
            boolean otpMail =  MailUtil.sendMail(empMail, subject, content);
            System.out.println("empmail"+empMail+"subject"+subject+"content"+content);
            System.out.print(otpMail? "Otp sent": "Otp not sent");
        }).start();
    }

}
