<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cost Calculation Table</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .table-container {
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .table thead th {
            background-color: #1a237e;
            color: white;
        }

        .table tbody tr:hover {
            background-color: #e9ecef;
        }

        h1 {
            text-align: center;
            color: #1a237e;
            margin-bottom: 20px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .button-container button {
            margin: 0 10px;
        }
    </style>
</head>

<body>

<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cost", "root", "");
        stmt = con.createStatement();
        String query = "SELECT * FROM cost_calculation";
        rs = stmt.executeQuery(query);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #1a237e;">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Cost Management System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>

<div class="table-container">
    <h1>Cost Calculation Summary</h1>
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th scope="col">Cost Calculation ID</th>
                <th scope="col">Project ID</th>
                <th scope="col">Total Direct Cost</th>
                <th scope="col">Total Indirect Cost</th>
                <th scope="col">Total Overhead Cost</th>
                <th scope="col">Total Cost</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    while (rs != null && rs.next()) {
                        // Extract data from each row in the ResultSet
                        String id = rs.getString("cost_calculation_id");
                        String projectId = rs.getString("project_id");
                        double totalDirectCost = rs.getDouble("total_direct_cost");
                        double totalIndirectCost = rs.getDouble("total_indirect_cost");
                        double totalOverheadCost = rs.getDouble("total_overhead_cost");
                        double totalCost = rs.getDouble("total_cost");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= projectId %></td>
                <td>RS <%= String.format("%.2f", totalDirectCost) %></td>
                <td>RS <%= String.format("%.2f", totalIndirectCost) %></td>
                <td>RS <%= String.format("%.2f", totalOverheadCost) %></td>
                <td>RS <%= String.format("%.2f", totalCost) %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (con != null) try { con.close(); } catch (SQLException ignore) {}
                }
            %>
        </tbody>
    </table>

    <div class="button-container">
        <button class="btn btn-primary" onclick="printTable()">Print Table</button>
        <button class="btn btn-success" onclick="shareTable()">Share Table</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function printTable() {
        const printWindow = window.open('', '_blank', 'height=600,width=800');
        printWindow.document.write('<html><head><title>Print Table</title>');
        printWindow.document.write('<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">');
        printWindow.document.write('</head><body >');
        printWindow.document.write(document.querySelector('.table-container').innerHTML);
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        printWindow.print();
    }

    function shareTable() {
        alert("Share functionality is not implemented yet.");
    }
</script>

</body>
</html>
