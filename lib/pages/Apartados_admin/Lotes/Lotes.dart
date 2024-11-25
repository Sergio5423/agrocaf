import 'package:agrocaf/controllers/lotes_controller.dart';
import 'package:agrocaf/models/lotes_model.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:agrocaf/widgets/LogoutAdmin.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LotesAdmin extends StatelessWidget {
  final LoteController loteController = Get.put(LoteController());

  LotesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Lote loteVacio = Lote();
          Lote? lote = await _showAddLoteDialog(
              context, loteController, 'Nuevo', loteVacio);

          if (lote != null) {
            loteController.saveLote(lote);
          }
        },
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNaviAdmin(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        actions: [LogoutAdmin()],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Info(Texto: 'Lotes', cargo: 'Admin'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Buscar por nombre',
                  border: OutlineInputBorder(),
                ),
                onChanged: loteController.updateSearchQuery,
              ),
            ),
            Obx(() {
              if (loteController.filteredLotes.isEmpty) {
                return const Center(
                  child: Text('No hay lotes disponibles.'),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: loteController.filteredLotes.length,
                  itemBuilder: (context, index) {
                    final item = loteController.filteredLotes[index];
                    return ListTile(
                      title: Text(item.nombre),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete_forever),
                            onPressed: () {
                              if (item.id != null) {
                                loteController.deleteLote(item.id!);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<Lote?> _showAddLoteDialog(BuildContext context,
      LoteController loteController, String titulo, Lote lote) async {
    final TextEditingController nombreController =
        TextEditingController(text: lote.nombre);

    return showDialog<Lote?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: TextField(
            controller: nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String nombre = nombreController.text.trim();
                if (nombre.isNotEmpty) {
                  Navigator.of(context).pop(Lote(nombre: nombre));
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
  }
}
