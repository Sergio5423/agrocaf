import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNav/BottomNavigatorAdmin.dart';
import 'package:flutter/material.dart';

class Temporadas extends StatefulWidget {
  const Temporadas({super.key});

  @override
  State<Temporadas> createState() => _nameState();
}

class _nameState extends State<Temporadas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavi(),
      appBar: AppBar(
        title: const Text('Temporada'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Info(
              Texto: 'Temporada',
              cargo: '',
            ),
          ],
        )),
      ),
    );
  }
}
