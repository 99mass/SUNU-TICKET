import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthRepository {
  /// Charge les données mock depuis le fichier JSON
  Future<Map<String, dynamic>> _loadMockData() async {
    try {
      final jsonString = await rootBundle.loadString(
        'lib/features/auth/data/datasources/mock_data/users.json',
      );
      return jsonDecode(jsonString);
    } catch (e) {
      return {};
    }
  }

  /// Authentification utilisateur par téléphone et mot de passe
  Future<AuthResponseModel> login({
    required String phone,
    required String password,
  }) async {
    try {
      await Future.delayed(
        const Duration(milliseconds: 1000),
      ); // Simule une requête réseau

      final data = await _loadMockData();
      final users = (data['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();

      // Chercher l'utilisateur
      UserModel? user;
      try {
        user = users.firstWhere((u) => u.phone == phone);
      } catch (e) {
        // Utilisateur non trouvé
        user = null;
      }

      if (user == null) {
        return AuthResponseModel(
          success: false,
          message: 'Utilisateur non trouvé',
        );
      }

      // Vérifier le mot de passe
      if (user.password != password) {
        return AuthResponseModel(
          success: false,
          message: 'Mot de passe incorrect',
        );
      }

      // Authentification réussie
      return AuthResponseModel(
        success: true,
        token: 'token_${user.id}_${DateTime.now().millisecondsSinceEpoch}',
        user: user,
        message: 'Authentification réussie',
      );
    } catch (e) {
      return AuthResponseModel(
        success: false,
        message: 'Erreur lors de l\'authentification: $e',
      );
    }
  }

  /// Inscription d'un nouvel utilisateur
  Future<AuthResponseModel> register({
    required String name,
    required String phone,
    required String password,
  }) async {
    try {
      await Future.delayed(
        const Duration(milliseconds: 1000),
      ); // Simule une requête réseau

      final data = await _loadMockData();
      final users = (data['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();

      // Vérifier si l'utilisateur existe déjà
      final userExists = users.any((u) => u.phone == phone);

      if (userExists) {
        return AuthResponseModel(
          success: false,
          message: 'Cet utilisateur existe déjà',
        );
      }

      // Créer un nouvel utilisateur
      final newUser = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        phone: phone,
        name: name,
        password: password,
        createdAt: DateTime.now().toIso8601String(),
        isVerified: false,
      );

      return AuthResponseModel(
        success: true,
        token: 'token_${newUser.id}_${DateTime.now().millisecondsSinceEpoch}',
        user: newUser,
        message: 'Inscription réussie',
      );
    } catch (e) {
      return AuthResponseModel(
        success: false,
        message: 'Erreur lors de l\'inscription: $e',
      );
    }
  }

  /// Vérification d'un code OTP
  Future<AuthResponseModel> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      await Future.delayed(
        const Duration(milliseconds: 800),
      ); // Simule une requête réseau

      final data = await _loadMockData();
      final otpCodes = data['otp_codes'] as Map<String, dynamic>;

      final correctOtp = otpCodes[phone];

      if (correctOtp == null) {
        return AuthResponseModel(
          success: false,
          message: 'Téléphone non trouvé',
        );
      }

      if (correctOtp != otp) {
        return AuthResponseModel(success: false, message: 'Code OTP incorrect');
      }

      // OTP vérifié, charger l'utilisateur
      final users = (data['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();

      UserModel? user;
      try {
        user = users.firstWhere((u) => u.phone == phone);
      } catch (e) {
        user = null;
      }

      if (user == null) {
        return AuthResponseModel(
          success: false,
          message: 'Utilisateur non trouvé',
        );
      }

      return AuthResponseModel(
        success: true,
        token: 'token_${user.id}_${DateTime.now().millisecondsSinceEpoch}',
        user: user,
        message: 'OTP vérifié avec succès',
      );
    } catch (e) {
      return AuthResponseModel(
        success: false,
        message: 'Erreur lors de la vérification OTP: $e',
      );
    }
  }

  /// Récupérer l'utilisateur actuel (par token)
  Future<AuthResponseModel> getCurrentUser(String token) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Simulation : extraire l'ID utilisateur du token
      if (token.contains('user_001')) {
        return AuthResponseModel(
          success: true,
          token: token,
          user: UserModel(
            id: 'user_001',
            phone: '+221771234567',
            name: 'Abdoulaye Diop',
            password: '1234',
            createdAt: '2025-01-15T10:00:00Z',
            isVerified: true,
          ),
          message: 'Utilisateur récupéré',
        );
      }

      return AuthResponseModel(success: false, message: 'Token invalide');
    } catch (e) {
      return AuthResponseModel(success: false, message: 'Erreur: $e');
    }
  }

  /// Envoyer un OTP pour la réinitialisation du mot de passe
  Future<AuthResponseModel> sendPasswordResetOtp({
    required String phone,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));

      // Vérifier si l'utilisateur existe
      final data = await _loadMockData();
      final users = (data['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();

      final userExists = users.any((u) => u.phone == phone);

      if (!userExists) {
        return AuthResponseModel(
          success: false,
          message: 'Aucun compte associé à ce numéro',
        );
      }

      // Simuler l'envoi d'OTP (toujours 123456 pour le test)
      return AuthResponseModel(
        success: true,
        message: 'Code envoyé avec succès',
      );
    } catch (e) {
      return AuthResponseModel(
        success: false,
        message: 'Erreur lors de l\'envoi du code: $e',
      );
    }
  }

  /// Réinitialiser le mot de passe
  Future<AuthResponseModel> resetPassword({
    required String phone,
    required String newPassword,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));

      return AuthResponseModel(
        success: true,
        message: 'Mot de passe réinitialisé avec succès',
      );
    } catch (e) {
      return AuthResponseModel(
        success: false,
        message: 'Erreur lors de la réinitialisation: $e',
      );
    }
  }
}
