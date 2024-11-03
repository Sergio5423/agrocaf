/*import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/models/recolector_model.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditRecolectorPage extends StatelessWidget {
  final Recolector recolector;

  EditRecolectorPage({super.key, required this.recolector});

  final RecolectorController controller = Get.find();

  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController metodoPagoController = TextEditingController();
  final TextEditingController numeroCuentaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(
        title: const Text('Editar Recolector'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Info(Texto: 'Modificar Recolectores', cargo: 'Admin'),
            Padding(
              padding: const EdgeInsets.all(12),
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
                  const SizedBox(height: 40),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green, // Color del texto
                            ),
                            onPressed: () {
                              controller.saveNewRecolector(
                                  cedulaController.text,
                                  nombreController.text,
                                  telefonoController.text,
                                  metodoPagoController.text,
                                  metodoPagoController.text);
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Agregar'),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green, // Color del texto
                            ),
                            onPressed: () {
                              // Lógica para eliminar el recolector actual
                              controller.deleteRecolector(recolector.cedula);
                              Get.back(); // Cierra la pantalla de edición después de eliminar
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text('Eliminar'),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green, // Color del texto
                            ),
                            onPressed: () {
                              controller.updateItem(Recolector(
                                cedula: cedulaController.text,
                                nombre: nombreController.text,
                                telefono: telefonoController.text,
                                metodopago: metodoPagoController.text,
                                ncuenta: metodoPagoController.text,
                              ));
                              Get.back(); // Cierra la pantalla de edición
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('Editar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/