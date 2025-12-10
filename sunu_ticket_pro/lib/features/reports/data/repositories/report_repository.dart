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

      // Take the first 2 reports and set them to today, regardless of their original dates
      final List<Map<String, dynamic>> todayReports = jsonList.take(2).map((
        json,
      ) {
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

        // Update validation time if it exists
        if (modifiedJson['validatedAt'] != null) {
          final validatedTime = DateTime.parse(modifiedJson['validatedAt']);
          final todayValidatedTime = DateTime(
            today.year,
            today.month,
            today.day,
            validatedTime.hour,
            validatedTime.minute,
            validatedTime.second,
          );
          modifiedJson['validatedAt'] = todayValidatedTime.toIso8601String();
        }

        return modifiedJson;
      }).toList();

      final List<ReportModel> reports = todayReports
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

      // Take reports after the first 2 (which are used for today) and set them to past dates
      final List<Map<String, dynamic>> pastReports = jsonList.skip(2).map((
        json,
      ) {
        final Map<String, dynamic> modifiedJson = Map.from(json);

        // For demo purposes, distribute reports to past days
        final reportIndex =
            jsonList.indexOf(json) - 2; // Adjust index since we skipped first 2
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

        // Update validation time if it exists
        if (modifiedJson['validatedAt'] != null) {
          final validatedTime = DateTime.parse(modifiedJson['validatedAt']);
          final reportValidatedTime = DateTime(
            reportDate.year,
            reportDate.month,
            reportDate.day,
            validatedTime.hour,
            validatedTime.minute,
            validatedTime.second,
          );
          modifiedJson['validatedAt'] = reportValidatedTime.toIso8601String();
        }

        return modifiedJson;
      }).toList();

      final List<ReportModel> reports = pastReports
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
