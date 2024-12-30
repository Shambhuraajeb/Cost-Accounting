<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Product</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f4f6f9;
                font-family: Arial, sans-serif;
            }
            .form-container {
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
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Edit Product</h2>

            <div class="form-container">
                <%
                    // Retrieve the product_id from the URL
                    String productId = request.getParameter("id");
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");

                        // Prepare SQL query to fetch product details by product_id
                        String query = "SELECT * FROM product WHERE product_id = ?";
                        ps = conn.prepareStatement(query);
                        ps.setInt(1, Integer.parseInt(productId));
                        rs = ps.executeQuery();

                        String productName = "";
                        String description = "";
                        int projectId = 0;
                        double budgetedCost = 0;

                        if (rs.next()) {
                            productName = rs.getString("product_name");
                            description = rs.getString("description");
                            projectId = rs.getInt("project_id");
                            budgetedCost = rs.getDouble("budgeted_cost");
                        }
                %>

                <!-- Form for editing product -->
                <form action="UpdateProductServlet" method="post">
                    <div class="form-group">
                        <label for="productName">Product Name</label>
                        <input type="text" class="form-control" id="productName" name="product_name" value="<%= productName %>" required>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required><%= description %></textarea>
                    </div>

                    <div class="form-group">
                        <label for="projectId">Project</label>
                        <select class="form-control" id="projectId" name="project_id" required>
                            <%
                                // Fetch the list of projects for the dropdown
                                String projectQuery = "SELECT project_id, project_name FROM project";
                                Statement stmt = conn.createStatement();
                                ResultSet projectRs = stmt.executeQuery(projectQuery);

                                // Populate the dropdown with projects
                                while (projectRs.next()) {
                                    int projId = projectRs.getInt("project_id");
                                    String projName = projectRs.getString("project_name");
                            %>
                            <option value="<%= projId %>" <%= projId == projectId ? "selected" : "" %>><%= projName %></option>
                            <%
                                }
                                projectRs.close();
                                stmt.close(); // Ensure statement is closed here
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="budgetedCost">Budgeted Cost</label>
                        <input type="number" class="form-control" id="budgetedCost" name="budgeted_cost" step="0.01" value="<%= budgetedCost %>" required>
                    </div>

                    <input type="hidden" name="product_id" value="<%= productId %>">
                    <button type="submit" class="btn btn-primary">Update Product</button>
                </form>

                <%
                        } else {
                            out.println("<p>Product not found!</p>");
                        }

        if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (conn != null) conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error occurred while retrieving the product.</p>");
                    } 
                %>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>