import 'dart:io'; // Para manejar archivos
import 'package:agrocaf/models/recolector_model.dart';
import 'package:agrocaf/services/recolector_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart'; // Para obtener el directorio del archivo
import 'package:excel/excel.dart'; // Para crear archivos Excel
import 'package:external_path/external_path.dart';

class RecolectorController extends GetxController {
  final RecolectorService _recolectorService = RecolectorService();

  var isLoading = false.obs; // Definir isLoading como observable
  RxList<Recolector> recolectores = <Recolector>[]
      .obs; // Lista observable de ítems para actualizar la UI automáticamente
  var filteredRecolectores =
      <Recolector>[].obs; // Lista observable de ítems filtrados
  var searchQuery = ''.obs; // Variable observable para el texto de búsqueda
  var selectedCedula = ''.obs;

  void selectRecolector(String cedula) {
    selectedCedula.value = cedula;
  }

  // Método para guardar un nuevo ítem
  Future<void> saveNewRecolector(Recolector recolector) async {
    try {
      isLoading.value = true;

      // Guardar el ítem usando el servicio
      await _recolectorService.saveRecolector(recolector);
      Get.snackbar('Éxito', 'Ítem guardado correctamente');
      fetchRecolectores(); // Volver a cargar los ítems después de guardar
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al guardar el ítem');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para actualizar un ítem existente
  Future<void> updateItem(Recolector recolector, String ced) async {
    try {
      isLoading.value = true;

      // Actualizar los datos del ítem en Firestore
      await _recolectorService.updateRecolector(recolector, ced);
      Get.snackbar('Éxito', 'Recolector actualizado correctamente');
      fetchRecolectores(); // Volver a cargar los ítems después de actualizar
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al actualizar el ítem');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para eliminar un ítem
  Future<void> deleteRecolector(String recolectorCedula) async {
    try {
      isLoading.value = true;
      await _recolectorService.deleteRecolector(recolectorCedula);
      Get.snackbar('Éxito', 'Ítem eliminado correctamente');
      fetchRecolectores(); // Volver a cargar los ítems después de eliminar
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al eliminar el ítem');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para cargar todos los ítems
  void fetchRecolectores() async {
    while (isLoading.value) {
      isLoading.value = true;
    }

    _recolectorService.getRecolectores().listen((fetchedRecolectores) {
      recolectores.value = fetchedRecolectores;

      // Usar addPostFrameCallback para evitar el error
      WidgetsBinding.instance.addPostFrameCallback((_) {
        applyFilter(); // Aplicar filtro después de la construcción
      });

      print('Fetched recolectores: ${recolectores.length}'); // Comprobar datos
      isLoading.value = false;
    });
  }

  var selectedPaymentMethod = ''.obs;

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
    applyFilter(); // Aplicar el filtro cada vez que se actualice el texto de búsqueda
  }

  // Método para obtener un ítem por su ID
  Future<Recolector?> getRecolectorByCed(String recolectorCedula) async {
    try {
      return await _recolectorService.getRecolector(recolectorCedula);
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al obtener el ítem');
      return null;
    }
  }

  //Metodo para actualizar datos del recolector por su cedula
  Future<void> updateRecolectorField(
      String recolectorCedula, String field, dynamic newValue) async {
    try {
      // Referencia al recolector basado en la cédula
      var recolectorDoc = FirebaseFirestore.instance
          .collection('recolectores')
          .doc(recolectorCedula);

      // Actualizar el campo específico
      await recolectorDoc.update({field: newValue});
    } catch (e) {
      throw Exception('Error al actualizar el recolector: $e');
    }
  }

  // Método para generar el archivo Excel
  Future<void> generateExcel() async {
    var excel = Excel.createExcel(); // Crear un nuevo libro de Excel
    Sheet sheet = excel['Sheet1']; // Agregar encabezados
    sheet.appendRow([
      'Cédula',
      'Nombre del Recolector',
      'Teléfono',
      'Método de Pago',
      'Número de Cuenta'
    ]); // Agregar datos de recolectores
    for (var recolector in recolectores) {
      sheet.appendRow([
        recolector.cedula,
        recolector.nombre,
        recolector.telefono,
        recolector.metodopago,
        recolector.ncuenta
      ]);
    } // Guardar el archivo en el directorio de descargas
    final directory = Directory(
        '/storage/emulated/0/Download'); // Ruta del directorio de descargas en Android
    final String filePath = '${directory.path}/recolectores.xlsx';
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);
    Get.snackbar('Éxito', 'Archivo Excel generado en: $filePath');
    // Mostrar un mensaje de éxito }
  }
}
