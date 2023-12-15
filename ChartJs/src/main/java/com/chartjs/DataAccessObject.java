
package com.chartjs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataAccessObject {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/REPORTS_DB";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "1553";

    public List<Map<String, Object>> getChartData	() {
        List<Map<String, Object>> chartData = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                System.out.println("DB is Connected");
                String sql = "SELECT VENDOR FROM DVC_SUMMARY_DATA";
                try (PreparedStatement statement = connection.prepareStatement(sql);
                     ResultSet resultSet = statement.executeQuery()) {
                    System.out.println("ResultSet is Executed");

                    Map<String, Integer> vendorCounts = new HashMap<>();

                    while (resultSet.next()) {
                        String vendor = resultSet.getString("VENDOR");

                        // Update the count in the map
                        vendorCounts.put(vendor, vendorCounts.getOrDefault(vendor, 0) + 1);
                    }

                    // Convert vendor counts to a list of maps
                    for (Map.Entry<String, Integer> entry : vendorCounts.entrySet()) {
                        Map<String, Object> dataPoint = new HashMap<>();
                        dataPoint.put("vendor", entry.getKey());
                        dataPoint.put("count", entry.getValue());

                        chartData.add(dataPoint);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return chartData;
    }

    
    
    
    
    public List<Map<String, Object>> getChartData2() {
        List<Map<String, Object>> chartData2 = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                System.out.println("DB is Connected");
                String sql = "SELECT CIRCLE FROM DVC_SUMMARY_DATA";
                try (PreparedStatement statement = connection.prepareStatement(sql);
                     ResultSet resultSet = statement.executeQuery()) {
                    System.out.println("2 ResultSet is Executed");

                    Map<String, Integer> circleCounts = new HashMap<>();

                    while (resultSet.next()) {
                        String circle = resultSet.getString("CIRCLE");

                        // Update the count in the map
                        circleCounts.put(circle, circleCounts.getOrDefault(circle, 0) + 1);
                    }

                    // Convert vendor counts to a list of maps
                    for (Map.Entry<String, Integer> entry : circleCounts.entrySet()) {
                        Map<String, Object> dataPoint2 = new HashMap<>();
                        dataPoint2.put("circle", entry.getKey());
                        dataPoint2.put("count", entry.getValue());

                        chartData2.add(dataPoint2);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return chartData2;
    }
   

}