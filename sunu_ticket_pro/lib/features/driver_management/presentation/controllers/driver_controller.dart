import 'package:get/get.dart';
import 'package:sunu_ticket_pro/features/driver_management/data/models/driver_model.dart';
import 'package:sunu_ticket_pro/features/driver_management/data/repositories/driver_repository.dart';

class DriverController extends GetxController {
  final DriverRepository _driverRepository = DriverRepository();

  // Liste des chauffeurs actifs
  final activeDrivers = <Driver>[].obs;

  // Chauffeur sélectionné
  final selectedDriver = Rx<Driver?>(null);

  // État de chargement
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadActiveDrivers();
  }

  /// Charge les chauffeurs actifs
  Future<void> loadActiveDrivers() async {
    try {
      isLoading(true);
      final drivers = await _driverRepository.getActiveDrivers();
      activeDrivers.value = drivers;
    } catch (e) {
      activeDrivers.value = [];
    } finally {
      isLoading(false);
    }
  }

  /// Sélectionne un chauffeur
  void selectDriver(Driver driver) {
    selectedDriver(driver);
  }

  /// Crée un nouveau chauffeur
  Future<Driver?> createDriver({
    required String name,
    required String licenseNumber,
    required String phoneNumber,
  }) async {
    try {
      isLoading(true);
      if (!_driverRepository.validateDriverName(name)) {
        Get.snackbar('Erreur', 'Le nom doit contenir au moins 2 caractères');
        return null;
      }
      if (!_driverRepository.validateLicenseNumber(licenseNumber)) {
        Get.snackbar(
          'Erreur',
          'Le numéro de permis doit contenir au moins 5 caractères',
        );
        return null;
      }
      if (!_driverRepository.validatePhoneNumber(phoneNumber)) {
        Get.snackbar('Erreur', 'Numéro de téléphone invalide');
        return null;
      }
      final newDriver = await _driverRepository.createDriver(
        name: name,
        licenseNumber: licenseNumber,
        phoneNumber: phoneNumber,
      );
      activeDrivers.add(newDriver);
      return newDriver;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de créer le chauffeur: $e');
      return null;
    } finally {
      isLoading(false);
    }
  }

  /// Supprime un chauffeur
  Future<bool> deleteDriver(String id) async {
    try {
      isLoading(true);
      final success = await _driverRepository.deleteDriver(id);
      if (success) {
        activeDrivers.removeWhere((d) => d.id == id);
      }
      return success;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de supprimer le chauffeur: $e');
      return false;
    } finally {
      isLoading(false);
    }
  }

  /// Valide le nom du chauffeur
  bool validateDriverName(String name) {
    return _driverRepository.validateDriverName(name);
  }

  /// Valide le numéro de permis
  bool validateLicenseNumber(String license) {
    return _driverRepository.validateLicenseNumber(license);
  }

  /// Valide le numéro de téléphone
  bool validatePhoneNumber(String phone) {
    return _driverRepository.validatePhoneNumber(phone);
  }
}
