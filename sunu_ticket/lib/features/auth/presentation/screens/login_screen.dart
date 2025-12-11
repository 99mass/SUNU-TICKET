import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  late AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
    _phoneFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_phoneFocusNode.hasFocus || _passwordFocusNode.hasFocus) {
      _authController.clearErrors();
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _authController.login(
        phone: '+221${_phoneController.text.replaceAll(" ", "")}',
        password: _passwordController.text,
      );
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
                  height: 260,
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
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(10.0),

                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(
                                255,
                                235,
                                246,
                                33,
                              ).withValues(alpha: 0.2),
                              blurRadius: 30,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Bienvenue !',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Connectez-vous pour gérer vos bus',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

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

              
                    const SizedBox(height: 30),

                    // Bouton Connexion
                    Obx(() {
                      return AuthButton(
                        label: 'Se connecter',
                        onPressed: _handleLogin,
                        isLoading: _authController.isLoading.value,
                      );
                    }),

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
