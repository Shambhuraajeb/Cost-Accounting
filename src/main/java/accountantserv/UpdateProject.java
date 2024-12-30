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

@WebServlet("/EditProjectServlet")
public class UpdateProject extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type to HTML
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form parameters
        int projectId = Integer.parseInt(request.getParameter("project_id"));
        String projectName = request.getParameter("project_name");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String description = request.getParameter("description");
        String budgetAmount = request.getParameter("budget_amount");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");

            // Prepare SQL update statement
            String updateQuery = "UPDATE project SET project_name=?, start_date=?, end_date=?, description=?, budget_amount=? WHERE project_id=?";
            ps = conn.prepareStatement(updateQuery);
            ps.setString(1, projectName);
            ps.setString(2, startDate);
            ps.setString(3, endDate);
            ps.setString(4, description);
            ps.setString(5, budgetAmount);
            ps.setInt(6, projectId);

            int rowsUpdated = ps.executeUpdate();

            // Check if update was successful
            if (rowsUpdated > 0) {
                // Display JavaScript alert and redirect to project.jsp
                out.println("<script type='text/javascript'>");
                out.println("alert('Project updated successfully!');");
                out.println("window.location.href = '/Cost/accountant/project.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Failed to update project. Please try again.');");
                out.println("window.location.href = '/Cost/accountant/EditProject.jsp?id=" + projectId + "';");
                out.println("</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('An error occurred while updating the project.');");
            out.println("window.location.href = '/Cost/accountant/EditProject.jsp?id=" + projectId + "';");
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
