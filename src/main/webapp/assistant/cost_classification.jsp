<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cost Classification</title>
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
                margin-bottom: 20px;
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
            <h2 class="form-title">Cost Classification</h2>
            <form method="post" action="/Cost/assistantserv/CostClassification">
                <div class="mb-3">
                    <label for="costType" class="form-label">Cost Element</label>
                    <select
                        class="form-control" id="costElement" name="costElement" required>
                        <option value="">Select Cost Element</option>
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
                <div class="mb-3">
                    <label for="costElement" class="form-label">Cost Classification Name</label>
                    <input type="text" class="form-control" id="costClassification" name="costClassification" placeholder="Enter cost classification name" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Classify Cost</button>

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
