package assistantserv;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AllocationBase extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cost";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String baseName = request.getParameter("allocationBaseName");
        String baseType = request.getParameter("allocationBaseType");

        // Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Connection con = null;
        PreparedStatement ps = null;

        //  out.println(baseName+""+baseType);
        try {
            // Load MySQL driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL statement to insert the allocation base entry
            String sql = "INSERT INTO `allocation_base`(`base_name`, `base_type`) VALUES ( ?, ?)";
            ps = con.prepareStatement(sql);

            // Set values for the prepared statement
            ps.setString(1, baseName);
            ps.setString(2, baseType);

            // Execute the update
            int result = ps.executeUpdate();
            //out.println(result);
            // Provide feedback to the user
            if (result > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Allocation base entry added successfully!');");
                out.println("location='/Cost/assistant/allocation_base.jsp';");
                out.println("</script>");

            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error adding allocation base entry. Please try again.');");
                out.println("location='/Cost/assistant/allocation_base.jsp';");
                out.println("</script>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            String message = "Database error: " + e.getMessage();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('" + message.replace("'", "\\'") + "');");
            out.println("location='/Cost/assistant/allocation_base.jsp';");
            out.println("</script>");

        } finally {
            // Close resources
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.close();
        }
    }
}
