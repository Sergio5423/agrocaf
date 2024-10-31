import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNavigator.dart';
import 'package:flutter/material.dart';

class Admin_Kilo extends StatefulWidget {
  const Admin_Kilo({super.key});

  @override
  State<Admin_Kilo> createState() => _Admin_KiloState();
}

class _Admin_KiloState extends State<Admin_Kilo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(title: const Text('Pesadas')),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [Info(Texto: 'Kilo', cargo: 'Admin')],
        )),
      ),
    );
  }
}
