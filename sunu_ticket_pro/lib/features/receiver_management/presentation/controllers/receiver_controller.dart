import 'package:get/get.dart';
import 'package:sunu_ticket_pro/features/receiver_management/data/models/receiver_model.dart';
import 'package:sunu_ticket_pro/features/receiver_management/data/repositories/receiver_repository.dart';

class ReceiverController extends GetxController {
  final ReceiverRepository _receiverRepository = ReceiverRepository();

  // Liste des receveurs actifs
  final activeReceivers = <Receiver>[].obs;

  // Receveur sélectionné
  final selectedReceiver = Rx<Receiver?>(null);

  // État de chargement
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadActiveReceivers();
  }

  /// Charge les receveurs actifs
  Future<void> loadActiveReceivers() async {
    try {
      isLoading(true);
      final receivers = await _receiverRepository.getActiveReceivers();
      activeReceivers.value = receivers;
    } catch (e) {
      activeReceivers.value = [];
    } finally {
      isLoading(false);
    }
  }

  /// Sélectionne un receveur
  void selectReceiver(Receiver receiver) {
    selectedReceiver(receiver);
  }

  /// Crée un nouveau receveur
  Future<Receiver?> createReceiver({
    required String name,
    required String phoneNumber,
  }) async {
    try {
      isLoading(true);
      if (!_receiverRepository.validateReceiverName(name)) {
        Get.snackbar('Erreur', 'Le nom doit contenir au moins 2 caractères');
        return null;
      }
      if (!_receiverRepository.validatePhoneNumber(phoneNumber)) {
        Get.snackbar('Erreur', 'Numéro de téléphone invalide');
        return null;
      }
      final newReceiver = await _receiverRepository.createReceiver(
        name: name,
        phoneNumber: phoneNumber,
      );
      activeReceivers.add(newReceiver);
      selectedReceiver(newReceiver);
      return newReceiver;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de créer le receveur: $e');
      return null;
    } finally {
      isLoading(false);
    }
  }

  /// Valide le nom du receveur
  bool validateReceiverName(String name) {
    return _receiverRepository.validateReceiverName(name);
  }

  /// Valide le numéro de téléphone
  bool validatePhoneNumber(String phone) {
    return _receiverRepository.validatePhoneNumber(phone);
  }

  /// Supprime un receveur
  Future<bool> deleteReceiver(String id) async {
    try {
      await _receiverRepository.deleteReceiver(id);
      activeReceivers.removeWhere((receiver) => receiver.id == id);
      return true;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de supprimer le receveur: $e');
      return false;
    }
  }
}
