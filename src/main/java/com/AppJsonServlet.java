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

/**
 * Servlet implementation class AppJsonServlet
 */
@WebServlet("/AppJsonServlet")
public class AppJsonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String FILE_PATH = "D:\\Vinayak-Intern\\OneDrive - EDS Technologies Pvt Ltd\\Desktop\\Eclipse\\TravelManagementSystem\\application.json";

    // Read JSON file and return the JSONObject
    public static JSONObject readAppJSONFile() {
        JSONParser parser = new JSONParser();
        try (FileReader reader = new FileReader(FILE_PATH)) {
            return (JSONObject) parser.parse(reader);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new JSONObject();
    }

    // Write JSONObject to the file
    public static void writeAppJSONFile(JSONObject jsonObject) {
        try (FileWriter writer = new FileWriter(FILE_PATH)) {
            writer.write(jsonObject.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
