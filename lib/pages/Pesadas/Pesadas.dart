import 'package:agrocaf/controllers/pesadas_controller.dart';
import 'package:agrocaf/widgets/Logout.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Pesadas extends StatelessWidget {
  final PesadaController pesadaController = Get.put(PesadaController());
  Pesadas({super.key});

  @override
  Widget build(BuildContext context) {
    pesadaController.fetchPesadas();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Get.to(AddPesadas());
        },
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        actions: [
          Logout(),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Info(Texto: 'Pesadas', cargo: 'Operador'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Buscar Por Id Pesadas',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {},
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
                          return ListTile(
                            title: Text(item.cedRecolector),
                            subtitle: Text(item.peso),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Detalles de Pesada',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 10),
                                        Text(
                                            'Recolector: ${item.cedRecolector}'),
                                        Text('Peso: ${item.peso} kg'),
                                        Text('Fecha: ${item.fecha.toString()}'),
                                        SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cerrar'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
