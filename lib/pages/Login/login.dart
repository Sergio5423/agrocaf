import 'package:agrocaf/controllers/auth_controller.dart';
import 'package:agrocaf/pages/Login/login_opciones.dart';
import 'package:agrocaf/pages/Login/register/register_admin_page.dart';
import 'package:agrocaf/widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginOpciones()),
            );
          },
        ),*/
      ),
      backgroundColor: Colors.white,
      body: inicioDeSesion(context, _authController, RegisterAdminPage()),
    );
  }
}
