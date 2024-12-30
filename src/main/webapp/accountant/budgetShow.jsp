<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Company Budget Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f7f6;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 80%;
                margin: 50px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border: 1px solid #ddd;
            }
            h1 , #years{
                text-align: center;
                color: #2c3e50;
                margin-bottom: 20px;
            }
            .section {
                margin-bottom: 30px;
            }
            .section h2 {
                background-color: #34495e;
                color: white;
                padding: 12px;
                margin: 0;
                font-size: 18px;
                text-transform: uppercase;
            }
            .section-content {
                padding: 20px;
                border-left: 4px solid #34495e;
                margin-top: 10px;
            }
            .item {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px solid #ddd;
            }
            .item span {
                font-weight: normal;
                color: #555;
            }
            .value {
                font-weight: bold;
                text-align: right;
                color: #2c3e50;
            }
            .footer {
                padding-top: 20px;
                border-top: 2px solid #ddd;
                text-align: center;
                font-size: 14px;
                color: #777;
            }
            .double-line {
                border-top: 3px double #34495e;
                margin-top: 10px;
                margin-bottom: 10px;
            }

            @media screen and (max-width: 768px) {
                .item {
                    flex-direction: column;
                    align-items: flex-start;
                }
                .item .value {
                    margin-top: 5px;
                }
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h1>Company Budget Overview</h1>

            <% 
                int year =Integer.parseInt(request.getParameter("year"));
                
                // Database connection variables
                String url = "jdbc:mysql://localhost:3306/cost";  // Replace with your DB URL
                String username = "root";  // Replace with your DB username
                String password = "";  // Replace with your DB password
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load the JDBC driver and establish a connection to the database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, username, password);

                    // SQL query to fetch data from the database
                    String sql = "SELECT id, sales_revenue, other_income, cogs, salaries_wages, rent_utilities, office_supplies, marketing, insurance, travel_entertainment, depreciation, lease_payments, asset_purchases, renovation_costs, income_tax, other_taxes, debt_repayments, cash_flow_forecast, created_at, (sales_revenue + other_income + cogs + salaries_wages + rent_utilities + office_supplies + marketing + insurance + travel_entertainment + depreciation + lease_payments + asset_purchases + renovation_costs + income_tax + other_taxes + debt_repayments + cash_flow_forecast) AS total_sum FROM company_budget where year="+year+"";  
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);
            %>
            <h2 id="years"><%= year %></h2>
            <!-- Loop through the result set and display data in sections -->
            <% 
                while (rs.next()) {
            %>

            <!-- Sales and Income Section -->
            <div class="section">
                <h2>Sales & Income</h2>
                <div class="section-content">
                    <div class="item">
                        <span>Sales Revenue</span>
                        <span class="value"><%= rs.getDouble("sales_revenue") %></span>
                    </div>
                    <div class="item">
                        <span>Other Income</span>
                        <span class="value"><%= rs.getDouble("other_income") %></span>
                    </div>
                    <div class="item double-line">
                        <span><b>Total</b></span>
                        <span class="value"><%= rs.getDouble("sales_revenue") + rs.getDouble("other_income") %></span>
                    </div>
                </div>
            </div>


            <!-- Cost of Goods Sold Section -->
            <div class="section">
                <h2>Cost of Goods Sold (COGS)</h2>
                <div class="section-content">
                    <div class="item">
                        <span>COGS</span>
                        <span class="value"><%= rs.getDouble("cogs") %></span>
                    </div>
                    <div class="item double-line">
                        <span><b>Total</b></span>
                        <span class="value"><%= rs.getDouble("cogs") %></span>
                    </div>
                </div>
            </div>

            <!-- Operating Expenses Section -->
            <div class="section">
                <h2>Operating Expenses</h2>
                <div class="section-content">
                    <div class="item">
                        <span>Salaries & Wages</span>
                        <span class="value"><%= rs.getDouble("salaries_wages") %></span>
                    </div>
                    <div class="item">
                        <span>Rent & Utilities</span>
                        <span class="value"><%= rs.getDouble("rent_utilities") %></span>
                    </div>
                    <div class="item">
                        <span>Marketing</span>
                        <span class="value"><%= rs.getDouble("marketing") %></span>
                    </div>
                    <div class="item">
                        <span>Insurance</span>
                        <span class="value"><%= rs.getDouble("insurance") %></span>
                    </div>
                    <div class="item">
                        <span>Travel & Entertainment</span>
                        <span class="value"><%= rs.getDouble("travel_entertainment") %></span>
                    </div>
                    <div class="item double-line">
                        <span><b>Total</b></span>
                        <span class="value"><%= rs.getDouble("salaries_wages")+ rs.getDouble("rent_utilities")+ rs.getDouble("marketing")+rs.getDouble("insurance")+rs.getDouble("travel_entertainment")%></span>
                    </div>
                </div>
            </div>

            <!-- Asset and Other Expenses Section -->
            <div class="section">
                <h2>Assets & Other Expenses</h2>
                <div class="section-content">
                    <div class="item">
                        <span>Depreciation</span>
                        <span class="value"><%= rs.getDouble("depreciation") %></span>
                    </div>
                    <div class="item">
                        <span>Lease Payments</span>
                        <span class="value"><%= rs.getDouble("lease_payments") %></span>
                    </div>
                    <div class="item">
                        <span>Asset Purchases</span>
                        <span class="value"><%= rs.getDouble("asset_purchases") %></span>
                    </div>
                    <div class="item">
                        <span>Renovation Costs</span>
                        <span class="value"><%= rs.getDouble("renovation_costs") %></span>
                    </div>
                    <div class="item double-line">
                        <span><b>Total</b></span>
                        <span class="value"><%= rs.getDouble("depreciation")+ rs.getDouble("lease_payments")+ rs.getDouble("asset_purchases")+rs.getDouble("renovation_costs")%></span>
                    </div>
                </div>
            </div>

            <!-- Taxes & Debt Section -->
            <div class="section">
                <h2>Taxes & Debt</h2>
                <div class="section-content">
                    <div class="item">
                        <span>Income Tax</span>
                        <span class="value"><%= rs.getDouble("income_tax") %></span>
                    </div>
                    <div class="item">
                        <span>Other Taxes</span>
                        <span class="value"><%= rs.getDouble("other_taxes") %></span>
                    </div>
                    <div class="item">
                        <span>Debt Repayments</span>
                        <span class="value"><%= rs.getDouble("debt_repayments") %></span>
                    </div>
                    <div class="item double-line">
                        <span><b>Total</b></span>
                        <span class="value"><%= rs.getDouble("income_tax")+ rs.getDouble("other_taxes")+ rs.getDouble("debt_repayments")%></span>
                    </div>
                </div>
            </div>

            <!-- Cash Flow Section -->
            <div class="section">
                <h2>Cash Flow Forecast</h2>
                <div class="section-content">
                    <div class="item">
                        <span>Cash Flow Forecast</span>
                        <span class="value"><%= rs.getDouble("cash_flow_forecast") %></span>
                    </div>
                    <div class="item double-line">
                        <span><b>Total</b></span>
                        <span class="value"><%= rs.getDouble("cash_flow_forecast") %></span>
                    </div>
                </div>
            </div>
            <div class="section">
                <h2 >Total Budget: <span class="value" style="color: white;"><%= rs.getDouble("total_sum") %></span></h2>

            </div>

            <% 
                }
                // Close connections
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>

            <div class="footer">
                <p>&copy; 2024 Company, All Rights Reserved.</p>
            </div>
        </div>

    </body>
</html>
