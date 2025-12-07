import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:sunu_ticket_pro/features/bus_management/data/models/bus_model.dart';

class BusController extends GetxController {
  // Liste des bus
  final buses = <Map<String, dynamic>>[].obs;

  // Statuts possibles
  final statusList = ['En service', 'Garage', 'En maintenance'].obs;

  @override
  void onInit() {
    super.onInit();
    loadBusesFromJson();
  }

  Future<void> loadBusesFromJson() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/mocks/buses.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final List<dynamic> busesData = jsonMap['buses'] ?? [];

      buses.value = busesData
          .map((bus) => Bus.fromJson(bus as Map<String, dynamic>).toMap())
          .toList();
      debugPrint('✅ Bus chargés: ${buses.length} bus');
    } catch (e) {
      debugPrint('❌ Erreur lors du chargement des bus: $e');
    }
  }

  // Ajouter un bus
  void addBus(Map<String, dynamic> bus) {
    buses.add(bus);
  }

  // Supprimer un bus
  void deleteBus(String id) {
    buses.removeWhere((bus) => bus['id'] == id);
  }

  // Mettre à jour un bus
  void updateBus(String id, Map<String, dynamic> updatedBus) {
    final index = buses.indexWhere((bus) => bus['id'] == id);
    if (index != -1) {
      buses[index] = updatedBus;
      buses.refresh();
    }
  }
}
