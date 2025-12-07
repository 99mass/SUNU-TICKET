import 'package:flutter/material.dart';
import 'package:sunu_ticket_pro/core/constants/app_colors.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rapports"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildReportCard(
            context,
            "Rapport Journalier",
            "Aujourd'hui, 7 Déc",
            Icons.today,
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            context,
            "Rapport Hebdomadaire",
            "Semaine 49",
            Icons.calendar_view_week,
            Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            context,
            "Rapport Mensuel",
            "Novembre 2025",
            Icons.calendar_month,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha((0.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          // TODO: Navigate to detailed report
        },
      ),
    );
  }
}
