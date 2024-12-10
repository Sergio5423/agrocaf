import 'package:agrocaf/models/abono_model.dart';
import 'package:agrocaf/services/abono_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agrocaf/controllers/recolector_controller.dart';
import 'package:get/get.dart';

class AbonoController extends GetxController {
  final AbonoService _abonoService = AbonoService();
  final RecolectorController _recolectorController = RecolectorController();
  var abonos = <Abono>[].obs;
  var searchQuery = ''.obs;
  var filteredAbono = <Abono>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAbonos();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilter();
  }

  void applyFilter() {
    if (searchQuery.value.isEmpty) {
      filteredAbono.value = List.from(abonos);
    } else {
      filteredAbono.value = abonos.where((abono) {
        return abono.cedularecolector
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
    print('Abono filtrados: ${filteredAbono.length}');
  }

  void fetchAbonos() {
    try {
      isLoading.value = true;
      _abonoService.getAbonos().listen((lotesList) {
        print('Lotes recibidos: ${lotesList.length}');
        abonos.assignAll(lotesList);
        applyFilter();
        isLoading.value = false;
      });
    } catch (e) {
      print('Error al cargar lotes: $e');
      isLoading.value = false;
    }
  }

  Stream<List<Abono>> getAbonos() {
    return _abonoService.getAbonos();
  }

  Future<void> agregarAbono(String cedula, String monto) async {
    if (cedula.isEmpty) {
      Get.snackbar('Error', 'La cédula del recolector no puede estar vacía');
      return;
    } else {
      if (monto.isEmpty) {
        Get.snackbar('Error', 'El monto del abono no puede estar vacío');
        return;
      }
    }
    try {
      isLoading.value = true;
      Abono abono = Abono(cedularecolector: cedula, abono: monto);
      await _abonoService.agregarAbono(abono);
    } catch (e) {
      print('Error al guardar el abono: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /*Future<void> updateAbonoController(Abono abono) async {
    if (abono.id == null || abono.id!.isEmpty) {
      Get.snackbar('Error', 'No se puede actualizar un lote sin ID');
      return;
    }
    try {
      isLoading.value = true;
      await _abonoService.updateAbono(abono);
      Get.snackbar('Éxito', 'Lote actualizado correctamente');
      fetchAbonos();
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al actualizar el lote: $e');
    } finally {
      isLoading.value = false;
    }
  }*/

  Future<void> deleteAbonoController(String abonoId) async {
    try {
      isLoading.value = true;
      await _abonoService.deleteAbono(abonoId);
      Get.snackbar('Éxito', 'Abono eliminado correctamente');
      fetchAbonos();
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al eliminar el lote: $e');
    } finally {
      isLoading.value = false;
    }
  }
  /*Future<void> agregarBono(String cedula, String abono) async {
    try {
      DocumentSnapshot doc =
          await _recolectorController.obtenerDocumentSnapshot(cedula);
      if (doc.exists) {
        //var recolectorData = doc.data() as Map<String, dynamic>;
        var abonoData = doc.data()
        String currentBono = recolectorData['bono'] ?? '';
        var recolectorDoc =
            FirebaseFirestore.instance.collection('recolectores').doc(cedula);
        await recolectorDoc.update({'abono': currentBono + abono});
        Get.snackbar('Éxito', 'Bono agregado correctamente');
      } else {
        Get.snackbar('Error', 'Recolector no encontrado');
      }
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al agregar el bono');
    }
  }*/
}
