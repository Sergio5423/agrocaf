import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  final String Texto;
  final String cargo; // Añadido: parámetro para el valor del kilo

  // Constructor que recibe el valor del kilo
  const Info({super.key, required this.Texto, required this.cargo});

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late String valorDelKilo; // Variable para almacenar el valor del kilo

  @override
  void initState() {
    super.initState();
    valorDelKilo = widget.Texto; // Inicializa el valor del kilo
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: const Color.fromRGBO(76, 140, 43, 1),
        padding: const EdgeInsets.only(bottom: 16.0, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'images/agrocaf_logo.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Agrocaf\n${widget.cargo}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color.fromRGBO(255, 255, 255, 0.965),
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                height: 50,
                width: 300,
                color: Colors.white,
                child: Align(
                  alignment: Alignment.center, // Alineación centrada
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      valorDelKilo,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
