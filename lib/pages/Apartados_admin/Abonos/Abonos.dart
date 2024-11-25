import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorOperador.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Admin_Abonos extends StatefulWidget {
  const Admin_Abonos({super.key});

  @override
  State<Admin_Abonos> createState() => _Admin_AbonosState();
}

class _Admin_AbonosState extends State<Admin_Abonos> {
  // Datos de ejemplo para la lista de abonos
  final List<Map<String, String>> abonos = [
    {'nombre': 'Abono Orgánico', 'cantidad': '50 kg'},
    {'nombre': 'Abono Químico', 'cantidad': '30 kg'},
    {'nombre': 'Fertilizante NPK', 'cantidad': '20 kg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para agregar un nuevo abono
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNaviOperador(),
      appBar: AppBar(title: const Text('Abonos')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Info(Texto: 'Abonos', cargo: 'Admin'),
              const SizedBox(height: 15),
              // Lista de abonos
              ListView.builder(
                shrinkWrap:
                    true, // Permite que la lista se ajuste al espacio disponible
                physics: const NeverScrollableScrollPhysics(),
                itemCount: abonos.length,
                itemBuilder: (context, index) {
                  final abono = abonos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: ListTile(
                      title: Text(abono['nombre']!),
                      subtitle: Text('Cantidad: ${abono['cantidad']}'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Detalles del Abono'),
                              content: SingleChildScrollView(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                    Text('Nombre: '),
                                    Text('Cantidad: ')
                                  ])),
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
                      leading: const Icon(Icons.grass, color: Colors.green),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            abonos.removeAt(
                                index); // Elimina el abono de la lista
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Acción para descargar Excel
                },
                child: SizedBox(
                  width: 180,
                  child: Row(
                    children: [
                      const Icon(Icons.file_download),
                      const SizedBox(width: 2),
                      const Text('Descargar Excel'),
                      const SizedBox(width: 2),
                      Image.asset('images/excel.png'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
