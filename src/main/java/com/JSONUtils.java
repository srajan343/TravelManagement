package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class JSONUtils
 */
@WebServlet("/JSONUtils")
public class JSONUtils extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	 private static final String FILE_PATH = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\user.json";

	    // Read JSON file and return the JSONObject
	    public static JSONObject readJSONFile() {
	        JSONParser parser = new JSONParser();
	        try (FileReader reader = new FileReader(FILE_PATH)) {
	            return (JSONObject) parser.parse(reader);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return new JSONObject();
	    }

	    // Write JSONObject to the file
	    public static void writeJSONFile(JSONObject jsonObject) {
	        try (FileWriter writer = new FileWriter(FILE_PATH)) {
	            writer.write(jsonObject.toJSONString());
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    private static final String FILE_PATH1 = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\application.json";

	    // Read JSON file and return the JSONObject
	    public static JSONObject readAppJSONFile() {
	        JSONParser parser = new JSONParser();
	        try (FileReader reader = new FileReader(FILE_PATH1)) {
	            return (JSONObject) parser.parse(reader);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return new JSONObject();
	    }

	    // Write JSONObject to the file
	    public static void writeAppJSONFile(JSONObject jsonObject) {
	        try (FileWriter writer = new FileWriter(FILE_PATH1)) {
	            writer.write(jsonObject.toJSONString());
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    //
	    //
	    //
	    private static final String FILE_PATH2 = "D:\\\\Vinayak-Intern\\\\OneDrive - EDS Technologies Pvt Ltd\\\\Desktop\\\\Eclipse\\\\TravelManagementSystem\\\\application1.json";
	    public static JSONObject readAppJSONFile1() throws IOException, ParseException {
	        try (FileReader reader = new FileReader(FILE_PATH2)) {
	            JSONParser parser = new JSONParser();
	            return (JSONObject) parser.parse(reader);
	        }
	    }

	    
	    public static void writeAppJSONFile1(JSONObject jsonObject) {
	        try (FileWriter writer = new FileWriter(FILE_PATH2)) {
	            writer.write(jsonObject.toJSONString());
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    public static boolean updateAppStatus(String appNo, String status) throws IOException, ParseException {
	        // Load JSON data
	        JSONObject applications = readAppJSONFile1();

	        // Update the specific application's status
	        if (applications.containsKey(appNo)) {
	            JSONObject application = (JSONObject) applications.get(appNo);
	            application.put("admin_status1", status);

	            // Write back to the file
	            try (FileWriter writer = new FileWriter(FILE_PATH2)) {
	                writer.write(applications.toJSONString());
	            }
	            return true;
	        }
	        return false;
	    }

}
