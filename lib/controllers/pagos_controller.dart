import 'dart:io';

import 'package:agrocaf/models/pago_model.dart';
import 'package:agrocaf/models/recolector_model.dart';
import 'package:agrocaf/services/abono_service.dart';
import 'package:agrocaf/services/pesadas_service.dart';
import 'package:agrocaf/services/recolector_service.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagosController extends GetxController {
  int i = 0;
  PesadaService pesadas_service = PesadaService();
  AbonoService abono_service = AbonoService();
  RecolectorService recolector_service = RecolectorService();
  RxList<Pago> pagos = <Pago>[].obs;
  //var pagos = <Pago>[].obs;
  var searchQuery = ''.obs;
  var filteredPagos = <Pago>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilter();
  }

  void applyFilter() {
    if (searchQuery.value.isEmpty) {
      filteredPagos.value = List.from(pagos);
    } else {
      filteredPagos.value = pagos.where((pago) {
        return pago.nombRecolector
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
    print('Pagos filtrados: ${filteredPagos.length}');
  }

  Stream<List<Pago>> calcularPagosAgrupados() {
    return pesadas_service.getPesadas().asyncMap((pesadas) async {
      Map<String, double> pagosAgrupados = {};

      for (var pesada in pesadas) {
        double monto = double.parse(pesada.peso) * pesada.precio;

        if (pagosAgrupados.containsKey(pesada.cedula)) {
          pagosAgrupados[pesada.cedula] =
              pagosAgrupados[pesada.cedula]! + monto;
        } else {
          pagosAgrupados[pesada.cedula] = monto;
        }
      }

      var abonos = await abono_service.getAbonos().first;

      for (var abono in abonos) {
        if (pagosAgrupados.containsKey(abono.cedularecolector)) {
          pagosAgrupados[abono.cedularecolector] =
              pagosAgrupados[abono.cedularecolector]! -
                  double.parse(abono.abono);
        }
      }

      List<Pago> pagos = [];
      var recolectores = await recolector_service.getRecolectores().first;

      for (var pagoAgrupado in pagosAgrupados.entries) {
        for (Recolector recolector in recolectores) {
          if (recolector.cedula == pagoAgrupado.key) {
            Pago pago = Pago(
                cedulaRecolector: pagoAgrupado.key,
                nombRecolector: recolector.nombre,
                telefono: recolector.telefono,
                metodopago: recolector.metodopago,
                ncuenta: recolector.ncuenta,
                monto: pagoAgrupado.value);
            pagos.add(pago);
          }
        }
      }
      return pagos;
    });
  }

  void fetchPagos() async {
    while (isLoading.value) {
      isLoading.value = true;
    }

    calcularPagosAgrupados().listen((fetchedPagos) {
      pagos.value = fetchedPagos;

      // Usar addPostFrameCallback para evitar el error
      WidgetsBinding.instance.addPostFrameCallback((_) {
        applyFilter(); // Aplicar filtro después de la construcción
      });

      print('Fetched pagos: ${pagos.length}'); // Comprobar datos
      isLoading.value = false;
    });
  }

  Future<void> generateExcel() async {
    try {
      // Crear un nuevo libro de Excel
      var excel = Excel.createExcel(); // Obtener la hoja
      Sheet? sheet = excel['Sheet1'];

      sheet.appendRow([
        'Cédula',
        'Nombre del Recolector',
        'Teléfono',
        'Método de Pago',
        'Número de Cuenta',
        'Monto a pagar'
      ]);
      if (pagos.isNotEmpty) {
        for (var pago in pagos) {
          sheet.appendRow([
            pago.cedulaRecolector,
            pago.nombRecolector,
            pago.telefono,
            pago.metodopago,
            pago.ncuenta,
            pago.monto
          ]);
        }
      } else {
        print('No hay pagos disponibles para agregar a la hoja de Excel.');
      } // Guardar el archivo en el directorio de descargas
      final directory = Directory(
          '/storage/emulated/0/Download'); // Ruta del directorio de descargas en Android
      final String filePath = '${directory.path}/pagos${i++}.xlsx';
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
      Get.snackbar('Éxito', 'Archivo Excel generado en: $filePath');
    } catch (e) {
      print('Ocurrió un error al generar el archivo Excel: $e');
      Get.snackbar('Error', 'Ocurrió un error al generar el archivo Excel');
    }
  }
}
