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
        
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Cost Accounting ERP</a>
            </div>
        </nav>

        <!-- Form Container -->
        <div class="container form-container">
            <h2 class="form-title">Allocation Base Entry</h2>
            <form action="/Cost/assistantserv/AllocationBase" method="post">
                <!-- Cost Element Information Section -->
                <div class="form-section">
                    <h5>Allocation Information</h5>
                    <div class="row">
                        <!-- Cost Element Name -->
                        <div class="col-md-6 mb-3">
                            <label for="costElementName" class="form-label">Allocation Base Name</label>
                            <input type="text" class="form-control" id="allocationBaseName" name="allocationBaseName"
                                   placeholder="Enter Allocation Base name" required>
                        </div>
                    </div>
                </div>

                <!-- Cost Type Section -->
                <div class="form-section">
                    <h5>Allocation Base Type</h5>
                    <label for="allocationBaseType" class="form-label">Allocation Base Type</label>
                    <select
                        class="form-control" id="allocationBaseType" name="allocationBaseType" required>
                        <option value="">Select Allocation Base Type</option>
                        <option value="Labor_Hours">Labor Hours</option>
                        <option value="Machine_Hours">Machine Hours</option>
                        <option value="Square_Feets">Square Feets</option>
                    </select>
                </div>


                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>