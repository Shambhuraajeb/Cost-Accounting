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
import java.sql.Date;
import java.text.SimpleDateFormat;

@WebServlet("/CreateProjectServlet")
public class Project extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type to HTML
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form parameters
        String projectName = request.getParameter("projectName");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String description = request.getParameter("description");
        String budgetAmountStr = request.getParameter("budgetAmount");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Convert startDate and endDate from String to java.sql.Date
            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);
            double budgetAmount = Double.parseDouble(budgetAmountStr);

            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");

            // Prepare SQL insert statement
            String insertQuery = "INSERT INTO project (project_name, start_date, end_date, description, budget_amount) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(insertQuery);
            ps.setString(1, projectName);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            ps.setString(4, description);
            ps.setDouble(5, budgetAmount);

            int rowsInserted = ps.executeUpdate();

            // Check if insertion was successful
            if (rowsInserted > 0) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Project created successfully!');");
                out.println("window.location.href = '/Cost/accountant/project.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Failed to create project. Please try again.');");
                out.println("window.location.href = '/Cost/accountant/project.html';");
                out.println("</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('An error occurred while creating the project.');");
            out.println("window.location.href = '/Cost/accountant/project.html';");
            out.println("</script>");
        } finally {
            // Clean up resources
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
