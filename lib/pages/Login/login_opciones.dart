import 'package:agrocaf/pages/Login/login_operador.dart';
import 'package:agrocaf/pages/Login/login_admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOpciones extends StatelessWidget {
  LoginOpciones({super.key});

  void _LoginOperador(BuildContext context) {
    Get.to(LoginOperador());
  }

  void _LoginAdmin(BuildContext context) {
    Get.to(LoginAdmin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context)
                .size
                .height, // Hace que el SingleChildScrollView tenga la altura completa de la pantalla
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra el contenido verticalmente
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Centra el contenido horizontalmente
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _LoginOperador(context);
                          },
                          child: Text('Ir a Login Operador'),
                        ),
                        SizedBox(width: 10), // Espacio entre los botones
                        ElevatedButton(
                          onPressed: () {
                            _LoginAdmin(context);
                          },
                          child: Text('Ir a Login Admin'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
