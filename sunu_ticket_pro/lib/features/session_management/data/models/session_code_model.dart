class SessionCode {
  final String sessionId;
  final String busId;
  final String busMatricule;
  final String code; // 6 chiffres aléatoires
  final DateTime createdAt;
  final DateTime expiresAt;
  final String status; // active, expired
  final int ticketRangeStart;
  final int ticketRangeEnd;
  final int currentTicketNumber;
  final String receiverName;
  final bool isSynced;
  final DateTime? lastSync;

  SessionCode({
    required this.sessionId,
    required this.busId,
    required this.busMatricule,
    required this.code,
    required this.createdAt,
    required this.expiresAt,
    required this.status,
    required this.ticketRangeStart,
    required this.ticketRangeEnd,
    required this.currentTicketNumber,
    required this.receiverName,
    required this.isSynced,
    this.lastSync,
  });

  factory SessionCode.fromJson(Map<String, dynamic> json) {
    return SessionCode(
      sessionId: json['session_id'] as String? ?? '',
      busId: json['bus_id'] as String? ?? '',
      busMatricule: json['bus_matricule'] as String? ?? '',
      code: json['code'] as String? ?? '',
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
      expiresAt: DateTime.parse(
        json['expires_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] as String? ?? 'active',
      ticketRangeStart: json['ticket_range_start'] as int? ?? 0,
      ticketRangeEnd: json['ticket_range_end'] as int? ?? 0,
      currentTicketNumber: json['current_ticket_number'] as int? ?? 0,
      receiverName: json['receiver_name'] as String? ?? '',
      isSynced: json['is_synced'] as bool? ?? false,
      lastSync: json['last_sync'] != null
          ? DateTime.parse(json['last_sync'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'bus_id': busId,
      'bus_matricule': busMatricule,
      'code': code,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
      'status': status,
      'ticket_range_start': ticketRangeStart,
      'ticket_range_end': ticketRangeEnd,
      'current_ticket_number': currentTicketNumber,
      'receiver_name': receiverName,
      'is_synced': isSynced,
      'last_sync': lastSync?.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() => toJson();

  factory SessionCode.fromMap(Map<String, dynamic> map) =>
      SessionCode.fromJson(map);

  /// Vérifie si la session est expirée
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Retourne le temps restant en minutes
  int get minutesRemaining {
    final remaining = expiresAt.difference(DateTime.now()).inMinutes;
    return remaining > 0 ? remaining : 0;
  }

  /// Calcule le nombre de tickets vendus
  int get ticketsSold => currentTicketNumber - ticketRangeStart;

  /// Calcule le nombre de tickets disponibles
  int get ticketsAvailable => ticketRangeEnd - currentTicketNumber;
}
