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

public class CostClassification extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection information
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cost";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String costElementId = request.getParameter("costElement");
        String costClassificationName = request.getParameter("costClassification");

        // Set response content type and writer
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load MySQL driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to insert the cost classification
            String sql = "INSERT INTO cost_classification (cost_element_id, classification_name) VALUES (?, ?)";
            ps = con.prepareStatement(sql);

            // Set parameters for the prepared statement
            ps.setInt(1, Integer.parseInt(costElementId));
            ps.setString(2, costClassificationName);

            // Execute the insertion
            int result = ps.executeUpdate();

            // Check the result and provide feedback to the user
            if (result > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Cost classification submitted successfully!');");
                out.println("location='/Cost/assistant/cost_classification.jsp';"); // Redirect to the desired page
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error submitting cost classification. Please try again.');");
                out.println("location='/Cost/assistant/cost_classification.jsp';");
                out.println("</script>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            String msg = e.getMessage().replace("'", "\\'");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('" + msg + "');");
            out.println("location='/Cost/assistant/cost_classification.jsp';");
            out.println("</script>");
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.close();
        }
    }
}
