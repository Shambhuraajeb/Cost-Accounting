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
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap CSS -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <title>Employee Dashboard</title>

        <style>
            body {
                background-color: #eaeaea;
            }

            /* Sidebar Styles */
            .sidebar {
                height: 100vh;
                width: 250px;
                position: fixed;
                top: 0;
                left: 0;
                background-color: #1a237e;
                padding-top: 20px;
                z-index: 2;
                overflow: hidden;
            }

            .sidebar a {
                padding: 15px 20px;
                /* Adjust padding to give more space */
                text-align: left;
                text-decoration: none;
                font-size: 18px;
                color: white;
                display: flex;
                align-items: center;
                transition: background-color 0.3s ease, padding-left 0.3s;
                margin-bottom: 10px;
                /* Add space between each sidebar option */
            }

            .sidebar a:hover {
                background-color: #575fcf;
            }

            .sidebar a span {
                margin-left: 15px;
                /* Increase the space between the icon and text */
            }

            .sidebar .logo {
                text-align: center;
                color: white;
                margin-bottom: 30px;
                padding: 20px 0;
            }

            .sidebar .logo img {
                width: 80px;
                border-radius: 50%;
                margin-bottom: 10px;
            }

            .main-content {
                margin-left: 270px;
                padding: 20px;
            }

            .navbar {
                background-color: #1a237e;
                padding: 10px;
                color: white;
            }

            .navbar-brand {
                color: white;
                font-weight: bold;
            }

            /* Transaction Form */
            .form-sec {
                background-color: #ffffff;
                padding: 20px;
                margin-top: 20px;
                box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
                transition: all 0.2s ease-in-out;
            }

            .form-sec:hover {
                transform: scale(1.02);
            }

            .form-label {
                font-size: 12px;
                font-weight: bold;
            }

            .form-control {
                font-size: 12px;
                padding: 5px;
            }

            .btn {
                background-color: #1a237e;
                color: white;
                padding: 10px;
                font-size: 14px;
                width: 100%;
                font-weight: bold;
                transition: background-color 0.2s ease;
            }

            .btn:hover {
                background-color: #0d1745;
            }

            /* Profile Card Design */
            .profile-card {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
                padding: 20px;
                transition: all 0.3s ease;
                margin-top: 20px;
            }

            .profile-header {
                font-size: 28px;
                font-weight: bold;
                color: #1a237e;
                border-bottom: 2px solid #1a237e;
                padding-bottom: 10px;
                margin-bottom: 20px;
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

        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="logo">
                <img src="img/logo.webp" alt="Logo">
                <!-- Placeholder logo -->
                <h2>ERP</h2>
            </div>
            <a href="#" id="transaction-link" class="nav-item"> <i
                    class="bi bi-cash-coin"></i> <span>Transaction</span>
            </a> <a href="labour_hour.jsp" class="nav-item"> <i
                    class="bi bi-person"></i> <span>Labor Hour</span>
            </a>
            <a href="#" id="profile-link" class="nav-item"> <i
                    class="bi bi-person"></i> <span>Profile</span>
            </a><a href="/Cost/Logout" class="nav-item"> <i
                    class="bi bi-box-arrow-right"></i> <span style="color: red;">Logout</span>
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <nav class="navbar">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">ERP Dashboard</a>
                </div>
            </nav>

            <!-- Transaction Form -->
            <div class="container" id="transaction-section">
                <div class="form-sec">
                    <h1>Enter Transaction</h1>
                    <form id="transactionForm" action="/Cost/clerkserv/SubmitTransaction"
                          method="post">
                        <div class="row">
                            <div class="col-md-6">
                                <label for="transaction_id" class="form-label">Transaction
                                    ID</label> <input type="text" class="form-control" id="transaction_id"
                                                  name="transaction_id" placeholder="Auto-generated" value="" readonly="readonly">
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

            <!-- Profile Section -->
            <div class="container" id="profile-section" style="display: none;">
                <div class="profile-card">
                    <h2 class="profile-header">Profile Information</h2>
                    <p>
                        <strong>Username:</strong>
                        <%=session.getAttribute("username")%>
                    </p>
                    <p>
                        <strong>Email:</strong>
                        <%=session.getAttribute("email")%>
                    </p>
                    <p>
                        <strong>Role:</strong>
                        <%=session.getAttribute("role")%>
                    </p>
                    <p>
                        <strong>Last Login:</strong> Not available
                    </p>
                </div>
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

        <!-- Bootstrap JS and dependencies -->
        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
            integrity="sha384-wwO5+50t2XqR+Wg5x5+fsbt5aU9x/RI8aTgS6CM5C/dgh8H95a3g3boHpV4V2J6p"
            crossorigin="anonymous">

        </script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
            integrity="sha384-cJwbl4h8Q3Cd57xU7p3F5E3m6z5u8D6L/7ZW8Yj96nbU4yR+aS0fS43c/0cJ+8e6"
            crossorigin="anonymous">

        </script>

        <script>
            // Function to generate transaction ID
            function generateTransactionID() {
                return 'TXN' + Math.floor(Math.random() * 1000000);
            }

            document.addEventListener('DOMContentLoaded', () => {
                const transactionForm = document.getElementById('transactionForm');
                const transactionIDInput = document.getElementById('transaction_id');
                const transactionSection = document.getElementById('transaction-section');
                const profileSection = document.getElementById('profile-section');
                const transactionLink = document.getElementById('transaction-link');
                const profileLink = document.getElementById('profile-link');

                // Set initial Transaction ID
                transactionIDInput.value = generateTransactionID();

                // Switch between Transaction and Profile sections
                transactionLink.addEventListener('click', () => {
                    transactionSection.style.display = 'block';
                    profileSection.style.display = 'none';
                });

                profileLink.addEventListener('click', () => {
                    transactionSection.style.display = 'none';
                    profileSection.style.display = 'block';
                });


            });
        </script>
    </body>

</html>
