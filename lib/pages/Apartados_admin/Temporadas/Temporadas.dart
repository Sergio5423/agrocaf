import 'package:agrocaf/widgets/informacion/info.dart';
import 'package:agrocaf/widgets/BottomNavigatorAdmin.dart';
import 'package:flutter/material.dart';

class Temporada extends StatefulWidget {
  const Temporada({super.key});

  @override
  State<Temporada> createState() => _nameState();
}

class _nameState extends State<Temporada> {
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
