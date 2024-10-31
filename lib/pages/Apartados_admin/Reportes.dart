import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNavigator.dart';
import 'package:flutter/material.dart';

class Admin_Reportes extends StatefulWidget {
  const Admin_Reportes({super.key});

  @override
  State<Admin_Reportes> createState() => _Admin_ReportesState();
}

class _Admin_ReportesState extends State<Admin_Reportes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(title: const Text('Reportes')),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [Info(Texto: 'Reportes', cargo: 'Admin')],
        )),
      ),
    );
  }
}
