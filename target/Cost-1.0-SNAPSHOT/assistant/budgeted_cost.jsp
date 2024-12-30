<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ERP Product Entry</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f6f9;
                color: #333;
                font-family: Arial, sans-serif;
            }
            .navbar {
                background-color: #1a237e;
            }
            .navbar-brand {
                color: #fff;
            }
            .form-container {
                margin-top: 30px;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .form-title {
                color: #1a237e;
                border-bottom: 2px solid #1a237e;
                padding-bottom: 10px;
            }
            .form-section {
                background-color: #f8f9fa;
                padding: 15px;
                margin-bottom: 15px;
                border-radius: 8px;
                border: 1px solid #ced4da;
            }
            .form-section h5 {
                color: #343a40;
                margin-bottom: 15px;
            }
            .form-label {
                font-weight: bold;
            }
            .btn-primary {
                background-color: #1a237e;
                border-color: #1a237e;
                font-weight: bold;
            }
            .btn-primary:hover {
                background-color: #1a237e;
                border-color: #1a237e;
            }
        </style>
    </head>
    <body>
        <%
            // Create a single database connection
            Connection con = null;
            try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");
            } catch (Exception e) {
                    e.printStackTrace();
            }
        %>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Cost Accounting ERP</a>
            </div>
        </nav>

        <!-- Form Container -->
        <div class="container form-container">
            <h2 class="form-title">Budgeted Cost Entry</h2>
            <form method="post" action="/Cost/assistantserv/BudgetedCost">
                <!-- Project Information Section -->
                <div class="form-section">
                    <h5>Project Information</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="projectId" class="form-label">Project ID</label>
                            <select
                                class="form-control" id="projectId" name="projectId" required>
                                <option value="">Select Project</option>
                                <%
                                // Fetch products from the database
                                try {
                                        Statement stmt = con.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT project_id, project_name FROM project");

                                        while (rs.next()) {
                                                int id = rs.getInt("project_id");
                                                String name = rs.getString("project_name");
                                                out.println("<option value='" + id + "'>" + name + "</option>");
                                        }
                                } catch (Exception e) {
                                        e.printStackTrace();
                                }
                                %>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Product Information Section -->
                <div class="form-section">
                    <h5>Product Information</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="productName" class="form-label">Cost Element</label>
                            <select
                                class="form-control" id="costElementId" name="costElementId" required>
                                <option value="">Select Project</option>
                                <%
                                // Fetch products from the database
                                try {
                                        Statement stmt = con.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT cost_element_id, cost_element_name FROM cost_element");

                                        while (rs.next()) {
                                                int id = rs.getInt("cost_element_id");
                                                String name = rs.getString("cost_element_name");
                                                out.println("<option value='" + id + "'>" + name + "</option>");
                                        }
                                } catch (Exception e) {
                                        e.printStackTrace();
                                }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter description" required></textarea>
                    </div>
                </div>

                <!-- Cost Information Section -->
                <div class="form-section">
                    <h5>Cost Information</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="budgetedCost" class="form-label">Budgeted Cost</label>
                            <input type="number" class="form-control" id="budgetedCost" name="budgetedCost" placeholder="Enter budgeted cost" required>
                        </div>

                    </div>
                </div>

                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary" style="background-color: #1a237e;">Submit Product</button>
                </div>
            </form>
        </div>
        <%
    // Close the database connection
    if (con != null) {
            try {
                    con.close();
            } catch (SQLException e) {
                    e.printStackTrace();
            }
    }
        %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
