import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNavigatorAdmin.dart';
import 'package:agrocaf/widgets/Tablas/Datos_recolector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class add_Abonos extends StatefulWidget {
  const add_Abonos({super.key});

  @override
  State<add_Abonos> createState() => _add_AbonosState();
}

class _add_AbonosState extends State<add_Abonos> {
  final RecolectorController controller = Get.put(RecolectorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavi(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                Info(Texto: 'Agregar Abonos', cargo: 'Admi'),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 220,
                    child: TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Buscar Recolector',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        controller.updateSearchQuery(value);
                      },
                    ),
                  ),
                ),
                Tablarecolectores(),
                const Divider(),
                const SizedBox(height: 20),
                Container(
                  color:
                      Colors.white, // Cambiar el color del contenedor a blanco
                  padding: const EdgeInsets.all(
                      8.0), // Añadir un poco de padding para un mejor aspecto
                  child: const Column(
                    mainAxisSize: MainAxisSize
                        .min, // Ajustar el tamaño del contenedor al contenido
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment
                            .topLeft, // Alinear el texto a la izquierda
                        child: Text('Ingrese El monto Deseado',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.attach_money_outlined),
                          SizedBox(
                              width:
                                  8), // Espacio entre el icono y el TextField
                          Expanded(
                            // Usar Expanded para que el TextField ocupe el espacio restante
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const SizedBox(
                      width: 140,
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 2,
                          ),
                          Text('Agregar Monto'),
                          SizedBox(
                            width: 2,
                          ),
                        ],
                      ),
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
