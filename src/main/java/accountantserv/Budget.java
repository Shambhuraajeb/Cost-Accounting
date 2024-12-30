package accountantserv;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class Budget extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cost"; // Replace with your database URL
    private static final String DB_USER = "root"; // Replace with your database username
    private static final String DB_PASSWORD = ""; // Replace with your database password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        try {
            int year =Integer.parseInt(request.getParameter("year"));
            double salesRevenue = Double.parseDouble(request.getParameter("salesRevenue"));
            double otherIncome = Double.parseDouble(request.getParameter("otherIncome"));
            double cogs = Double.parseDouble(request.getParameter("cogs"));
            double salariesWages = Double.parseDouble(request.getParameter("salariesWages"));
            double rentUtilities = Double.parseDouble(request.getParameter("rentUtilities"));
            double officeSupplies = Double.parseDouble(request.getParameter("officeSupplies"));
            double marketing = Double.parseDouble(request.getParameter("marketing"));
            double insurance = Double.parseDouble(request.getParameter("insurance"));
            double travelEntertainment = Double.parseDouble(request.getParameter("travelEntertainment"));
            double depreciation = Double.parseDouble(request.getParameter("depreciation"));
            double leasePayments = Double.parseDouble(request.getParameter("leasePayments"));
            double assetPurchases = Double.parseDouble(request.getParameter("assetPurchases"));
            double renovationCosts = Double.parseDouble(request.getParameter("renovationCosts"));
            double incomeTax = Double.parseDouble(request.getParameter("incomeTax"));
            double otherTaxes = Double.parseDouble(request.getParameter("otherTaxes"));
            double debtRepayments = Double.parseDouble(request.getParameter("debtRepayments"));
            double cashFlowForecast = Double.parseDouble(request.getParameter("cashFlowForecast"));

            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to insert data into the company_budget table
            String sql = "INSERT INTO company_budget (year,sales_revenue, other_income, cogs, salaries_wages, rent_utilities, office_supplies, " +
                         "marketing, insurance, travel_entertainment, depreciation, lease_payments, asset_purchases, " +
                         "renovation_costs, income_tax, other_taxes, debt_repayments, cash_flow_forecast) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, year);
            statement.setDouble(2, salesRevenue);
            statement.setDouble(3, otherIncome);
            statement.setDouble(4, cogs);
            statement.setDouble(5, salariesWages);
            statement.setDouble(6, rentUtilities);
            statement.setDouble(7, officeSupplies);
            statement.setDouble(8, marketing);
            statement.setDouble(9, insurance);
            statement.setDouble(10, travelEntertainment);
            statement.setDouble(11, depreciation);
            statement.setDouble(12, leasePayments);
            statement.setDouble(13, assetPurchases);
            statement.setDouble(14, renovationCosts);
            statement.setDouble(15, incomeTax);
            statement.setDouble(16, otherTaxes);
            statement.setDouble(17, debtRepayments);
            statement.setDouble(18, cashFlowForecast);

            // Execute the update
            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("/Cost/accountant/dashboard.html"); // Redirect to dashboard after successful submission
            } else {
                response.getWriter().println("Error: Unable to save budget data.");
            }

            // Close resources
            statement.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
