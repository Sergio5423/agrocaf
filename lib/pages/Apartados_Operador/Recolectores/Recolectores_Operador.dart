import 'dart:async';
import 'package:agrocaf/models/recolector_model.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorOperador.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/recolector_controller.dart';

/*Pestaña con los datos del recolector*/
class RecolectoresOperador extends StatelessWidget {
  final RecolectorController recolectorController =
      Get.put(RecolectorController());
  RecolectoresOperador({super.key});

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
                Recolector recolectorVacio = Recolector();
                Recolector? recolector = await _showAddRecolectorDialog(
                    context, recolectorController, 'Nuevo', recolectorVacio);

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
      bottomNavigationBar: BottomNaviOperador(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        actions: [],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                Info(texto: 'Recolectores', cargo: 'Operador'),
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
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: ListTile(
                            title: Text(item.nombre),
                            subtitle: Text(item.cedula),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Detalles del Recolector'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Cédula: ${item.cedula}'),
                                          Text('Nombre: ${item.nombre}'),
                                          Text('Teléfono: ${item.telefono}'),
                                          Text(
                                              'Método de Pago: ${item.metodopago}'),
                                          Text(
                                              'Número de Cuenta: ${item.ncuenta}'),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () async {
                                    Recolector? recolector =
                                        await _showAddRecolectorDialog(
                                            context,
                                            recolectorController,
                                            'Actualizar',
                                            item);
                                    recolectorController
                                        .selectRecolector(item.cedula);
                                    String cedula = recolectorController
                                        .selectedCedula.value;
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
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Recolector?> _showAddRecolectorDialog(
      BuildContext context,
      RecolectorController recolectorController,
      String titulo,
      Recolector recolector) {
    final TextEditingController cedulaController =
        TextEditingController(text: recolector.cedula);
    final TextEditingController nombreController =
        TextEditingController(text: recolector.nombre);
    final TextEditingController telefonoController =
        TextEditingController(text: recolector.telefono);
    final TextEditingController metodoPagoController =
        TextEditingController(text: recolector.metodopago);
    final TextEditingController cuentaController =
        TextEditingController(text: recolector.ncuenta);
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
