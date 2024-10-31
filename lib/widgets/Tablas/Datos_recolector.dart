import 'package:agrocaf/controllers/recolector_controller.dart';

import 'package:agrocaf/pages/Apartados_admin/Recolectores/Editar_Recolector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tablarecolectores extends StatelessWidget {
  Tablarecolectores({super.key});
  final RecolectorController controller = Get.put(RecolectorController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Resto de tu código para la tabla
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.filteredRecolectores.isEmpty) {
              return const Center(
                  child: Text('No hay recolectores para mostrar.'));
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Cédula')),
                  DataColumn(label: Text('Nombre del Recolector')),
                  DataColumn(label: Text('Teléfono')),
                  DataColumn(label: Text('Método de Pago')),
                  DataColumn(label: Text('Número de Cuenta')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: controller.filteredRecolectores.map((recolector) {
                  return DataRow(
                    cells: [
                      DataCell(Text(recolector.cedula)),
                      DataCell(Text(recolector.nombre)),
                      DataCell(Text(recolector.telefono)),
                      DataCell(Text(recolector.metodopago)),
                      DataCell(Text(recolector.ncuenta)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Image.asset('images/edit.png'),
                              onPressed: () {
                                Get.to(() =>
                                    EditRecolectorPage(recolector: recolector));
                              },
                            ),
                            IconButton(
                              icon: Image.asset('images/delete.png'),
                              onPressed: () {
                                controller.deleteRecolector(recolector.cedula);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
