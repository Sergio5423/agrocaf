import 'package:agrocaf/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterAdminPage extends StatefulWidget {
  RegisterAdminPage({Key? key}) : super(key: key);

  @override
  _RegisterAdminPageState createState() => _RegisterAdminPageState();
}

class _RegisterAdminPageState extends State<RegisterAdminPage> {
  final AuthController _authController =
      Get.put(AuthController()); // Cambiado a AuthAdminController
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _roles = ['admin', 'operador'];
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 50),
                Text(
                  'Registro',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 40),
                _buildTextField(context, 'Nombre', _nameController),
                const SizedBox(height: 20),
                _buildTextField(context, 'Email', _emailController),
                const SizedBox(height: 20),
                _buildTextField(context, 'Contraseña', _passwordController,
                    obscureText: true),
                const SizedBox(height: 40),
                DropdownButtonFormField<String>(
                  hint: Text('Selecciona un rol'),
                  value: _selectedRole,
                  items: _roles.map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecciona un rol';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Obx(() => _authController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : _buildRegisterButton(context)),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      '¿Ya tienes cuenta? Inicia sesión',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Center(
      child: FilledButton(
        onPressed: () {
          String name = _nameController.text.trim();
          String email = _emailController.text.trim();
          String password = _passwordController.text.trim();

          if (_selectedRole == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Por favor, selecciona un rol')),
            );
          } else {
            _authController.register(
                email, password, name, _selectedRole.toString());
          }
        },
        child: const Text(
          'Registrarse',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
