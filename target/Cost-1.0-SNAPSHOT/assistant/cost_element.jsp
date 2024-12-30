
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ERP Cost Element Entry</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f6f9;
                color: #1a237e;
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
            <h2 class="form-title">Cost Element Entry</h2>
            <form action="/Cost/assistantserv/CostElement" method="post" autocomplete="off">
                <!-- Cost Element Information Section -->
                <div class="form-section">
                    <h5>Cost Element Information</h5>
                    <div class="row">
                        <!-- Cost Element Name -->
                        <div class="col-md-6 mb-3">
                            <label for="costElementName" class="form-label">Cost Element Name</label>
                            <input type="text" name="costElementName" class="form-control" id="costElementName" placeholder="Enter cost element name" required>
                        </div>
                    </div>
                </div>

                <!-- Cost Type Section -->
                <div class="form-section">
                    <h5>Cost Type</h5>
                    <div class="mb-3">
                        <label for="costType" class="form-label">Cost Type</label>
                        <select
                            class="form-control" id="cost_type" name="cost_type" required>
                            <option value="">Select Cost Type</option>
                            <%
                            // Fetch products from the database
                            try {
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM `cost_element_type`");

                                    while (rs.next()) {
                                            int id = rs.getInt("id");
                                            String name = rs.getString("cost_element_type");
                                            out.println("<option value='" + id + "'>" + name + "</option>");
                                    }
                            } catch (Exception e) {
                                    e.printStackTrace();
                            }
                            %>
                        </select>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Submit Cost Element</button>
                </div>
            </form><br>
                        <i style="margin: 10px 0 0 450px;">Classify the cost element type click on below button</i><br>
            <button class="btn btn-primary" style="margin: 10px 0 0 570px;"><a href="cost_element_type.html" style="text-decoration: none; color: #fff;">Classify Type</a></button>
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
