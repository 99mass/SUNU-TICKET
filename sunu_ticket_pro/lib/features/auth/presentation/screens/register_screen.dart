import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  late AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
    _nameFocusNode.addListener(_onFocusChange);
    _phoneFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
    _confirmPasswordFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_nameFocusNode.hasFocus ||
        _phoneFocusNode.hasFocus ||
        _passwordFocusNode.hasFocus ||
        _confirmPasswordFocusNode.hasFocus) {
      _authController.clearErrors();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      await _authController.register(
        name: _nameController.text,
        phone: '+221${_phoneController.text.replaceAll(" ", "")}',
        password: _passwordController.text,
        passwordConfirm: _confirmPasswordController.text,
      );

      if (_authController.isSuccess.value) {
        Get.toNamed('/otp-verification');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header avec Gradient et Courbe
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        'Inscription',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Gérez vos bus et recettes en toute simplicité',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.white.withValues(alpha: 0.9),
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Message d'erreur
                    Obx(() {
                      if (_authController.errorMessage.value.isNotEmpty) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.error),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: AppColors.error),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _authController.errorMessage.value,
                                  style: TextStyle(color: AppColors.error),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),

                    // Nom complet
                    CustomTextField(
                      label: 'Nom complet',
                      hintText: 'Moussa Diop',
                      icon: Icons.person_outline,
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le nom est requis';
                        }
                        if (value.length < 3) {
                          return 'Le nom est trop court';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Champ Téléphone avec Drapeau Sénégal
                    CustomTextField(
                      label: 'Numéro de téléphone',
                      hintText: '77 123 45 67',
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      inputFormatters: [SenegalPhoneFormatter()],
                      prefixWidget: Container(
                        width: 120,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            const Text('🇸🇳', style: TextStyle(fontSize: 24)),
                            const SizedBox(width: 8),
                            Text(
                              '+221',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 1,
                              height: 24,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le téléphone est requis';
                        }
                        final cleanValue = value.replaceAll(' ', '');
                        if (cleanValue.length != 9) {
                          return 'Numéro invalide (9 chiffres)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Mot de passe
                    CustomTextField(
                      label: 'Code PIN',
                      hintText: '••••',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le code PIN est requis';
                        }
                        if (value.length != 4) {
                          return 'Le code PIN doit contenir 4 chiffres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Confirmation Mot de passe
                    CustomTextField(
                      label: 'Confirmer le code PIN',
                      hintText: '••••',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'La confirmation est requise';
                        }
                        if (value != _passwordController.text) {
                          return 'Les codes PIN ne correspondent pas';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Bouton Inscription
                    Obx(() {
                      return AuthButton(
                        label: 'S\'inscrire',
                        onPressed: _handleRegister,
                        isLoading: _authController.isLoading.value,
                      );
                    }),

                    const SizedBox(height: 24),

                    // Lien Connexion
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Déjà un compte? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back(); // Retour au login
                          },
                          child: Text(
                            'Se connecter',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
