<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Transaction List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .transaction-table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                font-size: 1em;
                text-align: left;
            }
            .transaction-table th, .transaction-table td {
                padding: 12px;
                border: 1px solid #ddd;
            }
            .transaction-table th {
                background-color: #f4f4f4;
            }
            .btn-view-voucher {
                padding: 8px 12px;
                color: #fff;
                background-color: #4CAF50;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }
            .btn-view-voucher:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg" style="background-color: #1a237e;position: fixed; top: 0; width: 100%; z-index: 1000;">
            <div class="container-fluid">
                <a class="navbar-brand" href="#" style="color: #ffffff; font-weight: bold;">Cost Accounting ERP</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
        </nav>
        <h2>Transaction List</h2>

        <%
            // Database connection setup
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
        
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");
                stmt = conn.createStatement();
            
                String query = "SELECT t.transaction_id, t.transaction_no, t.amount, t.transaction_date, t.description, ce.cost_element_name, cc.classification_name FROM transaction t JOIN cost_element ce ON t.cost_element_id = ce.cost_element_id JOIN cost_classification cc ON t.cost_classification_id = cc.classification_id;";
                rs = stmt.executeQuery(query);
        %>

        <table class="transaction-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Transaction Number</th>
                    <th>Cost Element</th>
                    <th>Cost Classification</th>
                    <th>Amount</th>
                    <th>Transaction Date</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Loop through result set and display each row
                    while (rs.next()) {
                        String transactionId = rs.getString("transaction_id");
                %>
                <tr>
                    <td><%= transactionId %></td>
                    <td><%= rs.getString("transaction_no") %></td>
                    <td><%= rs.getString("cost_element_name") %></td>
                    <td><%= rs.getString("classification_name") %></td>
                    <td>$<%= rs.getString("amount") %></td>
                    <td><%= rs.getDate("transaction_date") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td>
                        <!-- Button to view voucher for this transaction -->
                        <form action="Voucher.jsp" method="get" style="display: inline;">
                            <input type="hidden" name="transaction_id" value="<%= transactionId %>">
                            <button type="submit" class="btn-view-voucher">View Voucher</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <%
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) { }
                try { if (stmt != null) stmt.close(); } catch (Exception e) { }
                try { if (conn != null) conn.close(); } catch (Exception e) { }
            }
        %>

    </body>
</html>
