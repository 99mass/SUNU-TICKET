import 'package:get/get.dart';
import '../../../reports/data/models/report_model.dart';
import '../../../reports/data/repositories/report_repository.dart';

class ReportController extends GetxController {
  final ReportRepository _reportRepository = ReportRepository();

  final RxList<ReportModel> reports = <ReportModel>[].obs;
  final RxList<ReportModel> pastReports = <ReportModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxDouble totalRevenue = 0.0.obs;
  final RxDouble totalExpenses = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadReports();
  }

  Future<void> loadReports() async {
    try {
      isLoading.value = true;
      error.value = '';

      final fetchedReports = await _reportRepository.getTodayReports();
      reports.assignAll(fetchedReports);

      // Calculate totals
      totalRevenue.value = reports.fold(
        0.0,
        (sum, report) => sum + report.totalRevenue,
      );
      totalExpenses.value = reports.fold(
        0.0,
        (sum, report) => sum + report.totalExpenses,
      );
    } catch (e) {
      error.value = 'Erreur lors du chargement des rapports: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPastReports() async {
    try {
      isLoading.value = true;
      error.value = '';

      final fetchedPastReports = await _reportRepository.getPastReports();
      pastReports.assignAll(fetchedPastReports);
    } catch (e) {
      error.value = 'Erreur lors du chargement des rapports passés: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ReportModel>> getReportsByBusId(String busId) async {
    try {
      return await _reportRepository.getReportsByBusId(busId);
    } catch (e) {
      error.value = 'Erreur lors de la récupération des rapports du bus: $e';
      return [];
    }
  }

  // Computed properties for dashboard
  double get totalRevenueToday {
    return reports.fold(0.0, (sum, report) => sum + report.totalRevenue);
  }

  double get totalExpensesToday {
    return reports.fold(0.0, (sum, report) => sum + report.totalExpenses);
  }

  double get totalNetProfitToday {
    return reports.fold(0.0, (sum, report) => sum + report.netProfit);
  }

  int get totalTicketsSoldToday {
    return reports.fold(
      0,
      (sum, report) =>
          sum +
          report.ticketsBySection.values.fold(
            0,
            (sectionSum, tickets) => sectionSum + tickets,
          ),
    );
  }

  int get validatedReportsCount {
    return reports.where((report) => report.isValidated).length;
  }

  int get pendingReportsCount {
    return reports.where((report) => !report.isValidated).length;
  }
}
