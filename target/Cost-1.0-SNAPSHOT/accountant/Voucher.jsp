<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Transaction Voucher</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Georgia', serif;
            }

            body {
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #f2f2f2;
                height: 100vh;
                padding: 20px;
            }

            .voucher {
                width: 100%;
                max-width: 800px;
                background-color: #fff;
                border: 2px solid #333;
                padding: 30px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }

            .voucher-header {
                text-align: center;
                padding-bottom: 20px;
                border-bottom: 2px solid #333;
                margin-bottom: 20px;
            }

            .voucher-header h1 {
                font-size: 1.8em;
                margin-bottom: 5px;
            }

            .voucher-header p {
                font-size: 0.9em;
                color: #555;
            }

            .voucher-content {
                margin-bottom: 20px;
            }

            .voucher-row {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px dotted #888;
            }

            .voucher-row:last-child {
                border-bottom: none;
            }

            .voucher-label {
                font-weight: bold;
                color: #333;
                flex-basis: 40%;
            }

            .voucher-value {
                flex-basis: 60%;
                text-align: right;
                color: #555;
            }

            .voucher-footer {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
                font-size: 0.9em;
            }

            .signature {
                text-align: center;
                width: 40%;
            }

            .signature-line {
                border-top: 1px solid #333;
                margin-top: 40px;
                padding-top: 5px;
                color: #666;
            }
            .btn-print {
                padding: 10px 20px;
                color: #fff;
                background-color: #007bff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1em;
            }

            .btn-print:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="voucher">
            <!-- Header Section -->
            <div class="voucher-header">
                <h1>Transaction Voucher</h1>
                <p>Cost Accounting System</p>
                <p>Date: <%= new java.util.Date() %></p>
            </div>

            <!-- Fetching Data from Database -->
            <%
                String transactionId = request.getParameter("transaction_id");

                if (transactionId != null) {
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");

                        String query = "SELECT t.transaction_no, t.amount, t.transaction_date, t.description, p.project_name, pr.product_name, ab.base_name, ce.cost_element_name, cc.classification_name FROM transaction t JOIN cost_element ce ON t.cost_element_id = ce.cost_element_id JOIN cost_classification cc ON t.cost_classification_id = cc.classification_id JOIN project p ON t.project_id = p.project_id JOIN product pr ON t.product_id = pr.product_id JOIN allocation_base ab ON t.allocation_base_id = ab.allocation_base_id WHERE t.transaction_id = ?";
                    
                        stmt = conn.prepareStatement(query);
                        stmt.setString(1, transactionId);
                        rs = stmt.executeQuery();

                        if (rs.next()) {
            %>

            <!-- Content Section -->
            <div class="voucher-content">
              <!--  <div class="voucher-row">
                    <div class="voucher-label">Transaction ID:</div>
                    <div class="voucher-value"><%= transactionId %></div>
                </div>
               -->
                <div class="voucher-row">
                    <div class="voucher-label">Transaction Number:</div>
                    <div class="voucher-value"><%= rs.getString("transaction_no") %></div>
                </div>
                <div class="voucher-row">
                    <div class="voucher-label">Cost Element:</div>
                    <div class="voucher-value"><%= rs.getString("cost_element_name") %></div>
                </div>
                <div class="voucher-row">
                    <div class="voucher-label">Cost Classification:</div>
                    <div class="voucher-value"><%= rs.getString("classification_name") %></div>
                </div>
                <div class="voucher-row">
                    <div class="voucher-label">Project Name:</div>
                    <div class="voucher-value"><%= rs.getString("project_name") %></div>
                </div>
                <div class="voucher-row">
                    <div class="voucher-label">Product Name:</div>
                    <div class="voucher-value"><%= rs.getString("product_name") %></div>
                </div>
                <div class="voucher-row">
                    <div class="voucher-label">Allocation Base:</div>
                    <div class="voucher-value"><%= rs.getString("base_name") %></div>
                </div>
                <div class="voucher-row">
                    <div class="voucher-label">Amount:</div>
                    <div class="voucher-value">$<%= rs.getDouble("amount") %></div>
                </div>
                <div class="voucher-row">
                    <div class="voucher-label">Transaction Date:</div>
                    <div class="voucher-value"><%= rs.getDate("transaction_date") %></div>
                </div>
                <div class="voucher-row">
                    <div class="voucher-label">Description:</div>
                    <div class="voucher-value"><%= rs.getString("description") %></div>
                </div>
            </div>

            <!-- Footer Section -->
            <div class="voucher-footer">
                <div class="signature">
                    <p>Authorized Signature</p>
                    <div class="signature-line">Signature & Date</div>
                </div>
                <div class="signature">
                    <p>Received By</p>
                    <div class="signature-line">Signature & Date</div>
                </div>
            </div>
            <div style="text-align: center; margin-top: 20px;">
                <button onclick="printVoucher()" class="btn-print">Print Voucher</button>
            </div>

            <%
                        } else {
                            out.println("<p>No transaction found with ID " + transactionId + "</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception e) { }
                        try { if (stmt != null) stmt.close(); } catch (Exception e) { }
                        try { if (conn != null) conn.close(); } catch (Exception e) { }
                    }
                } else {
                    out.println("<p>Transaction ID not provided.</p>");
                }
            %>
            <script>
                function printVoucher() {
                    // Open the print dialog
                    window.print();
                }
            </script>
        </div>
    </body>
</html>
