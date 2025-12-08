import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/bus_model.dart';

class BusRepository {
  /// Génère une date au format YYYY-MM-DD
  static String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Charge les données mock depuis le fichier JSON
  Future<Map<String, dynamic>> _loadMockData() async {
    try {
      final jsonString = await rootBundle.loadString(
        'lib/features/bus_management/data/datasources/mock_data/buses.json',
      );
      return jsonDecode(jsonString);
    } catch (e) {
      // Si le fichier n'est pas trouvé, retourner les données hardcodées
      final today = DateTime.now();
      final tomorrow = today.add(const Duration(days: 1));
      final todayStr = _formatDate(today);
      final tomorrowStr = _formatDate(tomorrow);

      return {
        "buses": [
          {
            "id": "1",
            "plateNumber": "DK-001-AA",
            "line": "Ligne 5",
            "driver": "Moussa Diop",
            "status": "En service",
            "seats": 45,
            "departureDate": todayStr,
            "departureTime": "08:30",
            "sections": [
              {"sectionNumber": 1, "price": 150},
              {"sectionNumber": 2, "price": 200},
              {"sectionNumber": 3, "price": 300},
            ],
          },
          {
            "id": "2",
            "plateNumber": "DK-204-BB",
            "line": "Ligne 12",
            "driver": "Alioune Fall",
            "status": "En service",
            "seats": 50,
            "departureDate": todayStr,
            "departureTime": "10:00",
            "sections": [
              {"sectionNumber": 1, "price": 100},
              {"sectionNumber": 2, "price": 150},
            ],
          },
          {
            "id": "3",
            "plateNumber": "DK-890-CC",
            "line": "Ligne 3",
            "driver": "Cheikh Ndiaye",
            "status": "Garage",
            "seats": 45,
            "departureDate": todayStr,
            "departureTime": "14:00",
            "sections": [
              {"sectionNumber": 1, "price": 200},
              {"sectionNumber": 2, "price": 250},
              {"sectionNumber": 3, "price": 300},
              {"sectionNumber": 4, "price": 150},
            ],
          },
          {
            "id": "4",
            "plateNumber": "DK-456-DD",
            "line": "Ligne 7",
            "driver": "Amadou Sow",
            "status": "En service",
            "seats": 48,
            "departureDate": tomorrowStr,
            "departureTime": "16:30",
            "sections": [
              {"sectionNumber": 1, "price": 120},
              {"sectionNumber": 2, "price": 180},
            ],
          },
        ],
      };
    }
  }

  /// Charger tous les bus
  Future<List<Bus>> loadBuses() async {
    try {
      final data = await _loadMockData();
      final List<dynamic> busesData = data['buses'] ?? [];

      return busesData
          .map((bus) => Bus.fromJson(bus as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des bus: $e');
    }
  }

  /// Ajouter un bus
  Future<void> addBus(Bus bus) async {
    // À implémenter avec une vraie base de données
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Mettre à jour un bus
  Future<void> updateBus(String id, Bus bus) async {
    // À implémenter avec une vraie base de données
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Supprimer un bus
  Future<void> deleteBus(String id) async {
    // À implémenter avec une vraie base de données
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
