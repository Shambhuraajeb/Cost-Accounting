<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<%
    //response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    //response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    //response.setDateHeader("Expires", 0); // Proxies

    // Check if user is logged in by verifying the session
    if (session.getAttribute("username") == null) {
        response.sendRedirect("/Costing/index.jsp"); // Redirect to login if session is null
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cost Accounting Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #eef2f3;
            color: #495057;
        }

        .navbar {
            background-color: #1a237e;
        }

        .navbar-brand {
            color: #ffffff;
            font-weight: bold;
        }

        .dashboard-section {
            padding: 20px;
            border-radius: 10px;
            background-color: #ffffff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

        .dashboard-section:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 30px rgba(0, 0, 0, 0.2);
        }

        .dashboard-section h4 {
            color: #1a237e;
            margin-bottom: 15px;
        }

        .btn-primary {
            margin-top: auto;
            background-color: #1a237e;
            border: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #1a237e;
        }

        .container h1 {
            color: #1a237e;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .container p {
            color: #6c757d;
        }

        .dashboard-section p {
            margin-bottom: 15px;
            flex-grow: 1;
        }

        .row.g-4 {
            margin-top: 30px;
        }

        @media (max-width: 768px) {
            .dashboard-section {
                margin-bottom: 20px;
            }
        }
    </style>
</head>

<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Cost Accounting ERP</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row g-4">
            <!-- Dashboard Section Header -->
            <div class="col-12">
                <h1>Welcome to the Cost Accounting ERP Dashboard</h1>
                <p>Select a module to manage your cost accounting tasks</p>
            </div>

            

            <!-- Cost Entry Section -->
            <div class="col-md-4">
                <div class="dashboard-section card">
                    <h4>Cost Element Entry</h4>
                    <p>Input and categorize direct, indirect, and overhead costs.</p>
                    <a href="cost_element.jsp" class="btn btn-primary">Go to Cost Entry</a>
                </div>
            </div>

            <!-- Product Budgeted cost Section -->
            <div class="col-md-4">
                <div class="dashboard-section card">
                    <h4>Budgeted Cost</h4>
                    <p>Allocate budgeted cost of each products.</p>
                    <a href="budgeted_cost.jsp" class="btn btn-primary">Allocate Cost</a>
                </div>
            </div>

            <!-- Cost Classification Section -->
            <div class="col-md-4">
                <div class="dashboard-section card">
                    <h4>Cost Classification</h4>
                    <p>Classify costs into direct, indirect, and overhead categories.</p>
                    <a href="cost_classification.jsp" class="btn btn-primary">Classify Costs</a>
                </div>
            </div>

            <!-- Cost Allocation Section -->
            <div class="col-md-4">
                <div class="dashboard-section card">
                    <h4>Cost Allocation</h4>
                    <p>Allocate costs based on different allocation bases.</p>
                    <a href="allocation_base.jsp" class="btn btn-primary">Allocate Costs</a>
                </div>
            </div>

            <!-- Cost Calculation Section -->
            <div class="col-md-4">
                <div class="dashboard-section card">
                    <h4>Cost Calculation</h4>
                    <p>Calculate costs for various products and projects.</p>
                    <a href="cost_report.jsp" class="btn btn-primary">Calculate Costs</a>
                </div>
            </div>
            
            <!-- Product Report Section -->
            <div class="col-md-4">
                <div class="dashboard-section card">
                    <h4>Product Report</h4>
                    <p>View and analyze cost reports for products.</p>
                    <a href="report.jsp" class="btn btn-primary">View Report</a>
                </div>
            </div>

            <!-- Variance Analysis Section -->
            <div class="col-md-4">
                <div class="dashboard-section card">
                    <h4>Variance Analysis</h4>
                    <p>Analyze the difference between actual and budgeted costs.</p>
                    <a href="variance_analyze.jsp" class="btn btn-primary">Analyze Variance</a>
                </div>
            </div>

            


        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>