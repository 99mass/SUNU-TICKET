import 'package:get/get.dart';
import 'package:sunu_ticket_pro/features/session_management/data/models/session_code_model.dart';
import 'package:sunu_ticket_pro/features/session_management/data/repositories/session_repository.dart';

class SessionController extends GetxController {
  final SessionRepository _sessionRepository = SessionRepository();

  // Sessions actives
  final activeSessions = <SessionCode>[].obs;

  // Historique des sessions
  final sessionHistory = <SessionCode>[].obs;

  // Code généré récemment
  final generatedCode = Rx<SessionCode?>(null);

  // État de chargement
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadActiveSessions();
  }

  /// Charge les sessions actives
  Future<void> loadActiveSessions() async {
    try {
      isLoading.value = true;
      final sessions = await _sessionRepository.getActiveSessions();
      activeSessions.value = sessions;
    } catch (e) {
      // Erreur lors du chargement
      activeSessions.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  /// Charge l'historique des sessions
  Future<void> loadSessionHistory() async {
    try {
      isLoading.value = true;
      final history = await _sessionRepository.getSessionHistory();
      sessionHistory.value = history;
    } catch (e) {
      // Erreur lors du chargement
      sessionHistory.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  /// Génère un code d'accès pour un bus
  Future<SessionCode?> generateAccessCode({
    required String busId,
    required String busMatricule,
    required String receiverName,
  }) async {
    try {
      isLoading.value = true;
      final code = await _sessionRepository.generateAccessCode(
        busId: busId,
        busMatricule: busMatricule,
        receiverName: receiverName,
      );
      generatedCode.value = code;
      // Ajouter à la liste des sessions actives
      activeSessions.add(code);
      return code;
    } catch (e) {
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Valide un code
  bool validateCode(String code) {
    return _sessionRepository.validateCode(code);
  }

  /// Vérifie si un code est expiré
  bool isCodeExpired(SessionCode sessionCode) {
    return _sessionRepository.isCodeExpired(sessionCode);
  }

  /// Obtient une session par son code
  SessionCode? getSessionByCode(String code) {
    try {
      return activeSessions.firstWhere((session) => session.code == code);
    } catch (e) {
      return null;
    }
  }

  /// Réinitialise le code généré
  void resetGeneratedCode() {
    generatedCode.value = null;
  }
}
