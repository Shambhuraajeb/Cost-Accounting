<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: Arial, sans-serif;
        }
        .table-container {
            margin-top: 30px;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
     <!-- Navbar -->
     <nav class="navbar navbar-expand-lg" style="background-color: #1a237e;">
        <div class="container-fluid">
            <a class="navbar-brand" href="#" style="color: #ffffff; font-weight: bold;">Cost Accounting ERP</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>

<div class="container">
    <div class="header">
        <h2>Project List</h2>
        <a href="project.html" class="btn btn-primary">Create New Project</a>
    </div>

    <div class="table-container">
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>Project ID</th>
                    <th>Project Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Description</th>
                    <th>Budget Amount</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM project");

                        while (rs.next()) {
                            int projectId = rs.getInt("project_id");
                            String projectName = rs.getString("project_name");
                            java.sql.Date startDate = rs.getDate("start_date");
                            java.sql.Date endDate = rs.getDate("end_date");
                            String description = rs.getString("description");
                            String budget_amount = rs.getString("budget_amount");
                %>
                <tr>
                    <td><%= projectId %></td>
                    <td><%= projectName %></td>
                    <td><%= startDate %></td>
                    <td><%= endDate %></td>
                    <td><%= description %></td>
                    <td><%= budget_amount %></td>
                    <td><a href="EditProject.jsp?id=<%= projectId %>" class="btn btn-sm btn-secondary">Edit</a></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger' role='alert'>Error loading projects: " + e.getMessage() + "</div>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
