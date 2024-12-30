<%@ page import="java.sql.*, javax.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Year for Budget</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        select, button {
            padding: 10px;
            font-size: 1.2em;
            margin-top: 10px;
            width: 100%;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Select Year to View Budget</h2>
    <form action="budgetShow.jsp" method="get">
        <label for="year">Choose a Year:</label>
        <select name="year" id="year" required>
            <option value="" disabled selected>Select a Year</option>

            <%
                // Establish database connection
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String url = "jdbc:mysql://localhost:3306/cost";
                String username = "root";
                String password = "";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, username, password);
                    String sql = "SELECT DISTINCT year FROM company_budget ORDER BY year DESC";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    // Loop through the result set and populate the dropdown
                    while (rs.next()) {
                        int year = rs.getInt("year");
            %>
                        <option value="<%= year %>"><%= year %></option>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </select>

        <button type="submit">View Budget</button>
    </form>
</div>

</body>
</html>
