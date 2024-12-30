import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login.jsp") // Assuming this is the path for your login page
public class LoginPageServlet extends HttpServlet {
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get current session, if it exists
        if (session != null && session.getAttribute("username") != null) {
            // User is already logged in
            response.sendRedirect(getRedirectPage(session.getAttribute("role").toString()));
        } else {
            // User is not logged in, show login page
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    private String getRedirectPage(String role) {
        switch (role) {
            case "cost_clerk":
                return "clerk/dashboard.jsp";
            case "cost_assistant":
                return "assistant/dashboard.html";
            case "cost_accountant":
                return "accountant/dashboard.html";
            default:
                return "error.html"; // Handle invalid role redirection
        }
    }
}
