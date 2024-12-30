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

public class BudgetedCost extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection information
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cost";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String projectId = request.getParameter("projectId");
        String costElementId = request.getParameter("costElementId");
        String description = request.getParameter("description");
        String budgetedCostStr = request.getParameter("budgetedCost");

        // Set response content type and writer
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        //out.println(projectId+""+costElementId+""+description+""+budgetedCostStr);

         //Input validation checks
        if (projectId == null || projectId.trim().isEmpty() ||
            costElementId == null || costElementId.trim().isEmpty() ||
            description == null || description.trim().isEmpty() ||
            budgetedCostStr == null || budgetedCostStr.trim().isEmpty()) {

            out.println("<script type=\"text/javascript\">");
            out.println("alert('All fields must be filled out.');");
            out.println("location='/Cost/assistant/budgeted_cost.jsp';");
            out.println("</script>");
            return;
        }

        // Attempt to parse the budgeted cost
        double budgetedCost = 0;
        try {
            budgetedCost = Double.parseDouble(budgetedCostStr.trim());
        } catch (NumberFormatException e) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Invalid number format for budgeted cost. Please enter a valid number.');");
            out.println("location='/Cost/assistant/budgeted_cost.jsp';");
            out.println("</script>");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load MySQL driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to insert the budgeted cost
            String sql = "INSERT INTO budgeted_cost (cost_element_id, project_id, budgeted_amount, description) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);

            // Set parameters for the prepared statement
            ps.setInt(1, Integer.parseInt(costElementId)); // Cost Element ID (INT)
            ps.setInt(2, Integer.parseInt(projectId)); // Project ID (INT)
            ps.setDouble(3, budgetedCost); // Budgeted Amount (DECIMAL)
            ps.setString(4, description); // Description (VARCHAR)

            // Execute the insertion
            int result = ps.executeUpdate();

            // Check the result and provide feedback to the user
            if (result > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Budgeted cost submitted successfully!');");
                out.println("location='/Cost/assistant/budgeted_cost.jsp';"); // Redirect to the same page or a success page
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error submitting budgeted cost. Please try again.');");
                out.println("location='/Cost/assistant/budgeted_cost.jsp';");
                out.println("</script>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            String msg = e.getMessage().replace("'", "\\'");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('" + msg + "');");
            out.println("location='/Cost/assistant/budgeted_cost.jsp';");
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
