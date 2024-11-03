import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/pages/Apartados_admin/Abonos/Nuevo_Abono.dart';

import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:agrocaf/widgets/Tablas/Datos.Abonos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Admin_Abonos extends StatefulWidget {
  const Admin_Abonos({super.key});

  @override
  State<Admin_Abonos> createState() => _Admin_AbonosState();
}

class _Admin_AbonosState extends State<Admin_Abonos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const add_Abonos());
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(title: const Text('Abonos')),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Info(Texto: 'Abonos', cargo: 'Admin'),
            TablaAbonos(),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
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
}
