import 'dart:async';
import 'package:agrocaf/controllers/pagos_controller.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PagosAdmin extends StatelessWidget {
  final PagosController pagosController = Get.put(PagosController());
  PagosAdmin({super.key});

  Future<void> requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    pagosController.fetchPagos();
    return Scaffold(
      bottomNavigationBar: BottomNaviAdmin(),
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
                Info(
                  texto: 'Pagos',
                  cargo: 'Admin',
                  Texto: '',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Buscar por nombre',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      pagosController.updateSearchQuery(value);
                    },
                  ),
                ),
                Obx(() {
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: pagosController.filteredPagos.length,
                      itemBuilder: (context, index) {
                        final item = pagosController.filteredPagos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: ListTile(
                            title: Text(item.nombRecolector),
                            subtitle: Text(item.monto.toString()),
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
                                          Text(
                                              'Cédula: ${item.cedulaRecolector}'),
                                          Text(
                                              'Nombre: ${item.nombRecolector}'),
                                          Text('Teléfono: ${item.telefono}'),
                                          Text(
                                              'Método de Pago: ${item.metodopago}'),
                                          Text(
                                              'Número de Cuenta: ${item.ncuenta}'),
                                          Text('Monto a pagar: ${item.monto}')
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
                            /*trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              
                            ),*/
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
                    pagosController
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
}
