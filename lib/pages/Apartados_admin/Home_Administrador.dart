import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/auth_admin_controller.dart';

final AuthAdminController _authController =
    Get.find(); // Obtener el controlador de autenticación

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        actions: [
          IconButton(
            icon: Container(
              child: const Row(
                children: [
                  Text('Salir'),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.logout),
                ],
              ),
            ),
            onPressed: () {
              _authController.signOut(); // Llamar al método de cerrar sesión
            },
          ),
        ],
      ),
    );
  }
}
