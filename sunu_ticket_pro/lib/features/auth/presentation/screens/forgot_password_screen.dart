import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_button.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _authController = Get.find<AuthController>();

  // Controllers
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  // Focus Nodes
  final _phoneFocusNode = FocusNode();
  final _otpFocusNode = FocusNode();
  final _newPinFocusNode = FocusNode();
  final _confirmPinFocusNode = FocusNode();

  // Keys
  final _phoneFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Reset step when entering screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authController.resetStep.value = 0;
      _authController.errorMessage.value = '';
    });

    // Listeners to clear errors
    _phoneFocusNode.addListener(_clearErrorOnFocus);
    _otpFocusNode.addListener(_clearErrorOnFocus);
    _newPinFocusNode.addListener(_clearErrorOnFocus);
    _confirmPinFocusNode.addListener(_clearErrorOnFocus);
  }

  void _clearErrorOnFocus() {
    if (_phoneFocusNode.hasFocus ||
        _otpFocusNode.hasFocus ||
        _newPinFocusNode.hasFocus ||
        _confirmPinFocusNode.hasFocus) {
      _authController.clearErrors();
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    _phoneFocusNode.dispose();
    _otpFocusNode.dispose();
    _newPinFocusNode.dispose();
    _confirmPinFocusNode.dispose();
    super.dispose();
  }

  void _handleSendCode() {
    if (_phoneFormKey.currentState!.validate()) {
      _authController.sendResetOtp(
        '+221${_phoneController.text.replaceAll(" ", "")}',
      );
    }
  }

  void _handleVerifyOtp() {
    if (_otpFormKey.currentState!.validate()) {
      _authController.verifyResetOtp(_otpController.text);
    }
  }

  void _handleResetPassword() {
    if (_resetFormKey.currentState!.validate()) {
      _authController.resetPassword(_newPinController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 300,
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
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/logo_pro.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Mot de passe oublié ?',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Obx(() {
                          String subtitle =
                              'Entrez votre numéro pour recevoir un code';
                          if (_authController.resetStep.value == 1) {
                            subtitle = 'Entrez le code reçu par SMS';
                          } else if (_authController.resetStep.value == 2) {
                            subtitle = 'Définissez votre nouveau code PIN';
                          }
                          return Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppColors.white.withValues(alpha: 0.9),
                                  fontSize: 14,
                                ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Obx(() {
                // Error Message
                return Column(
                  children: [
                    if (_authController.errorMessage.value.isNotEmpty)
                      Container(
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
                      ),

                    // Dynamic Content based on Step
                    if (_authController.resetStep.value == 0) _buildPhoneStep(),
                    if (_authController.resetStep.value == 1) _buildOtpStep(),
                    if (_authController.resetStep.value == 2) _buildResetStep(),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneStep() {
    return Form(
      key: _phoneFormKey,
      child: Column(
        children: [
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
                  Container(width: 1, height: 24, color: Colors.grey[300]),
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
          const SizedBox(height: 30),
          AuthButton(
            label: 'Envoyer le code',
            onPressed: _handleSendCode,
            isLoading: _authController.isLoading.value,
          ),
        ],
      ),
    );
  }

  Widget _buildOtpStep() {
    return Form(
      key: _otpFormKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Code de vérification',
            hintText: '123456',
            keyboardType: TextInputType.number,
            controller: _otpController,
            focusNode: _otpFocusNode,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Le code est requis';
              }
              if (value.length != 6) {
                return 'Le code doit contenir 6 chiffres';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          AuthButton(
            label: 'Vérifier le code',
            onPressed: _handleVerifyOtp,
            isLoading: _authController.isLoading.value,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              _authController.resetStep.value = 0;
            },
            child: Text(
              'Changer de numéro',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetStep() {
    return Form(
      key: _resetFormKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Nouveau Code PIN',
            hintText: '••••',
            icon: Icons.lock_outline,
            isPassword: true,
            keyboardType: TextInputType.number,
            controller: _newPinController,
            focusNode: _newPinFocusNode,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
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
          CustomTextField(
            label: 'Confirmer le Code PIN',
            hintText: '••••',
            icon: Icons.lock_outline,
            isPassword: true,
            keyboardType: TextInputType.number,
            controller: _confirmPinController,
            focusNode: _confirmPinFocusNode,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La confirmation est requise';
              }
              if (value != _newPinController.text) {
                return 'Les codes PIN ne correspondent pas';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          AuthButton(
            label: 'Réinitialiser',
            onPressed: _handleResetPassword,
            isLoading: _authController.isLoading.value,
          ),
        ],
      ),
    );
  }
}
