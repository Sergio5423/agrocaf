import 'package:agrocaf/controllers/kilo_controller.dart';
import 'package:agrocaf/controllers/pesadas_controller.dart';
import 'package:agrocaf/models/kilo_model.dart';
import 'package:agrocaf/widgets/Botones.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:agrocaf/widgets/LogoutAdmin.dart';
import 'package:agrocaf/widgets/informacion/info.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _PagosState();
}

class _PagosState extends State<HomeAdmin> {
  final PesadaController pesadaController = Get.put(PesadaController());
  final KiloController kiloController = Get.put(KiloController());
  final TextEditingController valorKiloController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    pesadaController.fetchPesadas();

    return Scaffold(
      bottomNavigationBar: BottomNaviAdmin(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        actions: const [
          LogoutAdmin(),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              // Mostrar el valor de valorKilo de manera reactiva
              Info(
                texto: 'Reportes',
                cargo: 'Admin',
                Texto: 'Reportes',
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  const Row(children: [
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      'Opciones',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container_Button_State(
                                          ruta: '/recolectores_admin',
                                          imagen: 'images/Reco.png',
                                          texto: 'Recolectores'),
                                      SizedBox(width: 16),
                                      Container_Button_State(
                                          ruta: '/pesadas_admin',
                                          imagen: 'images/Pesa.png',
                                          texto: 'Pesadas'),
                                      SizedBox(width: 16),
                                      Container_Button_State(
                                          ruta: '/lotes',
                                          imagen: 'images/Lotes.png',
                                          texto: 'Lotes'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    SizedBox(width: 16),
                                    Container_Button_State(
                                        ruta: '/apartado_abono',
                                        imagen: 'images/Abonos.png',
                                        texto: 'Abonos'),
                                    SizedBox(width: 16),
                                    Container_Button_State(
                                        ruta: '/temporadas',
                                        imagen: 'images/calendario.png',
                                        texto: 'Temporadas'),
                                    SizedBox(width: 16),
                                    Container_Button_State(
                                        imagen: 'images/pagos.png',
                                        texto: 'Pagos',
                                        ruta: '/pagos'),
                                    /*Container(
                                      width: 100,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              child: InkWell(
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                        'images/kilo.png'),
                                                    const Text('Kilo')
                                                  ],
                                                ),
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                  ],
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 260),
                    child: Text(
                      'Pesadas',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                                      title: Text('Peso: ${item.peso} kg'),
                                      subtitle: Text('Nombre: ${item.nombre}'),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text('Detalles de Pesada',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(height: 10),
                                                    Text(
                                                        'Recolector: ${item.nombre}'),
                                                    Text(
                                                        'Cédula: ${item.cedula}'),
                                                    Text(
                                                        'Peso: ${item.peso} kg'),
                                                    Text(
                                                        'Precio: \$${item.precio}'),
                                                    Text('Lote: ${item.lote}'),
                                                    Text(
                                                        'Fecha: ${item.fecha.toString()}'),
                                                    SizedBox(height: 20),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
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
                                    ));
                              },
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
