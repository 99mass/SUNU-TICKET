import 'package:get/get.dart';

class DashboardController extends GetxController {
  final currentTabIndex = 0.obs;

  // Mock Data for Stats
  final dailyRevenue = 150000.obs;
  final activeBuses = 4.obs;
  final totalPassengers = 45.obs;

  // Mock Data for Recent Activity
  // User requested only "Départ" and "Descente"
  final recentActivities = <Map<String, dynamic>>[
    {
      'title': 'Départ Bus DK-001',
      'subtitle': 'Ligne 5 - Yoff',
      'time': '08:30',
      'type': 'departure',
      'amount': 0,
    },

    {
      'title': 'Départ Bus DK-204',
      'subtitle': 'Ligne 12 - Plateau',
      'time': '10:00',
      'type': 'departure',
      'amount': 0,
    },
    {
      'title': 'Descente Bus DK-001',
      'subtitle': 'Terminus Liberté 6',
      'time': '19:45',
      'type': 'arrival',
      'amount': 0,
    },
    {
      'title': 'Descente Bus DK-204',
      'subtitle': 'Arrêt Colobane',
      'time': '20:45',
      'type': 'arrival',
      'amount': 0,
    },
  ].obs;

  // Mock Data for My Buses
  final myBuses = <Map<String, dynamic>>[].obs;
}
