//import 'package:agrocaf/controllers/profile_controller.dart';
import 'package:agrocaf/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController =
      Get.put(AuthController()); // Obtener el controlador
  //final ProfileController _profileController = Get.put(ProfileController());
  final TextEditingController _emailController =
      TextEditingController(); // Controlador para el email
  final TextEditingController _passwordController =
      TextEditingController(); // Controlador para la contraseña

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'images/agrocaf_logo.png',
                  height: 150.0,
                  width: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Inicio de\nSesión',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Color.fromRGBO(76, 140, 43, 10),
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Inicie sesión para continuar',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Color.fromRGBO(143, 142, 142, 1),
                      fontSize: 14,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              _buildTextField(context, 'Email', _emailController),
              SizedBox(height: 20),
              _buildTextField(context, 'Contraseña', _passwordController,
                  obscureText: true),
              SizedBox(height: 40),
              Obx(() => _authController.isLoading.value
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Mostrar el indicador de carga
                  : _buildLoginButton(context)),
              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () =>
                      Get.to(RegisterPage()), // Navegar a la vista de registro
                  child: Text(
                    '¿No tienes cuenta? Regístrate',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir los campos de texto
  Widget _buildTextField(
      BuildContext context, String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // Método para el botón de inicio de sesión
  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: FilledButton(
        onPressed: () {
          String email = _emailController.text.trim();
          String password = _passwordController.text.trim();
          _authController.login(
              email, password); // Llamar al método de login en el controlador
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(500, 50)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Cambia el valor para ajustar el radio de los bordes
            ),
          ),
        ),
        child: Text(
          'Iniciar Sesión',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
