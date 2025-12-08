import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../data/repositories/bus_repository.dart';

class BusController extends GetxController {
  // Liste des bus
  final buses = <Map<String, dynamic>>[].obs;

  // Statuts possibles
  final statusList = ['En service', 'Garage', 'En maintenance'].obs;

  // Repository
  final BusRepository _busRepository = BusRepository();

  @override
  void onInit() {
    super.onInit();
    loadBusesFromJson();
  }

  Future<void> loadBusesFromJson() async {
    try {
      final busesList = await _busRepository.loadBuses();
      buses.value = busesList.map((bus) => bus.toMap()).toList();
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
