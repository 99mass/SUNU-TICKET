import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // États réactifs
  final isLoading = false.obs;
  final isSuccess = false.obs;
  final errorMessage = ''.obs;
  final currentUser = Rx<UserModel?>(null);
  final authToken = ''.obs;
  final isAuthenticated = false.obs;
  final phoneNumber = ''.obs;


  @override
  void onInit() {
    super.onInit();
    // Vérifier si l'utilisateur est déjà connecté
    _checkExistingSession();
  }

  /// Vérifier s'il existe une session existante
  Future<void> _checkExistingSession() async {
    final token = authToken.value;
    if (token.isNotEmpty) {
      final response = await _authRepository.getCurrentUser(token);
      if (response.success) {
        currentUser.value = response.user;
        isAuthenticated.value = true;
      } else {
        authToken.value = '';
        isAuthenticated.value = false;
      }
    }
  }

  /// Connexion avec téléphone et mot de passe
  Future<void> login({required String phone, required String password}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      isSuccess.value = false;

      final response = await _authRepository.login(
        phone: phone,
        password: password,
      );

      if (response.success) {
        final user = response.user;
        // Vérifier si l'utilisateur est vérifié
        if (user != null && !user.isVerified) {
          phoneNumber.value = phone;
          Get.toNamed('/otp-verification');
          Get.snackbar(
            'Vérification requise',
            'Veuillez vérifier votre numéro de téléphone',
            backgroundColor: AppColors.secondary,
            colorText: Colors.white,
          );
          return;
        }

        authToken.value = response.token ?? '';
        currentUser.value = user;
        phoneNumber.value = phone;
        isAuthenticated.value = true;
        isSuccess.value = true;
        errorMessage.value = '';

        Get.offAllNamed('/dashboard');
      } else {
        errorMessage.value = response.message;
        isSuccess.value = false;
      }
    } catch (e) {
      errorMessage.value = 'Erreur: ${e.toString()}';
      isSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Déconnexion
  void logout() {
    authToken.value = '';
    currentUser.value = null;
    phoneNumber.value = '';
    isAuthenticated.value = false;
    errorMessage.value = '';
    isSuccess.value = false;
  }

  /// Réinitialiser les erreurs
  void clearErrors() {
    errorMessage.value = '';
  }

  /// Réinitialiser l'état de succès
  void clearSuccess() {
    isSuccess.value = false;
  }
}
