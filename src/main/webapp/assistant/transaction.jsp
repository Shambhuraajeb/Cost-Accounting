<%@ page import="java.sql.*, java.util.*"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

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
    <title>Transaction Entry - ERP Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #eaeaea;
        }
        .navbar {
            background-color: #1a237e;
            padding: 10px;
        }
        .navbar-brand {
            color: #fff;
            font-weight: bold;
        }
        .form-section {
            background-color: #ffffff;
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
        }
        h1 {
            font-size: 18px;
            margin-bottom: 20px;
            color: #1a237e;
        }
        .form-label {
            font-size: 12px;
            font-weight: bold;
        }
        .form-control {
            font-size: 12px;
            padding: 5px;
        }
        .row {
            margin-bottom: 10px;
        }
        .btn {
            background-color: #1a237e;
            color: white;
            padding: 10px 20px;
            font-size: 14px;
            width: 100%;
            font-weight: bold;
        }
        .btn:hover {
            background-color: #0d1745;
        }
        .input-group-text {
            font-size: 12px;
            font-weight: bold;
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
            <a class="navbar-brand" href="#">ERP Transaction Entry</a>
        </div>
    </nav>

    <!-- Transaction Entry Form -->
    <div class="container">
        <div class="form-section">
            <h1>Enter Transaction</h1>
            <form id="transactionForm" action="/Cost/assistantserv/SubmitTransaction"
					method="post">
					<div class="row">
						<div class="col-md-6">
							<label for="transaction_id" class="form-label">Transaction
								ID</label> <input type="text" class="form-control" id="transaction_id"
								name="transaction_id" placeholder="Auto-generated" value="" readonly>
						</div>
						<div class="col-md-6">
							<label for="cost_element_id" class="form-label">Cost
								Element ID</label> <select class="form-control" id="cost_element_id"
								name="cost_element_id" required>
								<option value="">Select Cost Element</option>
								<%
								// Fetch cost elements from the database
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

					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="cost_type" class="form-label">Cost
								Classification</label> <select class="form-control" id="cost_type"
								name="cost_classification_id" required>
								<option value="">Select Cost Classification</option>
								<%
								// Fetch cost types from the database
								try {
									Statement stmt = con.createStatement();
									ResultSet rs = stmt.executeQuery("SELECT classification_id, classification_name FROM cost_classification");

									while (rs.next()) {
										int id = rs.getInt("classification_id");
										String name = rs.getString("classification_name");
										out.println("<option value='" + id + "'>" + name + "</option>");
									}
								} catch (Exception e) {
									e.printStackTrace();
								}
								%>
							</select>
						</div>
						<div class="col-md-6">
							<label for="project_id" class="form-label">Project ID</label> <select
								class="form-control" id="project_id" name="project_id" required>
								<option value="">Select Project</option>
								<%
								// Fetch projects from the database
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
					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="product_id" class="form-label">Product ID</label> <select
								class="form-control" id="product_id" name="product_id" required>
								<option value="">Select Product</option>
								<%
								// Fetch products from the database
								try {
									Statement stmt = con.createStatement();
									ResultSet rs = stmt.executeQuery("SELECT product_id, product_name FROM product");

									while (rs.next()) {
										int id = rs.getInt("product_id");
										String name = rs.getString("product_name");
										out.println("<option value='" + id + "'>" + name + "</option>");
									}
								} catch (Exception e) {
									e.printStackTrace();
								}
								%>
							</select>
						</div>
						<div class="col-md-6">
							<label for="allocation_base_id" class="form-label">Allocation
								Base ID</label> <select class="form-control" id="allocation_base_id"
								name="allocation_base_id" required>
								<option value="">Select Allocation Base</option>
								<%
								// Fetch allocation bases from the database
								try {
									Statement stmt = con.createStatement();
									ResultSet rs = stmt.executeQuery("SELECT allocation_base_id, base_name FROM allocation_base");

									while (rs.next()) {
										int id = rs.getInt("allocation_base_id");
										String name = rs.getString("base_name");
										out.println("<option value='" + id + "'>" + name + "</option>");
									}
								} catch (Exception e) {
									e.printStackTrace();
								}
								%>
							</select>
						</div>


					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="transaction_date" class="form-label">Transaction
								Date</label> <input type="date" class="form-control"
								id="transaction_date" name="transaction_date" required>
						</div>
						<div class="col-md-6">
							<label for="amount" class="form-label">Amount</label> <input
								type="number" class="form-control" id="amount" name="amount"
								required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<label for="description" class="form-label">Description</label>
							<textarea class="form-control" id="description"
								name="description" rows="3"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 mt-3">
							<button type="submit" class="btn">Submit</button>
						</div>
					</div>
				</form>
        </div>
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
    <script>
        // Simulating Transaction ID auto-generation (for demonstration purposes)
        document.addEventListener('DOMContentLoaded', function () {
            const transactionIdField = document.getElementById('transaction_id');
            transactionIdField.value = 'TXN' + Math.floor(Math.random() * 1000000);
        });

        
    </script>
</body>
</html>
