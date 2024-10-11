import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:agrocaf/pages/info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroPesadaOperador extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final RecolectorController _recolectorController =
        Get.find(); // Obtener el controlador de RecolectorController
    return Column(
      children: [
        info(),
        Column(
          children: [
            Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Ingrese la pesada'),
                      Text('Peso'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Seleccione el recolector'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Buscar por nombre',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _recolectorController.updateSearchQuery(
                  value); // Actualizar la búsqueda en el controlador
            },
          ),
        ),
        Expanded(
          child: Obx(() {
            print(
                'Building ListView with ${_recolectorController.filteredRecolectores.length} items');
            return ListView.builder(
              itemCount: _recolectorController.filteredRecolectores.length,
              itemBuilder: (context, index) {
                final item = _recolectorController.filteredRecolectores[index];
                return ListTile(
                  title: Text(item.cedula),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () =>
                        _recolectorController.deleteRecolector(item.cedula),
                  ),
                );
              },
            );
          }),
        ),
        Plus(),
      ],
    );
  }
}

class Plus extends StatelessWidget {
  const Plus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            margin: EdgeInsets.only(right: 20),
            color: Color.fromRGBO(252, 252, 252, 1),
            child: Icon(
              Icons.add,
              size: 40,
              color: Color.fromRGBO(76, 140, 43, 1),
            ),
          ),
        )
      ],
    );
  }
}
