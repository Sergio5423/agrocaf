import 'dart:io';

import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:agrocaf/models/pesadas_model.dart';
import 'package:agrocaf/services/pesadas_service.dart';

class PesadaController extends GetxController {
  int i = 0;
  final PesadaService _pesadaService = PesadaService();
  var pesadas = <Pesada>[].obs;
  var filteredPesadas = <Pesada>[].obs; // Lista observable de ítems filtrados
  var isLoading = false.obs;
  var valorKilo = ''.obs;
  var _selectedRecolectorNombre = ''.obs;
  var _selectedRecolectorCedula = ''.obs;
  var _selectedPesada = ''.obs;

  void selectPesada(String id) {
    _selectedPesada.value = id;
  }
  /* @override
  void onInit() {
    super.onInit();
    fetchPesadas();
  }*/

  void fetchPesadas() {
    try {
      isLoading.value = true;
      _pesadaService.getPesadas().listen((pesadaList) {
        pesadas.assignAll(pesadaList);
        isLoading.value = false;
        print('Fetched pesadas: ${pesadas.length}');
      });
    } catch (e) {
      print('Error al cargar pesadas: $e');
      isLoading.value = false;
    }
  }

  Future<void> savePesada(Pesada pesada) async {
    try {
      isLoading.value = true;
      await _pesadaService.savePesada(pesada);
      /* fetchPesadas();*/
    } catch (e) {
      print('Error al guardar la pesada: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedRecolector(recolector) {
    _selectedRecolectorNombre.value = recolector.nombre;
    _selectedRecolectorCedula.value = recolector.cedula;
  }

  Future<void> updateItem(Pesada pesada) async {
    try {
      isLoading.value = true;

      await _pesadaService.updatePesada(pesada);
      Get.snackbar('Éxito', 'Recolector actualizado correctamente');
      fetchPesadas(); // Volver a cargar los ítems después de actualizar
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al actualizar el ítem');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para eliminar un ítem
  Future<void> deletePesada(String pesadaId) async {
    try {
      isLoading.value = true;
      await _pesadaService.deletePesada(pesadaId);
      Get.snackbar('Éxito', 'Ítem eliminado correctamente');
      fetchPesadas(); // Volver a cargar los ítems después de eliminar
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al eliminar el ítem');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para generar el archivo Excel
  Future<void> generateExcel() async {
    var excel = Excel.createExcel(); // Crear un nuevo libro de Excel
    Sheet sheet = excel['Sheet1']; // Agregar encabezados
    sheet.appendRow([
      'Recolector',
      'Peso',
      'Lote',
      'Fecha',
    ]); // Agregar datos
    for (var pesada in pesadas) {
      sheet.appendRow([
        pesada.nombre,
        pesada.peso,
        pesada.lote,
        pesada.fecha.toString(),
      ]);
    } // Guardar el archivo en el directorio de descargas
    final directory = Directory(
        '/storage/emulated/0/Download'); // Ruta del directorio de descargas en Android

    final String filePath = '${directory.path}/pesadas${i++}.xlsx';
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);
    Get.snackbar('Éxito', 'Archivo Excel generado en: $filePath');
    // Mostrar un mensaje de éxito }
  }

  String get selectedRecolectorNombre => _selectedRecolectorNombre.value;
  String get selectedRecolectorCedula => _selectedRecolectorCedula.value;
  String get selectedPesada => _selectedPesada.value;
}
