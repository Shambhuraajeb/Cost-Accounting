package accountantserv;

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

public class CompanyCreation extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cost";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String companyName = request.getParameter("companyName");
        String financialYear = request.getParameter("financialYear");
        String mailingName = request.getParameter("mailingName");
        String booksStartDate = request.getParameter("booksStartDate");
        String address = request.getParameter("address");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String pincode = request.getParameter("pincode");
        String telephone = request.getParameter("telephone");
        String mobile = request.getParameter("mobile");
        String fax = request.getParameter("fax");
        String email = request.getParameter("email");
        String website = request.getParameter("website");
        String currencySymbol = request.getParameter("currencySymbol");
        String currencyName = request.getParameter("currencyName");

        // Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load MySQL driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL statement to insert the company details
            String sql = "INSERT INTO companydetails (company_name, financial_year)start, mailing_name, books_start_date, address, state, country, pincode, telephone, mobile, fax, email, website, currency_symbol, currency_name) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);

            // Set values for the prepared statement
            ps.setString(1, companyName);
            ps.setString(2, financialYear);
            ps.setString(3, mailingName);
            ps.setString(4, booksStartDate);
            ps.setString(5, address);
            ps.setString(6, state);
            ps.setString(7, country);
            ps.setString(8, pincode);
            ps.setString(9, telephone);
            ps.setString(10, mobile);
            ps.setString(11, fax);
            ps.setString(12, email);
            ps.setString(13, website);
            ps.setString(14, currencySymbol);
            ps.setString(15, currencyName);

            // Execute the update
            int result = ps.executeUpdate();

            // Provide feedback to the user
            if (result > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Company created successfully!');");
                out.println("location='/Cost/accountant/company_creation.html';"); // Redirect to a success page
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error creating company. Please try again.');");
                out.println("location='/Cost/accountant/company_creation.html';");
                out.println("</script>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Database connection error: " + e.getMessage() + "');");
            out.println("location='/Cost/accountant/company_creation.html';");
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
