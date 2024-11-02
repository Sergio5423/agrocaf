import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/pages/Apartados_admin/Recolectores/Agregar_Recolector.dart';
import 'package:agrocaf/widgets/BottomNavigatorAdmin.dart';

import 'package:agrocaf/widgets/Tablas/Datos_recolector.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/recolector_controller.dart'; // Asegúrate de importar el controlador

class RecolectoresPage extends StatelessWidget {
  final RecolectorController controller = Get.put(RecolectorController());

  RecolectoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 2,
            child: FloatingActionButton(
              onPressed: () {
                Get.to(() => AddRecolectorPage());
              },
              backgroundColor: Colors.green,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(
        title: const Text('Recolectores'),
        actions: const [],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                Info(Texto: 'Recolectores', cargo: 'ADMIN'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Buscar por nombre',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      controller.updateSearchQuery(value);
                    },
                  ),
                ),
                Tablarecolectores(),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller
                        .generateExcel(); // Llamar al método para generar el Excel
                  },
                  child: SizedBox(
                    width: 180,
                    child: Row(
                      children: [
                        const Icon(Icons.file_download),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text('Descargar Excel'),
                        const SizedBox(
                          width: 2,
                        ),
                        Image.asset('images/excel.png')
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddRecolectorDialog(
      BuildContext context, RecolectorController recolectorController) {
    final TextEditingController cedulaController = TextEditingController();
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController telefonoController = TextEditingController();
    final TextEditingController metodoPagoController = TextEditingController();
    final TextEditingController cuentaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Recolector'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  controller: cuentaController,
                  decoration:
                      const InputDecoration(labelText: 'Número de Cuenta'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String cedula = cedulaController.text.trim();
                String nombre = nombreController.text.trim();
                String telefono = telefonoController.text.trim();
                String metodoPago = metodoPagoController.text.trim();
                String cuenta = cuentaController.text.trim();

                if (cedula.isNotEmpty &&
                    nombre.isNotEmpty &&
                    telefono.isNotEmpty &&
                    metodoPago.isNotEmpty &&
                    cuenta.isNotEmpty) {
                  recolectorController.saveNewRecolector(
                    cedula,
                    nombre,
                    telefono,
                    metodoPago,
                    cuenta,
                  ); // Llama al método de agregar
                  Navigator.of(context).pop(); // Cerrar el diálogo
                } else {
                  Get.snackbar(
                      'Error', 'Por favor, complete todos los campos.');
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}
