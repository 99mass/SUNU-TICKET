import 'package:get/get.dart';
import 'package:sunu_ticket_pro/features/bus_management/data/repositories/bus_repository.dart';

class DashboardController extends GetxController {
  final currentTabIndex = 0.obs;

  // Mock Data for Stats
  final dailyRevenue = 150000.obs;
  final activeBuses = 4.obs;
  final totalPassengers = 45.obs;

  // Activité Récente - chargée dynamiquement
  final recentActivities = <Map<String, dynamic>>[].obs;

  // Bus en activité aujourd'hui
  final myBuses = <Map<String, dynamic>>[].obs;

  // Repository
  final BusRepository _busRepository = BusRepository();

  @override
  void onInit() {
    super.onInit();
    loadBusesAndActivities();
  }

  /// Génère les activités récentes basées sur les bus
  void _generateRecentActivities(List<Map<String, dynamic>> buses) {
    final activities = <Map<String, dynamic>>[];

    // Générer des activités de départ et arrivée pour chaque bus
    for (final bus in buses) {
      final plateNumber = bus['plateNumber'] as String;
      final line = bus['line'] as String;
      final departureTime = bus['departureTime'] as String?;

      // Activité de départ
      if (departureTime != null) {
        activities.add({
          'title': 'Départ Bus $plateNumber',
          'subtitle': line,
          'time': departureTime,
          'type': 'departure',
          'amount': 0,
        });
      }

      // Activité d'arrivée (environ 8 heures après le départ)
      if (departureTime != null) {
        final parts = departureTime.split(':');
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);

        hour = (hour + 8) % 24;
        final arrivalTime =
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

        activities.add({
          'title': 'Descente Bus $plateNumber',
          'subtitle': 'Terminus / Arrêt final',
          'time': arrivalTime,
          'type': 'arrival',
          'amount': 0,
        });
      }
    }

    // Trier par heure de départ
    activities.sort((a, b) {
      final timeA = a['time'] as String;
      final timeB = b['time'] as String;
      return timeA.compareTo(timeB);
    });

    recentActivities.value = activities;
  }

  /// Charge les bus avec date de départ aujourd'hui et génère les activités
  Future<void> loadBusesAndActivities() async {
    try {
      final buses = await _busRepository.loadBuses();
      final today = DateTime.now();
      final todayString =
          '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      // Filtrer les bus avec date de départ = aujourd'hui
      final busesToday = buses
          .where((bus) => bus.departureDate == todayString)
          .map((bus) => bus.toMap())
          .toList();

      myBuses.value = busesToday;

      // Générer les activités récentes
      _generateRecentActivities(busesToday);
    } catch (e) {
      // Erreur lors du chargement
      myBuses.value = [];
      recentActivities.value = [];
    }
  }
}
