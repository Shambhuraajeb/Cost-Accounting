<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GST Details Form</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f4f4f4;
            padding: 20px;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .gst-form {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .form-column {
            width: 45%;
        }

        .form-column.full {
            width: 100%;
        }

        .form-row {
            margin-bottom: 15px;
        }

        label {
            display: inline-block;
            width: 60%;
            font-weight: bold;
        }

        input, select {
            width: 35%;
            padding: 5px;
            font-size: 16px;
            margin-left: 10px;
        }

        button {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            font-size: 18px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-header">
            <h1>GST Registration Details</h1>
        </div>
        <form class="gst-form">
            <div class="form-column">
                <div class="form-row">
                    <label for="state">State:</label>
                    <select id="state">
                        <option value="Maharashtra" selected>Maharashtra</option>
                        <!-- Add more states as necessary -->
                    </select>
                </div>

                <div class="form-row">
                    <label for="registrationType">Registration Type:</label>
                    <select id="registrationType">
                        <option value="Regular" selected>Regular</option>
                        <option value="Composition">Composition</option>
                    </select>
                </div>

                <div class="form-row">
                    <label for="assessee">Assessee of Other Territory:</label>
                    <select id="assessee">
                        <option value="No" selected>No</option>
                        <option value="Yes">Yes</option>
                    </select>
                </div>

                <div class="form-row">
                    <label for="gstApplicable">GST applicable from:</label>
                    <input type="date" id="gstApplicable" value="2024-04-01">
                </div>

                <div class="form-row">
                    <label for="gstin">GSTIN/UIN:</label>
                    <input type="text" id="gstin" placeholder="Enter GSTIN/UIN">
                </div>

                <div class="form-row">
                    <label for="periodicity">Periodicity of GSTR1:</label>
                    <select id="periodicity">
                        <option value="Monthly" selected>Monthly</option>
                        <option value="Quarterly">Quarterly</option>
                    </select>
                </div>
            </div>

            <div class="form-column">
                <div class="form-row">
                    <label for="ewayBill">e-Way Bill applicable:</label>
                    <select id="ewayBill">
                        <option value="Yes" selected>Yes</option>
                        <option value="No">No</option>
                    </select>
                </div>

                <div class="form-row">
                    <label for="applicableFrom">Applicable from:</label>
                    <input type="date" id="applicableFrom" value="2024-04-01">
                </div>

                <div class="form-row">
                    <label for="thresholdLimit">Threshold limit:</label>
                    <input type="text" id="thresholdLimit" value="50,000">
                </div>

                <div class="form-row">
                    <label for="printEwayBill">Print e-Way Bill with Invoice:</label>
                    <select id="printEwayBill">
                        <option value="No" selected>No</option>
                        <option value="Yes">Yes</option>
                    </select>
                </div>

                <div class="form-row">
                    <label for="eInvoice">e-Invoicing applicable:</label>
                    <select id="eInvoice">
                        <option value="No" selected>No</option>
                        <option value="Yes">Yes</option>
                    </select>
                </div>
            </div>

            <div class="form-column full">
                <button type="submit">Submit</button>
            </div>
        </form>
    </div>
</body>
</html>