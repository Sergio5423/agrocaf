import 'package:agrocaf/pages/Login/login_opciones.dart';
import 'package:agrocaf/pages/Login/register/register_operador_page.dart';
import 'package:agrocaf/widgets/login.dart';
import 'package:agrocaf/controllers/auth_operador_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOperador extends StatelessWidget {
  final AuthOperadorController _authController =
      Get.put(AuthOperadorController());
  LoginOperador({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginOpciones()),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: inicioDeSesion(
          context, 'Operador', _authController, RegisterOperadorPage()),
    );
  }
}
