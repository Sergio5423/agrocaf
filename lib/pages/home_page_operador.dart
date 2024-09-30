/*import 'package:auth_2024/pages/page1.dart';
import 'package:auth_2024/pages/page2.dart';
import 'package:auth_2024/pages/page4.dart';*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController _authController =
      Get.find(); // Obtener el controlador de autenticación
  int _selectedIndex = 0;

  // Lista de las cuatro páginas
  final List<Widget> _pages = [
    Page1(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(76, 140, 43, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authController.signOut(); // Llamar al método de cerrar sesión
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      backgroundColor:
          Color.fromRGBO(244, 246, 255, 1), // Mostrar la página seleccionada
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Página 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Página 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Página 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Página 4',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            Theme.of(context).primaryColor, // Color cuando está seleccionado
        unselectedItemColor: Colors.grey, // Color cuando no está seleccionado
        onTap: _onItemTapped,
      ),
    );
  }
}

// Ejemplo de las páginas

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        info(),
        Column(
          children: [
            Container(
                color: Color.fromRGBO(255, 255, 255, 1),
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(20),
                child: Row(children: [
                  Column(children: [Text('Ingrese la pesada'), Text('Peso')]),
                ])),
            Container(
                color: Color.fromRGBO(255, 255, 255, 1),
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(20),
                child: Row(children: [
                  Column(children: [
                    Text('Seleccione el recolector'),
                  ]),
                ])),
          ],
        )
      ],
    );
  }
}

class info extends StatelessWidget {
  const info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(76, 140, 43, 1),
      padding: EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'images/agrocaf_logo.png',
                  height: 150.0,
                  width: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text('Agrocaf\nOperador',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Color.fromRGBO(255, 255, 255, 0.965),
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        )),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(90),
              )),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              color: Color.fromRGBO(252, 252, 252, 1),
              padding: EdgeInsets.symmetric(horizontal: 170, vertical: 8),
              //margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text('Valor del Kilo --------'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTextField(
    BuildContext context, String hintText, TextEditingController controller,
    {bool obscureText = false}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: hintText,
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
