

<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>
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

<select
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



<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Cost Accounting ERP</a>
    </div>
</nav>

