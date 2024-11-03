import 'dart:async';

import 'package:agrocaf/models/recolector_model.dart';
import 'package:agrocaf/widgets/Logout.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recolector_controller.dart';

class Recolectores extends StatelessWidget {
  final RecolectorController recolectorController =
      Get.put(RecolectorController());
  Recolectores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 2,
            child: FloatingActionButton(
              onPressed: () async {
                Recolector? recolector = await _showAddRecolectorDialog(
                    context, recolectorController, 'Nuevo');

                if (recolector != null) {
                  recolectorController.saveNewRecolector(recolector);
                  Get.snackbar('Éxito', 'Recolector guardado correctamente');
                } else {
                  Get.snackbar('Error', 'No se guardó el recolector');
                }
              },
              backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
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
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        actions: [
          Logout(),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                Info(Texto: 'Recolectores', cargo: 'Operador'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Buscar por nombre',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      recolectorController.updateSearchQuery(value);
                    },
                  ),
                ),
                Obx(() {
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount:
                          recolectorController.filteredRecolectores.length,
                      itemBuilder: (context, index) {
                        final item =
                            recolectorController.filteredRecolectores[index];
                        return ListTile(
                          title: Text(item.nombre),
                          subtitle: Text(item.cedula),
                          onTap: () {},
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  Recolector? recolector =
                                      await _showAddRecolectorDialog(context,
                                          recolectorController, 'Actualizar');
                                  recolectorController
                                      .selectRecolector(item.cedula);
                                  String cedula =
                                      recolectorController.selectedCedula.value;
                                  if (recolector != null) {
                                    recolectorController.updateItem(
                                        recolector, cedula);
                                    Get.snackbar('Éxito',
                                        'Recolector actualizado correctamente');
                                  } else {
                                    Get.snackbar('Error',
                                        'No se actualizó el recolector');
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_forever),
                                onPressed: () => recolectorController
                                    .deleteRecolector(item.cedula),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
                /*const SizedBox(
                  height: 40,
                ),*/
                ElevatedButton(
                  onPressed: () {
                    recolectorController
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

  Future<Recolector?> _showAddRecolectorDialog(BuildContext context,
      RecolectorController recolectorController, String titulo) {
    final TextEditingController cedulaController = TextEditingController();
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController telefonoController = TextEditingController();
    final TextEditingController metodoPagoController = TextEditingController();
    final TextEditingController cuentaController = TextEditingController();
    Completer<Recolector?> completer = Completer();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
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
                completer.complete(null);
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
                  Recolector recolector = Recolector(
                    cedula: cedula,
                    nombre: nombre,
                    telefono: telefono,
                    metodopago: metodoPago,
                    ncuenta: cuenta,
                  );
                  Navigator.of(context).pop();
                  completer.complete(recolector);
                } else {
                  Get.snackbar(
                      'Error', 'Por favor, complete todos los campos.');
                }
              },
              child: Text(titulo),
            ),
          ],
        );
      },
    );
    return completer.future;
  }
}
