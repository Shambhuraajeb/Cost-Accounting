<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Variance Analysis</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
            color: #1a237e;
        }

        .navbar {
            background-color: #1a237e;
        }

        .navbar-brand {
            color: #fff;
        }

        .container {
            margin-top: 50px;
        }

        .table-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .table thead th {
            background-color: #1a237e;
            color: white;
        }

        .table tbody tr:hover {
            background-color: #e9ecef;
        }
    </style>
</head>

<body>

    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Cost Accounting ERP</a>
        </div>
    </nav>

    <div class="container my-5">
        <div class="table-container">
            <h2>Variance Analysis</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Variance Id</th>
                        <th>Project Name</th>
                        <th>Budgeted Cost</th>
                        <th>Actual Cost</th>
                        <th>Variance</th>
                        <th>Variance Type</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Database connection setup
                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            // Load the MySQL driver and establish a connection
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");
                            stmt = con.createStatement();
                            
                            // SQL query with JOIN to get the variance and project details
                            String query = "SELECT v.variance_id, v.project_id, v.actual_cost, v.budgeted_cost, v.variance, vt.variance_type_name, p.project_name "
                                         + "FROM variance v "
                                         + "JOIN variance_type vt ON v.variance_type_id = vt.variance_type_id "
                                         + "JOIN project p ON v.project_id = p.project_id";
                            rs = stmt.executeQuery(query);

                            // Loop through the result set and display each record
                            while (rs.next()) {
                                int varianceId = rs.getInt("variance_id");
                                int projectId = rs.getInt("project_id");
                                double actualCost = rs.getDouble("actual_cost");
                                double budgetedCost = rs.getDouble("budgeted_cost");
                                double variance = rs.getDouble("variance");
                                String varianceType = rs.getString("variance_type_name");
                                String projectName = rs.getString("project_name"); // Get the project name

                    %>
                                <tr>
                                    <td><%= varianceId %></td>
                                    <td><%= projectName %></td>
                                    <td>$<%= budgetedCost %></td>
                                    <td>$<%= actualCost %></td>
                                    <td>$<%= variance %></td>
                                    <td><%= varianceType %></td>
                                </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            // Close the database connection
                            try {
                                if (con != null) {
                                    con.close();
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
