import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:sunu_ticket_pro/features/receiver_management/data/models/receiver_model.dart';

class ReceiverRepository {
  // Liste des receveurs en mémoire
  static final List<Receiver> _receivers = [];
  static bool _initialized = false;

  /// Initialise les receveurs depuis le JSON
  static Future<void> _initializeReceivers() async {
    if (_initialized) return;

    try {
      final jsonString = await rootBundle.loadString(
        'lib/features/receiver_management/data/datasources/mock_data/receivers.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      _receivers.clear();
      _receivers.addAll(
        jsonList.map((json) => Receiver.fromJson(json as Map<String, dynamic>)),
      );
      _initialized = true;
    } catch (e) {
      _loadMockData();
      _initialized = true;
    }
  }

  /// Fallback avec données en dur
  static void _loadMockData() {
    _receivers.clear();
    _receivers.addAll([
      Receiver(
        id: 'RCV001',
        name: 'Amadou Ndiaye',
        phoneNumber: '+221 77 123 45 67',
        status: 'active',
      ),
      Receiver(
        id: 'RCV002',
        name: 'Fatou Sall',
        phoneNumber: '+221 77 234 56 78',
        status: 'active',
      ),
      Receiver(
        id: 'RCV003',
        name: 'Moussa Diallo',
        phoneNumber: '+221 77 345 67 89',
        status: 'active',
      ),
    ]);
  }

  /// Récupère tous les receveurs actifs
  Future<List<Receiver>> getActiveReceivers() async {
    await _initializeReceivers();
    try {
      return _receivers
          .where((receiver) => receiver.status == 'active')
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Récupère tous les receveurs
  Future<List<Receiver>> getAllReceivers() async {
    await _initializeReceivers();
    try {
      return List.from(_receivers);
    } catch (e) {
      return [];
    }
  }

  /// Récupère un receveur par ID
  Future<Receiver?> getReceiverById(String id) async {
    await _initializeReceivers();
    try {
      return _receivers.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Crée un nouveau receveur
  Future<Receiver> createReceiver({
    required String name,
    required String phoneNumber,
  }) async {
    await _initializeReceivers();
    try {
      final newReceiver = Receiver(
        id: 'RCV${(_receivers.length + 1).toString().padLeft(3, '0')}',
        name: name,
        phoneNumber: phoneNumber,
        status: 'active',
      );
      _receivers.add(newReceiver);
      return newReceiver;
    } catch (e) {
      rethrow;
    }
  }

  /// Valide le nom du receveur
  bool validateReceiverName(String name) {
    return name.isNotEmpty && name.length >= 2;
  }

  /// Valide le numéro de téléphone
  bool validatePhoneNumber(String phone) {
    // Valide un numéro sénégalais: +221 77 XXX XX XX ou 77 XXX XX XX
    final phoneRegex = RegExp(r'^(\+221|0)?[7-9]\d{8}$');
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    return phoneRegex.hasMatch(cleanPhone);
  }

  /// Supprime un receveur
  Future<void> deleteReceiver(String id) async {
    await _initializeReceivers();
    try {
      _receivers.removeWhere((receiver) => receiver.id == id);
    } catch (e) {
      rethrow;
    }
  }
}
