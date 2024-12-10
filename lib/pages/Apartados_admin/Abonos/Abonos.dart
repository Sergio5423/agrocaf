import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agrocaf/controllers/abonos_controller.dart';
import 'package:agrocaf/models/abono_model.dart';
import 'package:agrocaf/widgets/informacion/info.dart';

class AdminAbonos extends StatelessWidget {
  AdminAbonos({super.key});

  final AbonoController abonoController = Get.put(AbonoController());
  final RecolectorController recolectorController =
      Get.put(RecolectorController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    abonoController.fetchAbonos();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('FloatingActionButton presionado');
          Abono abonoVacio = Abono();
          print('Creado abonoVacio');
          Abono? abono = await _showAddAbonoDialog(context, abonoVacio);
          print('abono: $abono');
          if (abono != null) {
            print('Abono no es nulo, agregando bono $abono');
            abonoController.agregarAbono(abono.cedularecolector, abono.abono);
          } else {
            print('Abono es nulo');
          }
        },
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SizedBox(
            height: 800,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Info(
                  Texto: 'Abonos',
                  cargo: 'Admin',
                  texto: 'Abonos',
                ),
                const SizedBox(height: 10),
                // Campo de búsqueda
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Buscar Abono',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (query) {
                    abonoController.updateSearchQuery(query);
                  },
                ),
                const SizedBox(height: 10),
                // Lista de abonos
                Obx(() {
                  if (abonoController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (abonoController.filteredAbono.isEmpty) {
                    return const Center(
                        child: Text('No hay abonos disponibles.'));
                  }
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: abonoController.filteredAbono.length,
                      itemBuilder: (context, index) {
                        final abono = abonoController.filteredAbono[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: ListTile(
                            title: Text(abono.cedularecolector),
                            subtitle: Text(abono.abono),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                if (abono.id != null) {
                                  abonoController
                                      .deleteAbonoController(abono.id!);
                                }
                              },
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
          //padding: const EdgeInsets.all(8.0),
        ),
      ),
    );
  }

  // Diálogo para agregar o editar abonos
  Future<Abono?> _showAddAbonoDialog(BuildContext context, Abono abono) async {
    final TextEditingController abonoController =
        TextEditingController(text: abono.abono);
    final TextEditingController recolectorController =
        TextEditingController(text: abono.cedularecolector);

    return showDialog<Abono?>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(abono.id == null ? 'Agregar Abono' : 'Editar Abono'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: recolectorController,
                  decoration:
                      const InputDecoration(labelText: 'Cédula del Recolector'),
                ),
                TextField(
                  controller: abonoController,
                  decoration:
                      const InputDecoration(labelText: 'Cantidad del Abono'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(null),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  String abonoNombre = abonoController.text.trim();
                  String cedulaRecolector = recolectorController.text.trim();

                  if (abonoNombre.isNotEmpty && cedulaRecolector.isNotEmpty) {
                    Navigator.of(context).pop(
                      Abono(
                        id: abono.id,
                        abono: abonoController
                            .text, // Usamos el valor ingresado en el campo
                        cedularecolector: recolectorController
                            .text, // Usamos el valor ingresado en el campo
                      ),
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      'Por favor, ingrese todos los datos.',
                      backgroundColor: Colors.red.withOpacity(0.7),
                      colorText: Colors.white,
                    );
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          );
        });
  }
}
