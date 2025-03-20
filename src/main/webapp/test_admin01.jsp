<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
        }
        .container {
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .chart-container {
            width: 50%;
            margin: 20px auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin Dashboard</h1>
        
        <!-- Table to display applications -->
        <h2>Application List</h2>
        <table>
            <thead>
                <tr>
                    <th>Application No</th>
                    <th>Employee ID</th>
                    <th>Manager Name</th>
                    <th>Source</th>
                    <th>Destination</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <!-- Rows will be dynamically populated by JavaScript -->
            </tbody>
        </table>

        <!-- Chart to display data -->
        <div class="chart-container">
            <canvas id="myChart"></canvas>
        </div>
    </div>

    <script>
        // Fetch applications data on page load
        document.addEventListener("DOMContentLoaded", function () {
            fetchApplications();
        });

        // Function to fetch applications from the servlet
        function fetchApplications() {
            fetch('./testAdminDash') // Replace 'YourAppName' with the actual context path
                .then(response => response.json())
                .then(data => {
                    updateTable(data);
                    updateChart(data);
                })
                .catch(error => console.error('Error fetching data:', error));
        }

        // Function to dynamically populate the table
        function updateTable(data) {
            const tableBody = document.querySelector("tbody");
            tableBody.innerHTML = ""; // Clear existing table rows

            for (const appNo in data) {
                const appDetails = data[appNo];
                const row = `
                    <tr>
                        <td>${appNo}</td>
                        <td>${appDetails.empId}</td>
                        <td>${appDetails.manager_name}</td>
                        <td>${appDetails.source}</td>
                        <td>${appDetails.Destination}</td>
                        <td>${appDetails.date}</td>
                    </tr>
                `;
                tableBody.innerHTML += row;
            }
        }

        // Function to dynamically update the chart
        function updateChart(data) {
            const xValues = Object.keys(data); // Application numbers
            const yValues = Object.values(data).map(app => app.admin_approve === "yes" ? 1 : 0); // Example: Admin-approved applications

            const ctx = document.getElementById("myChart").getContext("2d");

            // Destroy existing chart if it exists
            if (window.myChart) {
                window.myChart.destroy();
            }

            window.myChart = new Chart(ctx, {
                type: "doughnut",
                data: {
                    labels: xValues,
                    datasets: [{
                        backgroundColor: ["#00aba9", "#2b5797", "#b91d47", "#e8c3b9", "#1e7145"],
                        data: yValues
                    }]
                },
                options: {
                    title: {
                        display: true,
                        text: `Total Applications: ${xValues.length}`,
                        fontSize: 20
                    },
                    legend: {
                        labels: {
                            fontColor: "#333"
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>
