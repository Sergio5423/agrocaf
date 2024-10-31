import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/pages/Apartados_admin/Pesadas/Nueva_Pesada.dart';

import 'package:agrocaf/widgets/BottomNavigator.dart';
import 'package:agrocaf/widgets/Tablas/Datos_Tablapezadas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Admin_Pesadas extends StatelessWidget {
  const Admin_Pesadas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddPesadas());
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(title: const Text('Pesadas')),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Info(Texto: 'Pesadas', cargo: 'Admin'),
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
            TablaPezadas()
          ],
        )),
      ),
    );
  }
}
