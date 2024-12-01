/*import 'package:agrocaf/controllers/kilo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de que GetX esté importado

class informacionValor extends StatefulWidget {
  final String cargo;

  informacionValor({super.key, required this.cargo});

  @override
  State<informacionValor> createState() => _informacionValorState();
}

class _informacionValorState extends State<informacionValor> {
  final KiloController kiloController = Get.put(KiloController());

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
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () {
                        final kiloList = kiloController.kiloList;
                        if (kiloList.isEmpty) {
                          return const Text(
                            'Valor no ingresado',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          );
                        } else {
                          final valorKilo = kiloList.first.valor.toString();
                          return Text(
                            'valor kilo  $valorKilo',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          );
                        }
                      },
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
*/