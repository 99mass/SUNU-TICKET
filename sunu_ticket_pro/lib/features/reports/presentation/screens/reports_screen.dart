import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sunu_ticket_pro/core/constants/app_colors.dart';
import 'package:sunu_ticket_pro/features/reports/data/models/report_model.dart';
import 'package:sunu_ticket_pro/features/reports/presentation/controllers/report_controller.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final ReportController reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Rapports"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (reportController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (reportController.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  reportController.error.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => reportController.loadReports(),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        }

        if (reportController.reports.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.analytics_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  "Aucun rapport disponible",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Les rapports apparaîtront après validation",
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reports list
              Text(
                "Rapports du Jour",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reportController.reports.length,
                itemBuilder: (context, index) {
                  final report = reportController.reports[index];
                  return _buildReportCard(report);
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReportCard(ReportModel report) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showReportDetails(report),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.directions_bus,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.busPlateNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${report.busLine} • ${report.driverName}",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: report.isValidated
                        ? Colors.green.withAlpha((0.1 * 255).toInt())
                        : Colors.orange.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    report.statusText,
                    style: TextStyle(
                      color: report.isValidated ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${report.totalTicketsSold} tickets",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                Text(
                  "${report.netProfit.toInt()} F CFA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: report.netProfit >= 0 ? Colors.green : Colors.red,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showReportDetails(ReportModel report) {
    Get.bottomSheet(
      ReportDetailsSheet(report: report),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}

class ReportDetailsSheet extends StatelessWidget {
  final ReportModel report;

  const ReportDetailsSheet({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 60 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Détails du Rapport",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Basic info
            _buildDetailSection("Informations Générales", [
              _buildDetailRow("Bus", report.busPlateNumber),
              _buildDetailRow("Ligne", report.busLine),
              _buildDetailRow("Chauffeur", report.driverName),
              _buildDetailRow("Receveur", report.receiverName),
              _buildDetailRow("Date", report.formattedDate),
            ]),

            const SizedBox(height: 20),

            // Route info
            if (report.departureTime != null && report.arrivalTime != null)
              _buildDetailSection("Trajet", [
                _buildDetailRow(
                  "Départ",
                  "${report.formattedDepartureTime} - ${report.departureLocation ?? 'N/A'}",
                ),
                _buildDetailRow(
                  "Arrivée",
                  "${report.formattedArrivalTime} - ${report.arrivalLocation ?? 'N/A'}",
                ),
              ]),

            const SizedBox(height: 20),

            // Tickets section
            _buildDetailSection("Vente de Tickets", [
              _buildDetailRow("Total tickets", "${report.totalTicketsSold}"),
              _buildDetailRow(
                "Recettes totales",
                "${report.totalRevenue.toInt()} F CFA",
              ),
              const SizedBox(height: 12),
              const Text(
                "Répartition par section:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              ...report.ticketsBySection.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Section ${entry.key}",
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      Text(
                        "${entry.value} tickets",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ]),

            const SizedBox(height: 20),

            // Expenses section
            _buildDetailSection("Dépenses", [
              _buildDetailRow("Carburant", "${report.fuelCost.toInt()} F CFA"),
              _buildDetailRow("Panne", "${report.breakdownCost.toInt()} F CFA"),
              _buildDetailRow(
                "Dépannage",
                "${report.towingCost.toInt()} F CFA",
              ),
              _buildDetailRow(
                "Amende police",
                "${report.policePenaltyCost.toInt()} F CFA",
              ),
              _buildDetailRow(
                "Prime chauffeur",
                "${report.driverBonus.toInt()} F CFA",
              ),
              _buildDetailRow(
                "Prime receveur",
                "${report.receiverBonus.toInt()} F CFA",
              ),
              const Divider(height: 20, thickness: 1),
              _buildDetailRow(
                "Total dépenses",
                "${report.totalExpenses.toInt()} F CFA",
                isBold: true,
              ),
              _buildDetailRow(
                "Bénéfice net",
                "${report.netProfit.toInt()} F CFA",
                isBold: true,
                color: report.netProfit >= 0 ? Colors.green : Colors.red,
              ),
            ]),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isBold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
