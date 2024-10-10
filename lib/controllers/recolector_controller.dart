import 'dart:io';
import 'package:agrocaf/models/recolector_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../services/recolector_service.dart';

class RecolectorController extends GetxController {
  final RecolectorService _recolectorService = RecolectorService();

  var isLoading = false.obs; // Definir isLoading como observable
  RxList<Recolector> recolectores = <Recolector>[]
      .obs; // Lista observable de ítems para actualizar la UI automáticamente
  var filteredRecolectores =
      <Recolector>[].obs; // Lista observable de ítems filtrados
  var searchQuery = ''.obs; // Variable observable para el texto de búsqueda

  // Método para guardar un nuevo ítem
  Future<void> saveNewRecolector(String cedula, String nombre, String telefono,
      String metodopago, String ncuenta) async {
    try {
      isLoading.value = true;
      //String itemId = Uuid().v4(); // Generar un ID único para el ítem

      // Crear una instancia de Item con todos los datos
      Recolector recolector = Recolector(
          cedula: cedula,
          nombre: nombre,
          telefono: telefono,
          metodopago: metodopago,
          ncuenta: ncuenta);

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
  Future<void> updateItem(Recolector recolector) async {
    try {
      isLoading.value = true;

      // Actualizar los datos del ítem en Firestore
      await _recolectorService.updateRecolector(recolector);
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
    isLoading.value = true;
    _recolectorService.getRecolectores().listen((fetchedRecolectores) {
      recolectores.value = fetchedRecolectores;
      applyFilter(); // Aplicar filtro cada vez que se actualicen los ítems
      print('Fetched recolectores: ${recolectores.length}'); // Comprobar datos
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
}
