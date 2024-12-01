import 'package:agrocaf/models/kilo_model.dart';
import 'package:agrocaf/services/kilo_service.dart';
import 'package:get/get.dart';

class KiloController extends GetxController {
  final KiloService _kiloService = KiloService();
  var kiloList = <Kilo>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKilo();
  }

  /*void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilter();
  }*/

  /*void applyFilter() {
    if (searchQuery.value.isEmpty) {
      filteredLotes.value = List.from(lotes);
    } else {
      filteredLotes.value = lotes.where((lote) {
        return lote.nombre
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
    print('Lotes filtrados: ${filteredLotes.length}');
  }*/

  void fetchKilo() {
    try {
      isLoading.value = true;
      _kiloService.getKilo().listen((kilos) {
        //print('Kilo recibidos: ${kiloList.first.id}');
        kiloList.assignAll(kilos);
        isLoading.value = false;
      });
    } catch (e) {
      print('Error al cargar kilos: $e');
      isLoading.value = false;
    }
  }

  Future<void> saveKilo(int valorKilo) async {
    /*if (kilo.valor.isEmpty) {
      Get.snackbar('Error', 'El nombre del lote no puede estar vacío');
      return;
    }*/
    try {
      fetchKilo();
      Kilo kilo = Kilo(valor: valorKilo);
      if (kiloList.isEmpty) {
        isLoading.value = true;
        await _kiloService.saveKilo(kilo);
      } else {
        updateItem(kilo, kiloList.first.id.toString());
        fetchKilo();
      }
    } catch (e) {
      print('Error al guardar el kilo: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateItem(Kilo kilo, String id) async {
    /*if (kilo.id == null || kilo.id!.isEmpty) {
      Get.snackbar('Error', 'No se puede actualizar un kilo sin ID');
      return;
    }*/
    try {
      isLoading.value = true;
      await _kiloService.updateKilo(kilo, id);
      Get.snackbar('Éxito', 'Kilo actualizado correctamente');
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al actualizar el kilo: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /*Future<void> deleteLote(String loteId) async {
    try {
      isLoading.value = true;
      await _loteService.deleteLote(loteId);
      Get.snackbar('Éxito', 'Lote eliminado correctamente');
      fetchLotes();
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al eliminar el lote: $e');
    } finally {
      isLoading.value = false;
    }
  }*/
}
