import 'package:agrocaf/controllers/kilo_controller.dart';
import 'package:agrocaf/controllers/lotes_controller.dart';
import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:agrocaf/controllers/pesadas_controller.dart';
import 'package:agrocaf/models/lotes_model.dart';
import 'package:agrocaf/models/pesadas_model.dart';
import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RegistroPesadaOperador extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _pesadaController = TextEditingController();
  final RxString selectedLote = ''.obs; // Reactive variable for selected lote

  RegistroPesadaOperador({super.key});

  @override
  Widget build(BuildContext context) {
    final RecolectorController recolectorController = Get.find();
    final PesadaController pesadaController = Get.put(PesadaController());
    final LoteController loteController = Get.put(LoteController());
    final KiloController kiloController = Get.put(KiloController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Info(
                texto: 'Valor del Kilo',
                cargo: 'Operador', Texto: '',
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Ingrese pesada',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                          child: const Center(child: Text('KG')),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: _pesadaController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Pesada',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('Escoja un lote:  '),
                        Obx(() {
                          return DropdownButton<String>(
                            value: selectedLote.value.isNotEmpty
                                ? selectedLote.value
                                : null,
                            hint: const Text("Seleccione el lote"),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                selectedLote.value =
                                    newValue; // Update selected value
                              }
                            },
                            items: loteController.filteredLotes
                                .map<DropdownMenuItem<String>>((Lote lote) {
                              return DropdownMenuItem<String>(
                                value: lote.nombre,
                                child: Text(lote.nombre),
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                      labelText: 'Buscar Recolector',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      hintText: 'Ingrese Nombre a Buscar'),
                  onChanged: (value) {
                    recolectorController.updateSearchQuery(value);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: recolectorController.filteredRecolectores.length,
                    itemBuilder: (context, index) {
                      final item =
                          recolectorController.filteredRecolectores[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        child: ListTile(
                          title: Text(item.nombre),
                          subtitle: Text(item.cedula),
                          onTap: () {
                            pesadaController.updateSelectedRecolector(item);
                            Get.snackbar(item.nombre, 'Seleccionado');
                          },
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_pesadaController.text.isNotEmpty &&
              selectedLote.value.isNotEmpty) {
            String cedula = pesadaController.selectedRecolectorCedula;
            String nombre = pesadaController.selectedRecolectorNombre;
            String peso = _pesadaController.text.trim();
            DateTime fecha = DateTime.now();

            Pesada nuevaPesada = Pesada(
                cedula: cedula,
                nombre: nombre,
                peso: peso,
                fecha: fecha,
                lote: selectedLote.value,
                precio: kiloController.kiloList.first.valor);

            await pesadaController.savePesada(nuevaPesada);
            _pesadaController.clear();
            Get.snackbar('Éxito', 'Pesada guardada correctamente');
          } else {
            Get.snackbar('Error', 'Por favor ingrese todos los datos');
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Color.fromRGBO(76, 140, 43, 1),
        ),
      ),
    );
  }
}
