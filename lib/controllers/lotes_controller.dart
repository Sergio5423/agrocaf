import 'package:agrocaf/models/lotes_model.dart';
import 'package:agrocaf/services/lotes_service.dart';
import 'package:get/get.dart';

class LoteController extends GetxController {
  final LoteService _loteService = LoteService();
  var lotes = <Lote>[].obs;
  var searchQuery = ''.obs;
  var filteredLotes = <Lote>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLotes();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilter();
  }

  void applyFilter() {
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
  }

  void fetchLotes() {
    try {
      isLoading.value = true;
      _loteService.getLotes().listen((lotesList) {
        print('Lotes recibidos: ${lotesList.length}');
        lotes.assignAll(lotesList);
        applyFilter();
        isLoading.value = false;
      });
    } catch (e) {
      print('Error al cargar lotes: $e');
      isLoading.value = false;
    }
  }

  Stream<List<Lote>> getLotes() {
    return _loteService.getLotes();
  }

  Future<void> saveLote(Lote lote) async {
    if (lote.nombre.isEmpty) {
      Get.snackbar('Error', 'El nombre del lote no puede estar vacío');
      return;
    }
    try {
      isLoading.value = true;
      await _loteService.saveLote(lote);
    } catch (e) {
      print('Error al guardar el lote: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateItem(Lote lote) async {
    if (lote.id == null || lote.id!.isEmpty) {
      Get.snackbar('Error', 'No se puede actualizar un lote sin ID');
      return;
    }
    try {
      isLoading.value = true;
      await _loteService.updateLote(lote, lote.id!);
      Get.snackbar('Éxito', 'Lote actualizado correctamente');
      fetchLotes();
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al actualizar el lote: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteLote(String loteId) async {
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
  }
}
