package assistantserv;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CostElementServlet")
public class CostElement extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String costElementName = request.getParameter("costElementName");
        String costType = request.getParameter("cost_type");

        String jdbcUrl = "jdbc:mysql://localhost:3306/cost";
        String jdbcUser = "root";
        String jdbcPassword = "";

        boolean isInserted = false;

        try (Connection con = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword)) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String query = "INSERT INTO cost_element (cost_element_name, cost_type) VALUES (?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(query)) {
                pstmt.setString(1, costElementName);
                pstmt.setString(2, costType);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    isInserted = true;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        // Prepare response with JavaScript alert
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        if (isInserted) {
            out.println("<script type='text/javascript'>");
            out.println("alert('Cost Element has been successfully submitted.');");
            out.println("window.location.href = '/Cost/assistant/cost_element.jsp';"); // Redirect to dashboard
            out.println("</script>");
        } else {
            out.println("<script type='text/javascript'>");
            out.println("alert('Error: Cost Element submission failed.');");
            out.println("window.location.href = '/Cost/assistant/cost_element.jsp';"); // Redirect back to form
            out.println("</script>");
        }
        out.println("</body></html>");
    }
}
