import 'package:agrocaf/pages/Apartados_Operador/Home_Operador.dart';
import 'package:agrocaf/pages/Apartados_admin/Home_Administrador.dart';
import 'package:agrocaf/pages/Apartados_admin/Lotes/Lotes.dart';
import 'package:agrocaf/pages/Apartados_admin/Pesadas/Pesadas_Admin.dart';
import 'package:agrocaf/pages/Apartados_admin/Recolectores/Recolectores_Admin.dart';
import 'package:agrocaf/pages/Apartados_admin/Temporadas/Temporadas.dart';
import 'package:agrocaf/pages/Apartados_admin/Abonos/Abonos.dart';
import 'package:agrocaf/pages/Apartados_admin/Kilo/Kilo.dart';
import 'package:agrocaf/pages/Apartados_Operador/Pesadas/Pesadas_Operador.dart';
import 'package:agrocaf/pages/Apartados_Operador/Recolectores/Recolectores_Operador.dart';
import 'package:agrocaf/pages/Reportes.dart';
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

  runApp(agrocaf());
}

class agrocaf extends StatelessWidget {
  const agrocaf({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Agrocaf',
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
        GetPage(page: () => const HomeAdmin(), name: '/homeAdministrador'),
        //GetPage(page: () => Apartado_Operador(), name: '/apartado_ope'),
        GetPage(page: () => const Admin_Abonos(), name: '/apartado_abono'),
        GetPage(page: () => const Admin_Kilo(), name: '/apartado_kilo'),
        //GetPage(page: () => const Lotes_Operador(), name: '/lotes_operador'),
        GetPage(page: () => PesadasOperador(), name: '/pesadas_operador'),
        GetPage(page: () => PesadasAdmin(), name: '/pesadas_admin'),
        GetPage(page: () => LotesAdmin(), name: '/lotesAdmin'),
        GetPage(
            page: () => RecolectoresOperador(), name: '/recolectores_operador'),
        GetPage(page: () => RecolectoresAdmin(), name: '/recolectores_admin'),
        GetPage(page: () => const Reportes(), name: '/apartado_report'),
        GetPage(page: () => Temporadas(), name: '/temporadas'),
      ],
    );
  }
}
