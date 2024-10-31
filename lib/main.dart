import 'package:agrocaf/pages/Apartados_Operador/Home_Operador.dart';
import 'package:agrocaf/pages/Apartados_admin/Abonos/Abonos.dart';
import 'package:agrocaf/pages/Apartados_admin/Kilo/Kilo.dart';
import 'package:agrocaf/pages/Apartados_admin/Lotes/Lotes.dart';
import 'package:agrocaf/pages/Apartados_admin/Pesadas/Pesadas.dart';
import 'package:agrocaf/pages/Apartados_admin/Recolectores/Recolectores.dart';
import 'package:agrocaf/pages/Apartados_admin/Reportes.dart';
import 'package:agrocaf/firebase_options.dart';
import 'package:agrocaf/pages/Login/login_opciones.dart';
import 'package:agrocaf/pages/Login/login_operador.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Authenticaion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: LoginOpciones(),
      initialRoute: '/',
      getPages: [
        GetPage(page: () => LoginOpciones(), name: '/'),
        GetPage(page: () => LoginOperador(), name: '/LoginOperador'),
        GetPage(page: () => const HomeOperador(), name: '/homeOperador'),
        //GetPage(page: () => Apartado_Operador(), name: '/apartado_ope'),
        GetPage(page: () => const Admin_Abonos(), name: '/apartado_abono'),
        GetPage(page: () => const Admin_Kilo(), name: '/apartado_kilo'),
        GetPage(page: () => const Admin_Lotes(), name: '/apartado_lotes'),
        GetPage(page: () => const Admin_Pesadas(), name: '/apartado_pesadas'),
        GetPage(page: () => RecolectoresPage(), name: '/apartado_recole'),
        GetPage(page: () => const Admin_Reportes(), name: '/apartado_report'),
      ],
    );
  }
}
