import 'dart:math';
import 'package:sunu_ticket_pro/features/session_management/data/models/session_code_model.dart';

class SessionRepository {
  /// Génère un code aléatoire de 6 chiffres
  static String _generateRandomCode() {
    final random = Random();
    return List.generate(6, (_) => random.nextInt(10)).join();
  }

  /// Génère un ID unique pour la session
  static String _generateSessionId() {
    return 'session_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Génère un code d'accès pour un bus donné
  Future<SessionCode> generateAccessCode({
    required String busId,
    required String busMatricule,
    required String receiverName,
  }) async {
    try {
      // Simulation d'une requête réseau
      await Future.delayed(const Duration(milliseconds: 500));

      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 24));
      final code = _generateRandomCode();
      final sessionId = _generateSessionId();

      // Attribution de plage de tickets (1000 tickets par session)
      final ticketRangeStart = 8000;
      final ticketRangeEnd = 9000;

      final sessionCode = SessionCode(
        sessionId: sessionId,
        busId: busId,
        busMatricule: busMatricule,
        code: code,
        createdAt: now,
        expiresAt: expiresAt,
        status: 'active',
        ticketRangeStart: ticketRangeStart,
        ticketRangeEnd: ticketRangeEnd,
        currentTicketNumber: ticketRangeStart,
        receiverName: receiverName,
        isSynced: true,
        lastSync: now,
      );

      return sessionCode;
    } catch (e) {
      throw Exception('Erreur lors de la génération du code: $e');
    }
  }

  /// Valide un code d'accès
  bool validateCode(String code) {
    return code.length == 6 && int.tryParse(code) != null;
  }

  /// Vérifie si un code est expiré
  bool isCodeExpired(SessionCode sessionCode) {
    return sessionCode.isExpired;
  }

  /// Récupère les sessions actives (mock)
  Future<List<SessionCode>> getActiveSessions() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final now = DateTime.now();
      final tomorrow = now.add(const Duration(days: 1));

      return [
        SessionCode(
          sessionId: 'session_001',
          busId: 'bus_001',
          busMatricule: 'DK-001-AA',
          code: _generateRandomCode(),
          createdAt: now,
          expiresAt: tomorrow,
          status: 'active',
          ticketRangeStart: 8000,
          ticketRangeEnd: 9000,
          currentTicketNumber: 8347,
          receiverName: 'Moussa Diop',
          isSynced: true,
          lastSync: now,
        ),
        SessionCode(
          sessionId: 'session_002',
          busId: 'bus_002',
          busMatricule: 'DK-204-BB',
          code: _generateRandomCode(),
          createdAt: now,
          expiresAt: tomorrow,
          status: 'active',
          ticketRangeStart: 5000,
          ticketRangeEnd: 6000,
          currentTicketNumber: 5623,
          receiverName: 'Alioune Fall',
          isSynced: true,
          lastSync: now,
        ),
      ];
    } catch (e) {
      throw Exception('Erreur lors de la récupération des sessions: $e');
    }
  }

  /// Récupère l'historique des sessions (mock)
  Future<List<SessionCode>> getSessionHistory() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final yesterdayEnd = yesterday.add(const Duration(hours: 18));

      return [
        SessionCode(
          sessionId: 'session_h_001',
          busId: 'bus_001',
          busMatricule: 'DK-001-AA',
          code: _generateRandomCode(),
          createdAt: yesterday,
          expiresAt: yesterdayEnd,
          status: 'expired',
          ticketRangeStart: 7000,
          ticketRangeEnd: 8000,
          currentTicketNumber: 7412,
          receiverName: 'Moussa Diop',
          isSynced: true,
          lastSync: yesterdayEnd,
        ),
      ];
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l\'historique: $e');
    }
  }
}
