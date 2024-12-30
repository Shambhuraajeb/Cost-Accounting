

<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Labor Hour Entry</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f6f9;
                font-family: Arial, sans-serif;
                color: #1a237e;
            }
            .form-container {
                margin-top: 30px;
                padding: 30px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .form-title {
                color: #1a237e;
                font-weight: bold;
                margin-bottom: 20px;
                border-bottom: 2px solid #1a237e;
                padding-bottom: 10px;
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
            .navbar {
                background-color: #1a237e;
            }
            .navbar-brand {
                color: #fff;
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
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Cost Accounting ERP</a>
            </div>
        </nav>

        <div class="container form-container">
            <h2 class="form-title">Labor Hour Entry</h2>
            <form action="/Cost/clerkserv/LabourHours" method="POST">
                <!-- Employee ID -->
                <div class="mb-3">
                    <label for="employeeId" class="form-label">Employee ID</label>
                    <input type="text" class="form-control" id="employeeId" name="employeeId" placeholder="Enter employee ID" required>
                </div>

                <!-- Project ID -->
                <div class="mb-3">
                    <label for="projectId" class="form-label">Project ID</label>
                    <select
                        class="form-control" id="product_id" name="projectId" required>
                        <option value="0">Select Project</option>
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

                <!-- Date -->
                <div class="mb-3">
                    <label for="entryDate" class="form-label">Date</label>
                    <input type="date" class="form-control" id="entryDate" name="entryDate" required>
                </div>

                <!-- Hours Worked -->
                <div class="mb-3">
                    <label for="hoursWorked" class="form-label">Hours Worked</label>
                    <input type="number" class="form-control" id="hoursWorked" name="hoursWorked" placeholder="Enter hours worked" required>
                </div>

                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Submit Hours</button>
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
