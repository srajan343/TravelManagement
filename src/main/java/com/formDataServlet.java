package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet implementation class formDataServlet
 */
@MultipartConfig
@WebServlet(urlPatterns = {"/formDataServlet","/employee/formDataServlet","/manager/formDataServlet"})
public class formDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String JSON_FILE = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\formData.json"; // Update this to the actual path of the JSON file

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    System.out.println("inside the servlet");

	    String empId = "1000"; // Assuming this value is retrieved elsewhere
System.out.println("Inside the servlet");
        
        JSONArray receiptArray = new JSONArray();
        JSONParser parser = new JSONParser();
        
        try (FileReader reader = new FileReader(JSON_FILE)) {
            Object obj = parser.parse(reader);
            receiptArray = (JSONArray) obj;
        } catch (Exception e) {
            // JSON file doesn't exist or is empty
        }

        for (Part part : request.getParts()) {
            if (part.getName().equals("file[]")) {
                String employeeName = request.getParameterValues("employeeName[]")[0];
                String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                
                String uploadPath = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\src\\main\\webapp\\files\\" + empId + "_" + timestamp + ".pdf";
                File directory = new File(uploadPath).getParentFile();
                if (!directory.exists()) {
                    directory.mkdirs();
                }

                File file = new File(uploadPath);
                Files.copy(part.getInputStream(), file.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);

                JSONObject fileDetails = new JSONObject();
                
                fileDetails.put("empId", empId);
                fileDetails.put("employeeName", employeeName);
                fileDetails.put("timestamp", timestamp);
                fileDetails.put("fileName", fileName);
                fileDetails.put("filePath", uploadPath);

                receiptArray.add(fileDetails);
            }
        }

        // Write updated JSON to the file
        try (FileWriter writer = new FileWriter(JSON_FILE)) {
            writer.write(receiptArray.toJSONString());
        }

        response.sendRedirect("formData1.jsp");	}

}
