<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Company Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                color: #495057;
            }
            .navbar {
                background-color: #1a237e;
            }
            .navbar-brand {
                color: #ffffff;
                font-weight: bold;
            }
            .container {
                margin-top: 50px;
            }
            .profile-card {
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                background-color: #ffffff;
            }
            .profile-label {
                font-weight: bold;
            }
            .btn-primary {
                background-color: #1a237e;
                border: none;
                font-weight: bold;
            }
            .btn-primary:hover {
                background-color: #1a237e;
            }
            .modal-header {
                background-color: #1a237e;
                color: white;
            }
            @media (max-width: 768px) {
                .profile-card {
                    margin: 0 10px;
                }
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

        <div class="container">
            <h1 class="text-center">Company Profile</h1>
            <div class="profile-card">
                <h4>Company Details</h4>

                <%
                    String dbURL = "jdbc:mysql://localhost:3306/cost";
                    String username = "root";
                    String password = "";
                
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(dbURL, username, password);
                        String sql = "SELECT * FROM companydetails WHERE company_id = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, 1); // assuming the company ID is 1 for now
                        rs = pstmt.executeQuery();
                    
                        if (rs.next()) {
                            String companyName = rs.getString("company_name");
                            String financialYearStart = rs.getString("financial_year_start");
                            String mailingName = rs.getString("mailing_name");
                            String booksStart = rs.getString("books_start");
                            String address = rs.getString("address");
                            String state = rs.getString("state");
                            String country = rs.getString("country");
                            String pincode = rs.getString("pincode");
                            String telephone = rs.getString("telephone");
                            String mobile = rs.getString("mobile");
                            String fax = rs.getString("fax");
                            String email = rs.getString("email");
                            String website = rs.getString("website");
                            String currencySymbol = rs.getString("base_currency_symbol");
                            String currencyName = rs.getString("formal_currency_name");
                %>

                <div class="row">
                    <div class="col-md-6">
                        <p><span class="profile-label">Company Name:</span> <%= companyName %></p>
                        <p><span class="profile-label">Financial Year Start:</span> <%= financialYearStart %></p>
                        <p><span class="profile-label">Mailing Name:</span> <%= mailingName %></p>
                        <p><span class="profile-label">Books Start:</span> <%= booksStart %></p>
                        <p><span class="profile-label">Address:</span> <%= address %></p>
                    </div>
                    <div class="col-md-6">
                        <p><span class="profile-label">State:</span> <%= state %></p>
                        <p><span class="profile-label">Country:</span> <%= country %></p>
                        <p><span class="profile-label">Pincode:</span> <%= pincode %></p>
                        <p><span class="profile-label">Telephone:</span> <%= telephone %></p>
                        <p><span class="profile-label">Mobile:</span> <%= mobile %></p>
                    </div>
                </div>
                <hr>
                <h4>Contact Information</h4>
                <p><span class="profile-label">Fax:</span> <%= fax %></p>
                <p><span class="profile-label">Email:</span> <a href="mailto:<%= email %>"><%= email %></a></p>
                <p><span class="profile-label">Website:</span> <a href="<%= website %>" target="_blank"><%= website %></a></p>
                <p><span class="profile-label">Base Currency Symbol:</span> <%= currencySymbol %></p>
                <p><span class="profile-label">Formal Currency Name:</span> <%= currencyName %></p>

                <% 
                        } 
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    } finally {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
                %>

                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal">
                    Edit Profile
                </button>
            </div>
        </div>

        <!-- Edit Profile Modal -->
        <!-- (The modal form code remains unchanged) -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
