import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/report_model.dart';

class ReportRepository {
  Future<List<ReportModel>> getTodayReports() async {
    try {
      // Load mock data from JSON file
      final String jsonString = await rootBundle.loadString(
        'lib/features/reports/data/datasources/mock_data/reports.json',
      );

      final List<dynamic> jsonList = json.decode(jsonString);
      final today = DateTime.now();

      // Modify the JSON data to set dates to today
      final List<Map<String, dynamic>> modifiedJsonList = jsonList.map((json) {
        final Map<String, dynamic> modifiedJson = Map.from(json);
        modifiedJson['date'] = today.toIso8601String();

        // Also update departure and arrival times to today if they exist
        if (modifiedJson['departureTime'] != null) {
          final departureTime = DateTime.parse(modifiedJson['departureTime']);
          final todayDepartureTime = DateTime(
            today.year,
            today.month,
            today.day,
            departureTime.hour,
            departureTime.minute,
            departureTime.second,
          );
          modifiedJson['departureTime'] = todayDepartureTime.toIso8601String();
        }

        if (modifiedJson['arrivalTime'] != null) {
          final arrivalTime = DateTime.parse(modifiedJson['arrivalTime']);
          final todayArrivalTime = DateTime(
            today.year,
            today.month,
            today.day,
            arrivalTime.hour,
            arrivalTime.minute,
            arrivalTime.second,
          );
          modifiedJson['arrivalTime'] = todayArrivalTime.toIso8601String();
        }

        return modifiedJson;
      }).toList();

      final List<ReportModel> reports = modifiedJsonList
          .map((json) => ReportModel.fromJson(json))
          .toList();

      return reports;
    } catch (e) {
      // Return empty list if there's an error
      return [];
    }
  }

  Future<List<ReportModel>> getPastReports() async {
    try {
      // Load mock data from JSON file
      final String jsonString = await rootBundle.loadString(
        'lib/features/reports/data/datasources/mock_data/reports.json',
      );

      final List<dynamic> jsonList = json.decode(jsonString);
      final now = DateTime.now();

      // Modify the JSON data to create past reports (yesterday and before)
      final List<Map<String, dynamic>> modifiedJsonList = jsonList.map((json) {
        final Map<String, dynamic> modifiedJson = Map.from(json);

        // For demo purposes, distribute reports to past days
        final reportIndex = jsonList.indexOf(json);
        final daysBack = (reportIndex % 7) + 1; // 1 to 7 days back
        final reportDate = now.subtract(Duration(days: daysBack));

        modifiedJson['date'] = reportDate.toIso8601String();

        // Also update departure and arrival times to the report date if they exist
        if (modifiedJson['departureTime'] != null) {
          final departureTime = DateTime.parse(modifiedJson['departureTime']);
          final reportDepartureTime = DateTime(
            reportDate.year,
            reportDate.month,
            reportDate.day,
            departureTime.hour,
            departureTime.minute,
            departureTime.second,
          );
          modifiedJson['departureTime'] = reportDepartureTime.toIso8601String();
        }

        if (modifiedJson['arrivalTime'] != null) {
          final arrivalTime = DateTime.parse(modifiedJson['arrivalTime']);
          final reportArrivalTime = DateTime(
            reportDate.year,
            reportDate.month,
            reportDate.day,
            arrivalTime.hour,
            arrivalTime.minute,
            arrivalTime.second,
          );
          modifiedJson['arrivalTime'] = reportArrivalTime.toIso8601String();
        }

        return modifiedJson;
      }).toList();

      final List<ReportModel> reports = modifiedJsonList
          .map((json) => ReportModel.fromJson(json))
          .toList();

      return reports;
    } catch (e) {
      // Return empty list if there's an error
      return [];
    }
  }

  Future<List<ReportModel>> getReportsByBusId(String busId) async {
    try {
      final reports = await getTodayReports();
      return reports.where((report) => report.busId == busId).toList();
    } catch (e) {
      return [];
    }
  }
}
