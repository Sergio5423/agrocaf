import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agrocaf/controllers/pesadas_controller.dart';
import 'package:agrocaf/widgets/informacion/info.dart';

class Temporadas extends StatefulWidget {
  const Temporadas({super.key});

  @override
  State<Temporadas> createState() => _TemporadasState();
}

class _TemporadasState extends State<Temporadas> {
  final PesadaController _pesadaController = Get.put(PesadaController());
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _pesadaController.fetchPesadas();
  }

  void _filterByMonth(DateTime? date) {
    if (date == null) return;

    setState(() {
      selectedDate = date;
    });

    // Filtrar pesadas por el mes y año seleccionado
    _pesadaController.filteredPesadas.value = _pesadaController.pesadas
        .where((pesada) =>
            pesada.fecha.month == date.month && pesada.fecha.year == date.year)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNaviAdmin(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 140, 43, 1),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Info(
                Texto: 'Temporada',
                cargo: 'Admin',
              ),
              const SizedBox(height: 16),
              // Selector de Mes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? 'Mes: ${selectedDate!.month} - Año: ${selectedDate!.year}'
                          : 'Selecciona un mes',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        _filterByMonth(date);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Lista de Pesadas Filtradas
              Obx(() {
                if (_pesadaController.filteredPesadas.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No hay pesadas registradas para este mes.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pesadaController.filteredPesadas.length,
                  itemBuilder: (context, index) {
                    final pesada = _pesadaController.filteredPesadas[index];
                    return ListTile(
                      title: Text(
                        '${pesada.nombre} (${pesada.cedula})',
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        'Peso: ${pesada.peso} kg\nFecha: ${pesada.fecha.toLocal()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Detalles de Pesada',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Recolector: ${pesada.nombre}'),
                                    Text('Cédula: ${pesada.cedula}'),
                                    Text('Peso: ${pesada.peso} kg'),
                                    Text('Fecha: ${pesada.fecha.toString()}'),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
                      isThreeLine: true,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
