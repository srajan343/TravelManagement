<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, org.json.simple.*, org.json.simple.parser.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Uploaded Files</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Uploaded Files</h2>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Employee ID</th>
            <th>File Name</th>
            <th>Timestamp</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            String jsonFilePath = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\formData.json";
            JSONParser parser = new JSONParser();
	String path = request.getContextPath();
            try (FileReader reader = new FileReader(jsonFilePath)) {
                Object obj = parser.parse(reader);
                JSONArray jsonArray = (JSONArray) obj;

                for (Object fileObj : jsonArray) {
                    JSONObject fileDetails = (JSONObject) fileObj;
                    String empId = (String) fileDetails.get("empId");
                    String fileName = (String) fileDetails.get("fileName");
                    String timestamp = (String) fileDetails.get("timestamp");
                    String filePath = (String) fileDetails.get("filePath");

                    System.out.print("erere"+path+"/files/"+empId+"_"+timestamp+".pdf");
                    
                    out.println("<tr>");
                    out.println("<td>" + empId + "</td>");
                    out.println("<td>" + fileName + "</td>");
                    out.println("<td>" + timestamp + "</td>");
                    out.println("<td><a href='" + path+"/files/"+empId+"_"+timestamp+".pdf" + "' target='_blank'>View</a></td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<tr><td colspan='4' class='text-center'>No files found</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
