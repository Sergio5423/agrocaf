import 'package:flutter/material.dart';

class TablaAbonos extends StatefulWidget {
  const TablaAbonos({super.key});

  @override
  _TablaAbonosState createState() => _TablaAbonosState();
}

class _TablaAbonosState extends State<TablaAbonos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(columns: const [
          DataColumn(label: Text('ID Abono')),
          DataColumn(label: Text('Monto')),
          DataColumn(label: Text('Fecha')),
          DataColumn(label: Text('Recolector')),
          DataColumn(label: Text('Método de Pago')),
          DataColumn(label: Text('Acciones')),
        ], rows: [
          DataRow(
            cells: [
              const DataCell(Text('Abono001')),
              const DataCell(Text('\$150')),
              const DataCell(Text('2024-10-15')),
              const DataCell(Text('123456789')), // Cédula del recolector
              const DataCell(Text('Efectivo')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el abono
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el abono
                    },
                  ),
                ],
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Abono002')),
              const DataCell(Text('\$200')),
              const DataCell(Text('2024-10-10')),
              const DataCell(Text('987654321')), // Cédula del recolector
              const DataCell(Text('Transferencia')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el abono
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el abono
                    },
                  ),
                ],
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Abono003')),
              const DataCell(Text('\$300')),
              const DataCell(Text('2024-10-05')),
              const DataCell(Text('456123789')), // Cédula del recolector
              const DataCell(Text('Efectivo')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el abono
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el abono
                    },
                  ),
                ],
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Abono004')),
              const DataCell(Text('\$250')),
              const DataCell(Text('2024-09-30')),
              const DataCell(Text('321654987')), // Cédula del recolector
              const DataCell(Text('Transferencia')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el abono
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el abono
                    },
                  ),
                ],
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Abono005')),
              const DataCell(Text('\$180')),
              const DataCell(Text('2024-10-12')),
              const DataCell(Text('789123456')), // Cédula del recolector
              const DataCell(Text('Efectivo')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el abono
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el abono
                    },
                  ),
                ],
              )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Abono006')),
              const DataCell(Text('\$220')),
              const DataCell(Text('2024-09-28')),
              const DataCell(Text('963852741')), // Cédula del recolector
              const DataCell(Text('Transferencia')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Image.asset('images/edit.png'),
                    onPressed: () {
                      // Lógica para editar el abono
                    },
                  ),
                  IconButton(
                    icon: Image.asset('images/delete.png'),
                    onPressed: () {
                      // Lógica para eliminar el abono
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
