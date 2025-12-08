import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunu_ticket_pro/core/constants/app_colors.dart';
import 'package:sunu_ticket_pro/features/auth/presentation/controllers/auth_controller.dart';
import 'package:sunu_ticket_pro/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:sunu_ticket_pro/features/profile/presentation/screens/profile_screen.dart';
import 'package:sunu_ticket_pro/features/reports/presentation/screens/reports_screen.dart';
import 'package:sunu_ticket_pro/features/bus_management/presentation/screens/bus_management_screen.dart';
import 'package:sunu_ticket_pro/features/personnel_management/presentation/screens/personnel_management_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final DashboardController dashboardController = Get.put(
    DashboardController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Obx(() {
        switch (dashboardController.currentTabIndex.value) {
          case 0:
            return Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildStatsCards(),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Bus en activité Aujourd'hui",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  // TODO: Navigate to full bus list
                                },
                                child: const Text("Voir tout"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildMyBusesList(),
                        const SizedBox(height: 28),
                        Text(
                          "Activité Récente",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildRecentActivityList(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          case 1:
            return BusManagementScreen();
          case 2:
            return const ReportsScreen();
          case 3:
            return const PersonnelManagementScreen();
          default:
            return Container();
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: dashboardController.currentTabIndex.value,
          onTap: (index) {
            dashboardController.currentTabIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus),
              label: 'Bus',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Rapport',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Personnel',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, Color(0xFF06407A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bonjour,",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Obx(
                    () => Text(
                      authController.currentUser.value?.name ?? "Utilisateur",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Get.to(() => ProfileScreen()),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary.withAlpha(
                      (0.1 * 255).toInt(),
                    ),
                    child: const Icon(Icons.person, color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => _buildStatCard(
              "Recettes",
              "${dashboardController.dailyRevenue.value} F",
              Icons.monetization_on,
              Colors.green,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Obx(
            () => _buildStatCard(
              "Passagers",
              "${dashboardController.totalPassengers.value}",
              Icons.people,
              Colors.orange,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha((0.1 * 255).toInt()),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityList() {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashboardController.recentActivities.length,
        itemBuilder: (context, index) {
          final activity = dashboardController.recentActivities[index];
          final isDeparture = activity['type'] == 'departure';
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDeparture
                        ? AppColors.primary.withAlpha((0.1 * 255).toInt())
                        : AppColors.secondary.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isDeparture
                        ? Icons.departure_board
                        : Icons.arrow_circle_down,
                    color: isDeparture
                        ? AppColors.primary
                        : AppColors.secondary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      if (activity['subtitle'] != null)
                        Text(
                          activity['subtitle'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      Text(
                        activity['time'],
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMyBusesList() {
    return Obx(() {
      if (dashboardController.myBuses.isEmpty) {
        return Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(
                Icons.directions_bus_outlined,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                "Aucun bus en activité",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to create bus
                },
                icon: const Icon(Icons.add),
                label: const Text("Ajouter un bus"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashboardController.myBuses.length,
        itemBuilder: (context, index) {
          final bus = dashboardController.myBuses[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.05 * 255).toInt()),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.directions_bus,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bus['plateNumber'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${bus['line']} • ${bus['driver']}",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: bus['status'] == 'En service'
                        ? Colors.green.withAlpha((0.1 * 255).toInt())
                        : Colors.orange.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    bus['status'],
                    style: TextStyle(
                      color: bus['status'] == 'En service'
                          ? Colors.green
                          : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
