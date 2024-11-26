import 'package:agrocaf/controllers/auth_operador_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutOperador extends StatelessWidget {
  const LogoutOperador({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthOperadorController authController = Get.find();
    //final AuthAdminController authAdminController = Get.find();

    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        authController.signOut(); // Llamar al método de cerrar sesión
      },
    );
  }
}
