import 'package:agrocaf/controllers/auth_operador_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthOperadorController _authController = Get.find();
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        _authController.signOut(); // Llamar al método de cerrar sesión
      },
    );
  }
}
