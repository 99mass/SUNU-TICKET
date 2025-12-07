import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'routes/app_routes.dart';

class SunuTicketApp extends StatelessWidget {
  const SunuTicketApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialiser le AuthController
    Get.put(AuthController());

    return GetMaterialApp(
      title: 'SUNU TICKET Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      defaultTransition: Transition.fade,
      getPages: AppRoutes.routes,
      home: const SplashScreen(),
      builder: (context, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: child,
      ),
    );
  }
}
