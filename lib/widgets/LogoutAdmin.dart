import 'package:agrocaf/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutAdmin extends StatelessWidget {
  const LogoutAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        authController.signOut(); // Llamar al método de cerrar sesión
      },
    );
  }
}
