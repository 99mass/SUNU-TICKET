import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:sunu_ticket_pro/features/driver_management/data/models/driver_model.dart';

class DriverRepository {
  // Liste des chauffeurs en mémoire
  static final List<Driver> _drivers = [];
  static bool _initialized = false;

  /// Initialise les chauffeurs depuis le JSON
  static Future<void> _initializeDrivers() async {
    if (_initialized) return;

    try {
      final jsonString = await rootBundle.loadString(
        'lib/features/driver_management/data/datasources/mock_data/drivers.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      _drivers.clear();
      _drivers.addAll(
        jsonList.map((json) => Driver.fromJson(json as Map<String, dynamic>)),
      );
      _initialized = true;
    } catch (e) {
      _loadMockData();
      _initialized = true;
    }
  }

  /// Fallback avec données en dur
  static void _loadMockData() {
    _drivers.clear();
    _drivers.addAll([
      Driver(
        id: 'DRV001',
        name: 'Ousmane Ba',
        licenseNumber: 'SN-2021-0001',
        phoneNumber: '+221 77 111 22 33',
        status: 'active',
      ),
      Driver(
        id: 'DRV002',
        name: 'Samba Diop',
        licenseNumber: 'SN-2020-0045',
        phoneNumber: '+221 77 222 33 44',
        status: 'active',
      ),
      Driver(
        id: 'DRV003',
        name: 'Mamadou Kane',
        licenseNumber: 'SN-2022-0089',
        phoneNumber: '+221 77 333 44 55',
        status: 'active',
      ),
    ]);
  }

  /// Récupère tous les chauffeurs actifs
  Future<List<Driver>> getActiveDrivers() async {
    await _initializeDrivers();
    try {
      return _drivers.where((driver) => driver.status == 'active').toList();
    } catch (e) {
      return [];
    }
  }

  /// Récupère tous les chauffeurs
  Future<List<Driver>> getAllDrivers() async {
    await _initializeDrivers();
    try {
      return List.from(_drivers);
    } catch (e) {
      return [];
    }
  }

  /// Récupère un chauffeur par ID
  Future<Driver?> getDriverById(String id) async {
    await _initializeDrivers();
    try {
      return _drivers.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Crée un nouveau chauffeur
  Future<Driver> createDriver({
    required String name,
    required String licenseNumber,
    required String phoneNumber,
  }) async {
    await _initializeDrivers();
    try {
      final newDriver = Driver(
        id: 'DRV${(_drivers.length + 1).toString().padLeft(3, '0')}',
        name: name,
        licenseNumber: licenseNumber,
        phoneNumber: phoneNumber,
        status: 'active',
      );
      _drivers.add(newDriver);
      return newDriver;
    } catch (e) {
      rethrow;
    }
  }

  /// Supprime un chauffeur
  Future<bool> deleteDriver(String id) async {
    await _initializeDrivers();
    try {
      _drivers.removeWhere((d) => d.id == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Valide le nom du chauffeur
  bool validateDriverName(String name) {
    return name.isNotEmpty && name.length >= 2;
  }

  /// Valide le numéro de permis
  bool validateLicenseNumber(String license) {
    return license.isNotEmpty && license.length >= 5;
  }

  /// Valide le numéro de téléphone
  bool validatePhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^(\+221|0)?[7-9]\d{8}$');
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    return phoneRegex.hasMatch(cleanPhone);
  }
}
