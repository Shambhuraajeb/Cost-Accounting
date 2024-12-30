<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Project</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: Arial, sans-serif;
        }
        .form-container {
            margin-top: 50px;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-container">
        <h2>Edit Project</h2>
        
        <%
            int projectId = Integer.parseInt(request.getParameter("id"));
            String projectName = "", description = "", budgetAmount = "";
            Date startDate = null, endDate = null;
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");
                
                // Fetch project details
                String query = "SELECT * FROM project WHERE project_id = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, projectId);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                    projectName = rs.getString("project_name");
                    startDate = rs.getDate("start_date");
                    endDate = rs.getDate("end_date");
                    description = rs.getString("description");
                    budgetAmount = rs.getString("budget_amount");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
        
        <form action="/Cost/accountantserv/UpdateProject" method="post">
            <input type="hidden" name="project_id" value="<%= projectId %>">
            <div class="form-group">
                <label for="projectName">Project Name</label>
                <input type="text" class="form-control" id="projectName" name="project_name" value="<%= projectName %>" required>
            </div>
            <div class="form-group">
                <label for="startDate">Start Date</label>
                <input type="date" class="form-control" id="startDate" name="start_date" value="<%= startDate %>" required>
            </div>
            <div class="form-group">
                <label for="endDate">End Date</label>
                <input type="date" class="form-control" id="endDate" name="end_date" value="<%= endDate %>" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3" required><%= description %></textarea>
            </div>
            <div class="form-group">
                <label for="budgetAmount">Budget Amount</label>
                <input type="text" class="form-control" id="budgetAmount" name="budget_amount" value="<%= budgetAmount %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a href="project.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
