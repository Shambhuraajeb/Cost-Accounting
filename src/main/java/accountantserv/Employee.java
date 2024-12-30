package accountantserv;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/registerEmployee")
public class Employee extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/cost";
    private static final String DB_USER = "root"; // Replace with your database username
    private static final String DB_PASSWORD = ""; // Replace with your database password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        boolean isSuccess = false;

        // Insert data into the employees table
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO employees (name, email, username, password, role) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, username);
                stmt.setString(4, password);  // In production, consider hashing the password
                stmt.setString(5, role);
                int result = stmt.executeUpdate();
                
                isSuccess = (result > 0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Show an alert message and reload the registration page
        if (isSuccess) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Employee registered successfully!');");
            out.println("location='/Cost/accountant/employee.html';"); // Replace with the registration page URL
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Error registering employee. Please try again.');");
            out.println("location='/Cost/accountant/employee.html';"); // Replace with the registration page URL
            out.println("</script>");
        }
    }
}
