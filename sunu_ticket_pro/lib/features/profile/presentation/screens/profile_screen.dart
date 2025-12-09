import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunu_ticket_pro/core/constants/app_colors.dart';
import 'package:sunu_ticket_pro/features/auth/presentation/controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Informations Personnelles
            _buildSection(
              title: "Informations Personnelles",
              children: [
                Obx(
                  () => _buildInfoItem(
                    icon: Icons.person_outline,
                    label: "Nom complet",
                    value: authController.currentUser.value?.name ?? "N/A",
                  ),
                ),
                _buildDivider(),
                Obx(
                  () => _buildInfoItem(
                    icon: Icons.phone_outlined,
                    label: "Téléphone",
                    value: authController.currentUser.value?.phone ?? "N/A",
                  ),
                ),
                _buildDivider(),
                Obx(
                  () => _buildInfoItem(
                    icon: Icons.business_outlined,
                    label: "GIE/Entreprise",
                    value:
                        authController.currentUser.value?.gieCompanies?.join(
                          ', ',
                        ) ??
                        "Non renseigné",
                  ),
                ),
                _buildDivider(),
                _buildInfoItem(
                  icon: Icons.location_on_outlined,
                  label: "Adresse",
                  value: "Dakar, Sénégal",
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Finances
            _buildSection(
              title: "Finances",
              children: [
                _buildInfoItem(
                  icon: Icons.account_balance_wallet_outlined,
                  label: "Moyens de paiement",
                  value: "Orange Money",
                ),
                _buildDivider(),
                _buildActionItem(
                  icon: Icons.history,
                  title: "Historique des transactions",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Application
            _buildSection(
              title: "Application",
              children: [
                _buildActionItem(
                  icon: Icons.notifications_outlined,
                  title: "Notifications",
                  onTap: () {},
                ),
                _buildDivider(),
                _buildActionItem(
                  icon: Icons.help_outline,
                  title: "Aide & Support",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Logout
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.03 * 255).toInt()),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.logout, color: Colors.red),
                ),
                title: const Text(
                  "Se déconnecter",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                onTap: () => _showLogoutDialog(context),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.03 * 255).toInt()),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha((0.05 * 255).toInt()),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha((0.05 * 255).toInt()),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[100],
      indent: 60,
      endIndent: 20,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Déconnexion",
      middleText: "Êtes-vous sûr de vouloir vous déconnecter ?",
      textConfirm: "Oui",
      textCancel: "Annuler",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      cancelTextColor: Colors.black,
      onConfirm: () {
        Get.back();
        authController.logout();
      },
    );
  }
}
