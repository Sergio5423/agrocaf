import 'package:agrocaf/controllers/pesadas_controller.dart';
import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:agrocaf/pages/Apartados_Operador/Registro_Pesada.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorOperador.dart';
import 'package:agrocaf/widgets/LogoutOperador.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_operador_controller.dart';

class HomeOperador extends StatefulWidget {
  const HomeOperador({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeOperador> {
  final RecolectorController _recolectorController =
      Get.put(RecolectorController()); // Inyectar RecolectorController

  @override
  Widget build(BuildContext context) {
    _recolectorController.fetchRecolectores();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
          actions: [
            LogoutOperador(),
          ],
        ),
        body: RegistroPesadaOperador(),
        bottomNavigationBar: BottomNaviOperador());
  }
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
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
