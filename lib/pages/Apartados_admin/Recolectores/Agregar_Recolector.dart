import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNavigatorAdmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agrocaf/controllers/recolector_controller.dart';

class AddRecolectorPage extends StatelessWidget {
  final RecolectorController controller = Get.find();

  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController metodoPagoController = TextEditingController();
  final TextEditingController numeroCuentaController = TextEditingController();

  AddRecolectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(
        title: const Text('Agregar Recolector'),
      ),
      body: SafeArea(
        child: Column(children: [
          Info(Texto: 'Agregar Recolector', cargo: 'Admin'),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                TextField(
                  controller: cedulaController,
                  decoration: const InputDecoration(labelText: 'Cédula'),
                ),
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: telefonoController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                ),
                TextField(
                  controller: metodoPagoController,
                  decoration:
                      const InputDecoration(labelText: 'Método de Pago'),
                ),
                TextField(
                  controller: numeroCuentaController,
                  decoration:
                      const InputDecoration(labelText: 'Número de Cuenta'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.saveNewRecolector(
                      cedulaController.text,
                      nombreController.text,
                      telefonoController.text,
                      metodoPagoController.text,
                      numeroCuentaController.text,
                    );
                    Get.back(); // Regresa a la pantalla anterior
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Color del texto
                  ),
                  child: SizedBox(
                    width: 160,
                    child: Row(
                      children: [
                        const Text('Guardar Recolector'),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'images/add.png',
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
