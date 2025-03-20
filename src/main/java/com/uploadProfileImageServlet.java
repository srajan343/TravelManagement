package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputFilter.Config;
import java.nio.file.Files;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class uploadProfileImageServlet
 */
@WebServlet(urlPatterns = {"/uploadProfileImageServlet","/finance/uploadProfileImageServlet","/admin/uploadProfileImageServlet","/manager/uploadProfileImageServlet","/employee/uploadProfileImageServlet"})
@MultipartConfig
public class uploadProfileImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		String empId = (String)session.getAttribute("empId");
		
		Part filePart = request.getPart("profilePic"); // Retrieves <input type="file" name="file">
	       //  String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
		
	        InputStream fileContent = filePart.getInputStream();
	 
	        // Define the path where you want to save the file
//	        String uploadPath = "D:\\Navaprettam - I113\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Practice\\AssetManagement\\AssetManagement_v007\\src\\main\\webapp\\images\\profilepic\\"+empId+".png";
	        
//	        String uploadPath = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\src\\main\\webapp\\static\\profile-img\\"+empId+".png";
	        
//	        File uploadDir = new File(getServletContext().getRealPath("/static/profile-img/"));
//	        if (!uploadDir.exists()) {
//	            uploadDir.mkdirs();
//	        }

	        
	        //String uploadPath2 = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\src\\main\\webapp\\static\\profile-img\\"+empId+".png";
	        
	        String uploadPath = getServletContext().getRealPath("/static/profile-img/") + empId + ".png";
	        System.out.println(uploadPath);

	        // Save the file, overwriting if it exists
	        File file = new File(uploadPath);
	        Files.copy(fileContent, file.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
	        
	        //File file2 = new File(uploadPath2);
	        //Files.copy(fileContent, file2.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
			
//			 String filePath = Config.DATA_FOLDER_PATH + "/User.json";
	        String filePath = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\user.json";
//			
	        
	        JSONObject users = JSONUtils.readJSONFile();
	        log(empId);
	        if (users.containsKey(empId)){
	        	JSONObject user = (JSONObject) users.get(empId);
	        	user.put("profileImg", "static/profile-img/" + empId + ".png");
	        	log("testing");
	            JSONUtils.writeJSONFile(users); // Save the updated data
	        }
	        
	        

//	        String profileImagePath = "/static/profile-img/" + empId + "-img.png";
//	        String realPath = getServletContext().getRealPath(profileImagePath);
//
//	        File profileImage = new File(realPath);
//	        String imageUrl;
//	        if (profileImage.exists()) {
//	            imageUrl = request.getContextPath() + profileImagePath;
//	        } else {
//	            imageUrl = request.getContextPath() + "/static/profile-img/default-img.png";
//	        }
//	        request.setAttribute("profileImageUrl", imageUrl);

	        
	        if(empId.equals("finance")) {
	        response.sendRedirect("./financeDashboard.jsp");
	        }
	        else if(empId.equals("admin")) {
	        	response.sendRedirect("./testAdminDashboard.jsp");
	        }
	        else {
	        	response.sendRedirect("./empDashboard.jsp");
//	        	request.getRequestDispatcher("empDashboard.jsp").forward(request, response);
	        }
//	        request.getRequestDispatcher("financeDashboard.jsp").forward(request, response);
	        
	}

}
