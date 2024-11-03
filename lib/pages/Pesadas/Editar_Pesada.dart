/*import 'package:agrocaf/models/pesadas_model.dart';
import 'package:agrocaf/widgets/BottomNavigatorAdmin.dart'; // Widget para la barra de navegación
import 'package:flutter/material.dart';

class EditPezadaPage extends StatelessWidget {
  final Pesada pesada;

  EditPesadaPage({super.key, required this.pesada});

  final TextEditingController idController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController calidadController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController recolectorCedulaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(
        title: const Text('Editar Pezada'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  TextField(
                    controller: idController
                      ..text = pezada.id, // Rellenar con el valor actual
                    decoration: const InputDecoration(labelText: 'ID Pezada'),
                  ),
                  TextField(
                    controller: pesoController
                      ..text = pezada.peso
                          .toString(), // Rellenar con el valor actual
                    decoration: const InputDecoration(labelText: 'Peso'),
                    keyboardType:
                        TextInputType.number, // Para ingresar valores numéricos
                  ),
                  TextField(
                    controller: calidadController
                      ..text = pezada.calidad, // Rellenar con el valor actual
                    decoration: const InputDecoration(labelText: 'Calidad'),
                  ),
                  TextField(
                    controller: fechaController
                      ..text = pezada.fecha
                          .toLocal()
                          .toString(), // Rellenar con el valor actual
                    decoration: const InputDecoration(labelText: 'Fecha'),
                  ),
                  TextField(
                    controller: recolectorCedulaController
                      ..text = pezada
                          .recolectorCedula, // Rellenar con el valor actual
                    decoration: const InputDecoration(
                        labelText: 'Cédula del Recolector'),
                  ),
                  const SizedBox(height: 40),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green, // Color del texto
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                            label: const Text('Agregar'),
                          ),
                          const SizedBox(width: 3),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green, // Color del texto
                            ),
                            onPressed: () {
                              // Lógica para eliminar la Pezada actual
                              // Cierra la pantalla de edición después de eliminar
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text('Eliminar'),
                          ),
                          const SizedBox(width: 3),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green, // Color del texto
                            ),
                            onPressed: () {
                              // Actualizar la Pezada
                              // Cierra la pantalla de edición
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('Editar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/