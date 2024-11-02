import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNavigatorAdmin.dart';
import 'package:agrocaf/widgets/Tablas/Datos_Lotes.dart';
import 'package:flutter/material.dart';

class Admin_Lotes extends StatefulWidget {
  const Admin_Lotes({super.key});

  @override
  State<Admin_Lotes> createState() => _Admin_LotesState();
}

class _Admin_LotesState extends State<Admin_Lotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(title: const Text('Lotes')),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Info(Texto: 'Lotes', cargo: 'Admin'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Buscar ID Lote',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {},
              ),
            ),
            TablaLotes()
          ],
        )),
      ),
    );
  }
}
