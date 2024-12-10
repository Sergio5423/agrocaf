import 'dart:async';
import 'package:agrocaf/controllers/kilo_controller.dart';
import 'package:agrocaf/controllers/pesadas_controller.dart';
import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:agrocaf/models/kilo_model.dart';
import 'package:agrocaf/models/pesadas_model.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:agrocaf/widgets/LogoutAdmin.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PesadasAdmin extends StatelessWidget {
  final PesadaController pesadaController = Get.put(PesadaController());
  final KiloController kiloController = Get.put(KiloController());
  final RecolectorController recolectorController =
      Get.put(RecolectorController());
  TextEditingController buscarRecolectorController = TextEditingController();
  PesadasAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    pesadaController.fetchPesadas();
    return Scaffold(
      bottomNavigationBar: BottomNaviAdmin(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        actions: [
          LogoutAdmin(),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Info(
              texto: 'Pesadas',
              cargo: 'Admin',
              Texto: '',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: buscarRecolectorController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Buscar por Nombre de recolector Admin',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  recolectorController.updateSearchQuery(value);
                },
              ),
            ),
            SizedBox(
              width: 800,
              height: 330,
              child: Column(
                children: [
                  Obx(() {
                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: pesadaController.pesadas.length,
                        itemBuilder: (context, index) {
                          final item = pesadaController.pesadas[index];
                          return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: ListTile(
                                title: Text(item.nombre),
                                subtitle: Text(item.peso),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Detalles de Pesada',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  'Recolector: ${item.nombre}'),
                                              Text('Cédula: ${item.cedula}'),
                                              Text('Peso: ${item.peso} kg'),
                                              Text('Precio: \$${item.precio}'),
                                              Text('Lote: ${item.lote}'),
                                              Text(
                                                  'Fecha: ${item.fecha.toString()}'),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Cerrar'),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                        //print(item.id);
                                        Pesada? pesada =
                                            await _showAddPesadaDialog(
                                                context,
                                                pesadaController,
                                                'Actualizar',
                                                item);
                                        if (pesada != null) {
                                          pesadaController.updateItem(pesada);
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
                                      onPressed: () => pesadaController
                                          .deletePesada(item.id.toString()),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                pesadaController
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
        )),
      ),
    );
  }

  Future<Pesada?> _showAddPesadaDialog(BuildContext context,
      PesadaController pesadaController, String titulo, Pesada pesada) {
    final TextEditingController _cedRecolectorController =
        TextEditingController(text: pesada.cedula);
    final TextEditingController _nomRecolectorController =
        TextEditingController(text: pesada.nombre);
    final TextEditingController _fechaController =
        TextEditingController(text: pesada.fecha.toString());
    final TextEditingController _pesoController =
        TextEditingController(text: pesada.peso);
    final TextEditingController _loteController =
        TextEditingController(text: pesada.lote);

    Completer<Pesada?> completer = Completer();
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
                  controller: _cedRecolectorController,
                  decoration: const InputDecoration(labelText: 'Cédula'),
                ),
                TextFormField(
                  controller: _fechaController,
                  decoration: InputDecoration(
                    labelText: 'Fecha',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      _fechaController.text = formattedDate;
                    }
                  },
                ),
                TextField(
                  controller: _pesoController,
                  decoration: const InputDecoration(labelText: 'Peso'),
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
                String cedRecolector = _cedRecolectorController.text.trim();
                String nomRecolector = _nomRecolectorController.text.trim();
                String peso = _pesoController.text.trim();
                DateTime fecha = DateTime.parse(_fechaController.text.trim());
                String lote = _loteController.text.trim();
                if (cedRecolector.isNotEmpty && peso.isNotEmpty) {
                  Pesada updatedPesada = Pesada(
                      id: pesada.id,
                      nombre: nomRecolector,
                      cedula: cedRecolector,
                      peso: peso,
                      fecha: fecha,
                      lote: lote,
                      precio: kiloController.kiloList.first.valor);
                  Navigator.of(context).pop();
                  completer.complete(updatedPesada);
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
