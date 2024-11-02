import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/Botones_Pagos.dart';
import 'package:agrocaf/widgets/BottomNavigatorAdmin.dart';

import 'package:agrocaf/widgets/Tablas/Datos_Tablapezadas.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Pagos extends StatefulWidget {
  const Pagos({super.key});

  @override
  State<Pagos> createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  final RecolectorController recolectorController =
      Get.put(RecolectorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(
        title: const Text('Pagos'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Column(
          children: [
            Info(
              cargo: 'Admin',
              Texto: 'Valor del kilo \$-------',
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 260),
                  child: Text(
                    'APARTADOS',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    // Cambia Row por Column
                    children: [
                      // Primer Column con 3 elementos de texto
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Opcional: centrar el contenido en el Row
                                  children: [
                                    Container_Button_PagoState(
                                        ruta: '/apartado_recole',
                                        imagen: 'images/Reco.png',
                                        texto: 'Recolectores'),
                                    SizedBox(width: 16),
                                    // Espacio de 16 píxeles entre el primer y el segundo botón
                                    Container_Button_PagoState(
                                        ruta: '/apartado_pesadas',
                                        imagen: 'images/Pesa.png',
                                        texto: 'Pesadas'),
                                    SizedBox(
                                        width:
                                            16), // Espacio de 16 píxeles entre el segundo y el tercer botón
                                    Container_Button_PagoState(
                                        ruta: '/apartado_lotes',
                                        imagen: 'images/Lotes.png',
                                        texto: 'Lotes'),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 23, top: 20),
                            child: const Row(
                              children: [
                                Container_Button_PagoState(
                                    ruta: '/apartado_report',
                                    imagen: 'images/Report.png',
                                    texto: 'Reportes'),
                                SizedBox(
                                    width:
                                        16), // Espacio de 16 píxeles entre el segundo y el tercer botón
                                Container_Button_PagoState(
                                    ruta: '/apartado_kilo',
                                    imagen: 'images/kilo.png',
                                    texto: 'Kilo'),
                                SizedBox(
                                    width:
                                        13.5), // Espacio de 16 píxeles entre el segundo y el tercer botón
                                Container_Button_PagoState(
                                    ruta: '/apartado_abono',
                                    imagen: 'images/Abonos.png',
                                    texto: 'Abonos'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Segundo Column que contiene un Row con 2 elementos de texto
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 260),
                  child: Text(
                    'Pesadas',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                SizedBox(
                  width: 800,
                  height: 330,
                  child: Column(
                    children: [TablaPezadas()],
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
