import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorOperador.dart';
import 'package:flutter/material.dart';

class Reportes extends StatefulWidget {
  const Reportes({super.key});

  @override
  State<Reportes> createState() => _Admin_ReportesState();
}

class _Admin_ReportesState extends State<Reportes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNaviOperador(),
      appBar: AppBar(title: const Text('Reportes')),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [Info(texto: 'Reportes', cargo: '', Texto: 'Reportes',)],
        )),
      ),
    );
  }
}
