import 'package:flutter/material.dart';

class TablaLotes extends StatefulWidget {
  const TablaLotes({super.key});

  @override
  _TablaLotesState createState() => _TablaLotesState();
}

class _TablaLotesState extends State<TablaLotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(columns: const [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Restricción')),
          DataColumn(label: Text('Plantas')),
          DataColumn(label: Text('Hectáreas')),
          DataColumn(label: Text('Acciones')),
        ], rows: [
          DataRow(
            cells: [
              const DataCell(Text('Lote A')),
              const DataCell(Text('Ninguna')),
              const DataCell(Text('Café')),
              const DataCell(Text('2.5')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el lote
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el lote
                    },
                  ),
                ],
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Lote B')),
              const DataCell(Text('Fertilizante')),
              const DataCell(Text('Cacao')),
              const DataCell(Text('1.2')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el lote
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el lote
                    },
                  ),
                ],
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Lote C')),
              const DataCell(Text('Riego restringido')),
              const DataCell(Text('Arroz')),
              const DataCell(Text('3.0')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el lote
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el lote
                    },
                  ),
                ],
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Lote D')),
              const DataCell(Text('Ninguna')),
              const DataCell(Text('Frijol')),
              const DataCell(Text('1.8')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el lote
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el lote
                    },
                  ),
                ],
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Lote E')),
              const DataCell(Text('Invernadero')),
              const DataCell(Text('Maíz')),
              const DataCell(Text('2.0')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el lote
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el lote
                    },
                  ),
                ],
              )),
            ],
          ),
        ]),
      ),
    );
  }
}
