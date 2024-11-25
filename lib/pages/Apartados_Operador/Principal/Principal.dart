import 'package:agrocaf/controllers/pesadas_controller.dart';
import 'package:agrocaf/widgets/LogoutOperador.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/Botones_Pagos.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorOperador.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PagosState();
}

class _PagosState extends State<Principal> {
  final PesadaController pesadaController = Get.put(PesadaController());
  @override
  Widget build(BuildContext context) {
    pesadaController.fetchPesadas();
    return Scaffold(
      bottomNavigationBar: BottomNaviOperador(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
        actions: [
          LogoutOperador(),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Column(
          children: [
            Info(
              cargo: 'Operador',
              Texto: '',
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
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                //alignment: Alignment.center,
                                margin: const EdgeInsets.only(left: 20),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Opcional: centrar el contenido en el Row
                                  children: [
                                    Container_Button_PagoState(
                                        ruta: '/recolectores_operador',
                                        imagen: 'images/Reco.png',
                                        texto: 'Recolectores'),
                                    SizedBox(width: 16),
                                    // Espacio de 16 píxeles entre el primer y el segundo botón
                                    Container_Button_PagoState(
                                        ruta: '/pesadas_operador',
                                        imagen: 'images/Pesa.png',
                                        texto: 'Pesadas'),
                                    SizedBox(
                                        width:
                                            16), // Espacio de 16 píxeles entre el segundo y el tercer botón
                                    /*Container_Button_PagoState(
                                        ruta: '/apartado_lotes',
                                        imagen: 'images/Lotes.png',
                                        texto: 'Lotes'),*/
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 23, top: 20),
                            child: const Row(
                              children: [
                                /*Container_Button_PagoState(
                                    ruta: '/apartado_kilo',
                                    imagen: 'images/kilo.png',
                                    texto: 'Kilo'),
                                SizedBox(
                                    width:
                                        13.5),*/
                                /*Container_Button_PagoState(
                                    ruta: '/apartado_abono',
                                    imagen: 'images/Abonos.png',
                                    texto: 'Abonos'),
                                SizedBox(width: 16),*/
                                /*Container_Button_PagoState(
                                    ruta: '/temporadas',
                                    imagen: 'images/calendario.png',
                                    texto: 'Temporadas'),*/
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
                    children: [
                      Obx(() {
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: pesadaController.pesadas.length,
                            itemBuilder: (context, index) {
                              final item = pesadaController.pesadas[index];
                              print(item);
                              return ListTile(
                                title: Text('Peso: ${item.peso} kg'),
                                subtitle: Text('Nombre: ${item.nombre}'),
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
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 10),
                                            Text('Recolector: ${item.cedula}'),
                                            Text('Peso: ${item.peso} kg'),
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
            ),
          ],
        )),
      ),
    );
  }
}
