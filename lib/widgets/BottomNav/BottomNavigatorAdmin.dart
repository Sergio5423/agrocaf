import 'package:agrocaf/controllers/kilo_controller.dart';
import 'package:agrocaf/pages/Apartados_admin/Home_Administrador.dart';
import 'package:agrocaf/pages/Configuracion/Configuracion.dart';
//import 'package:agrocaf/pages/Apartados_Operador/Principal/Principal.dart';
//import 'package:agrocaf/pages/Apartados_Operador/Temporadas/Temporadas.dart';
import 'package:agrocaf/pages/Reportes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BottomNaviAdmin extends StatelessWidget {
  BottomNaviAdmin({super.key});
  final KiloController kiloController = Get.put(KiloController());
  final TextEditingController valorKiloController = TextEditingController();
  void _HomeAdmin(BuildContext context) {
    Get.to(const HomeAdmin());
  }

  void _Kilo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingrese el Valor del Kilo'),
          content: TextField(
            controller: valorKiloController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'Ingrese solo números',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String valorkilo = valorKiloController.text;
                kiloController.saveKilo(int.parse(valorkilo));
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _Reportes(BuildContext context) {
    Get.to(const Reportes());
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white,
      backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
      onTap: (int index) {
        switch (index) {
          /*case 0:
            _HomeAdmin(context);
            break;*/
          case 0:
            _HomeAdmin(context);
            break;
          case 1:
            _Kilo(context);
            break;
          case 2:
            _Reportes(context);
            break;
          /*case 2:
            _Configuracion(context);
            break;*/
        }
      },
      items: [
        /*BottomNavigationBarItem(
          icon: Icon(Icons.scale),
          label: 'Nueva Pesada',
        ),*/
        BottomNavigationBarItem(
          icon: Icon(Icons.house_outlined),
          label: 'Principal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Kilo',
        ),
        /*BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          label: 'Reportes',
        ),*/
        /*BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configuración',
        ),*/
      ],

      showUnselectedLabels:
          true, // Asegura que se muestren las etiquetas no seleccionadas
    );
  }
}
