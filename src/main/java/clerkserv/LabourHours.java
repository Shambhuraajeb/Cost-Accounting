package clerkserv;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class LabourHours extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeId = request.getParameter("employeeId");
        String projectId = request.getParameter("projectId");
        String entryDateStr = request.getParameter("entryDate"); // Date in dd-MM-yyyy format
        String hoursWorked = request.getParameter("hoursWorked");
        

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println(projectId);
        
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Convert date from dd-MM-yyyy to java.sql.Date
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            java.util.Date utilDate = sdf.parse(entryDateStr);
            Date sqlDate = new Date(utilDate.getTime());

            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");

            // SQL statement for insertion
            String sql = "INSERT INTO `direct_labor_hour`(`emp_id`, `project_id`, `labor_hours`, `date`)  VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            
            ps.setInt(1, Integer.parseInt(employeeId));
            ps.setInt(2, Integer.parseInt(projectId));
            ps.setFloat(3, Float.parseFloat(hoursWorked));
            ps.setDate(4, sqlDate);

            // Execute update
            int result = ps.executeUpdate();
            
            if (result > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Labor hours submitted successfully!');");
                out.println("location='/Cost/clerk/dashboard.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error submitting labor hours. Please try again.');");
                out.println("location='/Cost/clerk/labour_hour.jsp';");
                out.println("</script>");
            }
        } catch (ClassNotFoundException | SQLException | ParseException e) {
            e.printStackTrace();
            String msg = e.getMessage().replace("'", "\\'");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('" + msg + "');");
            out.println("location='/Cost/clerk/labour_hour.jsp';");
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
