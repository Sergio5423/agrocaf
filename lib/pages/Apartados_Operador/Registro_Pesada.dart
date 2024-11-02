import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:agrocaf/controllers/pesadas_controller.dart';
import 'package:agrocaf/models/pesadas_model.dart';
import 'package:agrocaf/services/pesadas_service.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroPesadaOperador extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _pesadaController = TextEditingController();

  RegistroPesadaOperador({super.key}); // Controlador para la pesada

  @override
  Widget build(BuildContext context) {
    final RecolectorController recolectorController =
        Get.find(); // Obtener el controlador de RecolectorController
    final PesadaController pesadaController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Información general (Logo, título)
              Info(
                Texto: 'Valor del Kilo',
                cargo: 'Operador',
              ),

              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Ingrese pesada',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                          child: const Center(child: Text('KG')),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller:
                                _pesadaController, // Controlador para el campo de pesada
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Pesada',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                      labelText: 'Buscar Recolector',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      hintText: 'Ingrese Nombre a Buscar'),
                  onChanged: (value) {
                    recolectorController.updateSearchQuery(
                        value); // Actualizar la búsqueda en el controlador
                  },
                ),
              ),

              const SizedBox(height: 20),

              Obx(() {
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: recolectorController.filteredRecolectores.length,
                    itemBuilder: (context, index) {
                      final item =
                          recolectorController.filteredRecolectores[index];
                      return ListTile(
                        title: Text(item.nombre),
                        subtitle: Text(item.cedula),
                        onTap: () {
                          pesadaController
                              .updateSelectedRecolector(item.cedula);
                        },
                        /*trailing: IconButton(
            icon: Image.asset('images/basura.png'),
            onPressed: () => recolectorController
                .deleteRecolector(item.cedula),
          ),*/
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 2,
            child: FloatingActionButton(
              onPressed: () async {
                if (_pesadaController.text.isNotEmpty) {
                  String recolector = pesadaController.selectedRecolector;
                  String peso = _pesadaController.text.trim();
                  DateTime fecha = DateTime.now();

                  Pesada nuevaPesada = Pesada(
                    cedRecolector: recolector,
                    peso: peso,
                    fecha: fecha,
                  );

                  await pesadaController.savePesada(nuevaPesada);

                  // Limpia el campo de texto después de guardar
                  _pesadaController.clear();

                  // Muestra un mensaje de éxito
                  Get.snackbar('Éxito', 'Pesada guardada correctamente');
                } else {
                  // Muestra un mensaje de error si el campo de peso está vacío
                  Get.snackbar('Error', 'Por favor ingresa el peso');
                }
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: Color.fromRGBO(76, 140, 43, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*void _showAddRecolectorDialog(
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
  }*/
}
