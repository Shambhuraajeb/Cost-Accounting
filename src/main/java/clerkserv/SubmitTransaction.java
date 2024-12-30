package clerkserv;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SubmitTransaction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Database connection variables
        String jdbcURL = "jdbc:mysql://localhost:3306/cost?useSSL=false&serverTimezone=UTC";
        String dbUser = "root";
        String dbPass = "";

        // Retrieve and validate form parameters
        String transactionNo = request.getParameter("transaction_id");
        String costElementIdStr = request.getParameter("cost_element_id");
        String costClassificationIdStr = request.getParameter("cost_classification_id");
        String projectIdStr = request.getParameter("project_id");
        String productIdStr = request.getParameter("product_id");
        String amountStr = request.getParameter("amount");
        String transactionDateStr = request.getParameter("transaction_date");
        String allocationBaseIdStr = request.getParameter("allocation_base_id");
        String description = request.getParameter("description");

        // Validate input and parse variables
        int costElementId, costClassificationId, projectId, productId, allocationBaseId;
        double amount;
        Date transactionDate;

        try {
            costElementId = Integer.parseInt(costElementIdStr);
            costClassificationId = Integer.parseInt(costClassificationIdStr);
            projectId = Integer.parseInt(projectIdStr);
            productId = Integer.parseInt(productIdStr);
            amount = Double.parseDouble(amountStr);
            transactionDate = Date.valueOf(transactionDateStr);
            allocationBaseId = Integer.parseInt(allocationBaseIdStr);
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input: " + e.getMessage());
            return;
        }

        // Set response headers to prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Database insertion
        try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPass);
             PreparedStatement pstmt = connection.prepareStatement(
                     "INSERT INTO transaction (transaction_no, cost_element_id, cost_classification_id, project_id, product_id, amount, transaction_date, allocation_base_id, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")) {

            pstmt.setString(1, transactionNo);
            pstmt.setInt(2, costElementId);
            pstmt.setInt(3, costClassificationId);
            pstmt.setInt(4, projectId);
            pstmt.setInt(5, productId);
            pstmt.setDouble(6, amount);
            pstmt.setDate(7, transactionDate);
            pstmt.setInt(8, allocationBaseId);
            pstmt.setString(9, description);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                // Send success response with audio and redirect
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();

                out.println("<html><body>");
                out.println("<script>");
                out.println("window.onload = function() {");
                out.println("    var audio = new Audio('/Cost/clerk/audio/success.mp3');"); // Adjust path if needed
                out.println("    audio.play();");
                out.println("    setTimeout(function() { window.location.href = '/Cost/clerk/dashboard.jsp'; }, 500);"); // Adjust redirect path if needed
                out.println("};");
                out.println("</script>");
                out.println("</body></html>");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Transaction submission failed!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
}
