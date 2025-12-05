import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';

class SunuTicketApp extends StatelessWidget {
  const SunuTicketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SUNU TICKET Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      defaultTransition: Transition.fade,
      home: const Scaffold(
        body: Center(
          child: Text('SUNU TICKET Pro - Initialized'),
        ),
      ),
    );
  }
}
