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

  // Pour l'écran OTP
  final otpCode = ''.obs;
  final otpLoading = false.obs;

  // Pour la réinitialisation du mot de passe
  final resetStep = 0.obs; // 0: Phone, 1: OTP, 2: New Password

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

  /// Inscription d'un nouvel utilisateur
  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      isSuccess.value = false;

      // Validation basique
      if (name.isEmpty) {
        errorMessage.value = 'Le nom est requis';
        isLoading.value = false;
        return;
      }

      if (phone.isEmpty) {
        errorMessage.value = 'Le téléphone est requis';
        isLoading.value = false;
        return;
      }

      if (password.isEmpty) {
        errorMessage.value = 'Le mot de passe est requis';
        isLoading.value = false;
        return;
      }

      if (password != passwordConfirm) {
        errorMessage.value = 'Les mots de passe ne correspondent pas';
        isLoading.value = false;
        return;
      }

      if (password.length != 4) {
        errorMessage.value = 'Le code PIN doit contenir 4 chiffres';
        isLoading.value = false;
        return;
      }

      final response = await _authRepository.register(
        name: name,
        phone: phone,
        password: password,
      );

      if (response.success) {
        authToken.value = response.token ?? '';
        currentUser.value = response.user;
        phoneNumber.value = phone;
        isAuthenticated.value = true;
        isSuccess.value = true;
        errorMessage.value = '';
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

  /// Vérification du code OTP
  Future<void> verifyOtp({required String phone, required String otp}) async {
    try {
      otpLoading.value = true;
      errorMessage.value = '';

      final response = await _authRepository.verifyOtp(phone: phone, otp: otp);

      if (response.success) {
        authToken.value = response.token ?? '';
        currentUser.value = response.user;
        phoneNumber.value = phone;
        isAuthenticated.value = true;
        isSuccess.value = true;
        errorMessage.value = '';
      } else {
        errorMessage.value = response.message;
        isSuccess.value = false;
      }
    } catch (e) {
      errorMessage.value = 'Erreur: ${e.toString()}';
      isSuccess.value = false;
    } finally {
      otpLoading.value = false;
    }
  }

  /// Envoyer OTP pour réinitialisation
  Future<void> sendResetOtp(String phone) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authRepository.sendPasswordResetOtp(phone: phone);

      if (response.success) {
        phoneNumber.value = phone;
        resetStep.value = 1; // Passer à l'étape OTP
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      errorMessage.value = 'Erreur: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Vérifier OTP pour réinitialisation
  Future<void> verifyResetOtp(String otp) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // On utilise la même méthode de vérification OTP
      // Dans un cas réel, on aurait peut-être un endpoint spécifique
      final response = await _authRepository.verifyOtp(
        phone: phoneNumber.value,
        otp: otp,
      );

      if (response.success) {
        resetStep.value = 2; // Passer à l'étape Nouveau Mot de passe
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      errorMessage.value = 'Erreur: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Réinitialiser le mot de passe final
  Future<void> resetPassword(String newPassword) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authRepository.resetPassword(
        phone: phoneNumber.value,
        newPassword: newPassword,
      );

      if (response.success) {
        Get.offAllNamed('/login');
        Get.snackbar(
          'Succès',
          'Mot de passe réinitialisé avec succès',
          backgroundColor: AppColors.success,
          colorText: Colors.white,
        );
        resetStep.value = 0;
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      errorMessage.value = 'Erreur: $e';
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
    otpCode.value = '';
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
