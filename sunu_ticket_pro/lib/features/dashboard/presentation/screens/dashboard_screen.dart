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
                              child: Text(
                                "Bus en service Aujourd'hui",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildMyBusesList(),
                        const SizedBox(height: 20),
                        Text(
                          "Activité Récente",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
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
      bottomNavigationBar: _buildBottomNavigationBar(context),
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
          colors: [AppColors.gradientStart, Color(0xFF06407A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.to(() => ProfileScreen()),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundImage:
                        NetworkImage(
                              'https://www.pngall.com/wp-content/uploads/15/User-PNG-Images-HD.png',
                            )
                            as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Bonjour",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      Text("👋", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  Obx(
                    () => Text(
                      authController.currentUser.value?.name ?? "Utilisateur",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: const [
                Icon(Icons.notifications, color: Colors.white, size: 30),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: Text("5", style: TextStyle(fontSize: 10)),
                  ),
                ),
              ],
            ),
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
              AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Obx(
            () => _buildStatCard(
              "Passagers",
              "${dashboardController.totalPassengers.value}",
              Icons.people_alt,
              AppColors.textSecondary,
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
        borderRadius: BorderRadius.circular(8),
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
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  Get.to(() => BusManagementScreen());
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
          final statusColor = bus['status'] == 'En service'
              ? Colors.green
              : AppColors.textSecondary;

          return InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.05 * 255).toInt()),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withAlpha(
                                      (0.1 * 255).toInt(),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.directions_bus,
                                    size: 18,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  bus['plateNumber'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.route,
                                  size: 14,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Ligne: ${bus['line']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Text(
                          bus['status'],
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        "Chauffeur: ${bus['driver']}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        "Chauffeur: ${bus['receiver']}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Obx(() {
      return Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.1 * 255).toInt()),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: List.generate(4, (index) {
            final isSelected =
                dashboardController.currentTabIndex.value == index;
            final icons = [
              Icons.dashboard,
              Icons.directions_bus,
              Icons.analytics,
              Icons.people,
            ];
            final labels = ['Accueil', 'Bus', 'Rapport', 'Personnel'];

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  dashboardController.currentTabIndex.value = index;
                },
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    if (isSelected)
                      Container(height: 2, color: AppColors.primary),
                    Container(
                      height: 78,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icons[index],
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            labels[index],
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
