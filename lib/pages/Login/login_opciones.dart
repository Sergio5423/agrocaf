/*import 'package:agrocaf/pages/Login/login_operador.dart';
import 'package:agrocaf/pages/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOpciones extends StatelessWidget {
  LoginOpciones({super.key});

  void _LoginOperador(BuildContext context) {
    Get.to(LoginOperador());
  }

  void _Login(BuildContext context) {
    Get.to(Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: Image.asset(
                    'images/agrocaf_logo.png',
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Login\nOpciones',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: const Color.fromRGBO(76, 140, 43, 10),
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Seleccione una opción para continuar',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: const Color.fromRGBO(143, 142, 142, 1),
                      fontSize: 14,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset('images/iconoperador.png'),
                              iconSize: 50.0,
                              onPressed: () {
                                _LoginOperador(context);
                              },
                            ),
                            SizedBox(width: 10), // Espacio entre los botones
                            IconButton(
                              icon: Image.asset('images/iconadmin.png'),
                              iconSize: 50.0,
                              onPressed: () {
                                _Login(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/