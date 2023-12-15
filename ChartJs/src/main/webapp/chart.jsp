<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.chartjs.DataAccessObject" %>

<html>
<head>
    <title>Chart Example</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="container mt-5">

<%
    DataAccessObject dao = new DataAccessObject();
    List<Map<String, Object>> pieChartData = dao.getChartData();
    List<Map<String, Object>> barChartData = dao.getChartData2();
%>

<div class="row">
    <!-- Pie Chart -->
    <div class="col-md-6">
        <canvas id="pieChart" width="400" height="400"></canvas>
    </div>

    <!-- Bar Chart -->
    <div class="col-md-6">
        <canvas id="barChart" width="400" height="400"></canvas>
    </div>
</div>

<script>
    function generateBrightColors(count) {
        var colors = [];
        for (var i = 0; i < count; i++) {
            var r = Math.floor(Math.random() * 150 + 100); // Red channel (100-250)
            var g = Math.floor(Math.random() * 150 + 100); // Green channel (100-250)
            var b = Math.floor(Math.random() * 150 + 100); // Blue channel (100-250)
            colors.push('rgba(' + r + ',' + g + ',' + b + ', 2)');
        }
        return colors;
    }

    // Convert Java List to JavaScript array for pie chart
    var pieChartData = [
        <% for (int i = 0; i < pieChartData.size(); i++) { %>
            { "vendor": "<%= pieChartData.get(i).get("vendor") %>", "count": <%= pieChartData.get(i).get("count") %> }<%= i < pieChartData.size() - 1 ? "," : "" %>
        <% } %>
    ];

    var pieLabels = pieChartData.map(function (item) { return item.vendor; });
    var pieData = pieChartData.map(function (item) { return item.count; });

    var pieCtx = document.getElementById('pieChart').getContext('2d');
    var pieChart = new Chart(pieCtx, {
        type: 'bar',
        data: {
            labels: pieLabels,
            datasets: [
                {
                    label: 'Vendor Count',
                    data: pieData,
                    backgroundColor: generateBrightColors(pieChartData.length),
                    borderColor: generateBrightColors(pieChartData.length).map(color => color.replace("0.2", "1")),
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Convert Java List to JavaScript array for bar chart
    var barChartData = [
        <% for (int i = 0; i < barChartData.size(); i++) { %>
            { "circle": "<%= barChartData.get(i).get("circle") %>", "count": <%= barChartData.get(i).get("count") %> }<%= i < barChartData.size() - 1 ? "," : "" %>
        <% } %>
    ];

    var barLabels = barChartData.map(function (item) { return item.circle; });
    var barData = barChartData.map(function (item) { return item.count; });

    var barCtx = document.getElementById('barChart').getContext('2d');
    var barChart = new Chart(barCtx, {
        type: 'bar',
        data: {
            labels: barLabels,
            datasets: [
                {
                    label: 'Circle Count',
                    data: barData,
                    backgroundColor: generateBrightColors(barChartData.length),
                    borderColor: generateBrightColors(barChartData.length).map(color => color.replace("0.2", "1")),
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

</body>
</html>
