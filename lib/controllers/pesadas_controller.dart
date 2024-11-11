import 'package:get/get.dart';
import 'package:agrocaf/models/pesadas_model.dart';
import 'package:agrocaf/services/pesadas_service.dart';

class PesadaController extends GetxController {
  final PesadaService _pesadaService = PesadaService();
  var pesadas = <Pesada>[].obs;
  var filteredPesadas = <Pesada>[].obs; // Lista observable de ítems filtrados
  var isLoading = false.obs;
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

  String get selectedRecolectorNombre => _selectedRecolectorNombre.value;
  String get selectedRecolectorCedula => _selectedRecolectorCedula.value;
  String get selectedPesada => _selectedPesada.value;
}



/* import 'dart:io'; // Para manejar archivos
import 'package:agrocaf/models/pezadas_model.dart';
import 'package:agrocaf/services/pezadas_service.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart'; // Para obtener el directorio del archivo
import 'package:excel/excel.dart'; // Para crear archivos Excel


class PezadaController extends GetxController {
  final PezadaService _pezadaService = PezadaService();

  var isLoading = false.obs;
  RxList<Pezada> pezadas = <Pezada>[].obs;
  var filteredPezadas = <Pezada>[].obs;
  var searchQuery = ''.obs;

  // Método para guardar una nueva Pezada
  Future<void> saveNewPezada(String recolectorCedula, DateTime fecha, double peso) async {
    try {
      isLoading.value = true;

      Pezada pezada = Pezada(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // ID único
        recolectorCedula: recolectorCedula,
        fecha: fecha,
        peso: peso, calidad: '',
      );

      await _pezadaService.savePezada(pezada);
      Get.snackbar('Éxito', 'Pezada guardada correctamente');
      fetchPezadas();
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al guardar la Pezada');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para actualizar una Pezada
  Future<void> updatePezada(Pezada pezada) async {
    try {
      isLoading.value = true;
      await _pezadaService.updatePezada(pezada);
      Get.snackbar('Éxito', 'Pezada actualizada correctamente');
      fetchPezadas();
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al actualizar la Pezada');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para eliminar una Pezada
  Future<void> deletePezada(String pezadaId) async {
    try {
      isLoading.value = true;
      await _pezadaService.deletePezada(pezadaId);
      Get.snackbar('Éxito', 'Pezada eliminada correctamente');
      fetchPezadas();
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al eliminar la Pezada');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para cargar todas las Pezadas
  void fetchPezadas() async {
    isLoading.value = true;

    _pezadaService.getPezadas().listen((fetchedPezadas) {
      pezadas.value = fetchedPezadas;

      // Aplicar el filtro después de obtener los datos
      applyFilter();

      print('Fetched Pezadas: ${pezadas.length}');
      isLoading.value = false;
    });
  }

  // Método para aplicar el filtro basado en el texto de búsqueda
  void applyFilter() {
    if (searchQuery.value.isEmpty) {
      // Si no hay búsqueda, mostrar todos los ítems
      filteredRecolectores.value = recolectores;
    } else {
      // Filtrar los ítems según el texto de búsqueda
      filteredRecolectores.value = recolectores.where((recolector) {
        return recolector.nombre
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  // Método para actualizar el texto de búsqueda
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilter();
  }

  // Método para generar el archivo Excel
  Future<void> generateExcel() async {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Agregar encabezados
    sheet.appendRow(['ID', 'Cédula Recolector', 'Fecha', 'Peso']);

    // Agregar datos de pezadas
    for (var pezada in pezadas) {
      sheet.appendRow([pezada.id, pezada.recolectorCedula, pezada.fecha.toIso8601String(), pezada.peso]);
    }

    // Guardar el archivo
    final directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/pezadas.xlsx';
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    Get.snackbar('Éxito', 'Archivo Excel generado en: $filePath');
  }
}
 */