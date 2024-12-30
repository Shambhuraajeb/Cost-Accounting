import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cost?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish a connection
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM employees WHERE username = ? AND password = ? AND role = ?")) {

                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);
                preparedStatement.setString(3, role);

                // Execute the query
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        // Valid credentials
                        HttpSession session = request.getSession();
                        session.setAttribute("username", username);
                        session.setAttribute("role", role);

                        // Redirect based on role
                        if ("cost_clerk".equals(role)) {
                            response.sendRedirect("clerk/dashboard.jsp");
                        } else if ("cost_assistant".equals(role)) {
                            response.sendRedirect("assistant/dashboard.jsp");
                        } else if ("cost_accountant".equals(role)) {
                            response.sendRedirect("accountant/dashboard.html");
                        } else {
                            out.println("<h2>Invalid role!</h2>");
                        }
                    } else {
                        // Invalid credentials
                        out.println("<h2>Invalid username, password, or role!</h2>");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h2>Error occurred while processing your request: " + e.getMessage() + "</h2>");
        } finally {
            out.close();
        }
    }
}
