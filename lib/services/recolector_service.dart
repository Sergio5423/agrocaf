import 'package:agrocaf/models/pago_model.dart';
import 'package:agrocaf/models/recolector_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agrocaf/models/abono_model.dart';
import 'package:agrocaf/services/abono_service.dart';

class RecolectorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AbonoService _abonoService = AbonoService();

  // Método para obtener todos los recolectores
  Stream<List<Recolector>> getRecolectores() {
    return _firestore.collection('recolectores').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Recolector.fromFirestore(doc)).toList();
    });
  }

  // Método para guardar un recolector
  Future<void> saveRecolector(Recolector recolector) async {
    try {
      await _firestore
          .collection('recolectores')
          .doc(recolector.cedula)
          .set(recolector.toFirestore());
    } catch (e) {
      print('Error al guardar recolector en Firestore: $e');
    }
  }

  // Método para actualizar un recolector
  Future<void> updateRecolector(Recolector recolector, String ced) async {
    try {
      await _firestore
          .collection('recolectores')
          .doc(ced)
          .update(recolector.toFirestore());
    } catch (e) {
      print('Error al actualizar el recolector en Firestore: $e');
    }
  }

  // Método para eliminar un recolector
  Future<void> deleteRecolector(String recolectorId) async {
    try {
      await _firestore.collection('recolectores').doc(recolectorId).delete();
    } catch (e) {
      print('Error al eliminar recolector en Firestore: $e');
    }
  }

  // Método para obtener un recolector por su cédula
  Future<Recolector?> getRecolector(String recolectorCedula) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('recolectores')
          .doc(recolectorCedula)
          .get();
      if (doc.exists) {
        return Recolector.fromFirestore(doc);
      } else {
        print('El recolector no existe.');
        return null;
      }
    } catch (e) {
      print('Error al obtener recolector de Firestore: $e');
      return null;
    }
  }

  // Método para agregar un abono a un recolector
  Future<void> agregarAbono(String cedulaRecolector, String monto) async {
    try {
      // Obtén el recolector usando su cédula
      Recolector? recolector = await getRecolector(cedulaRecolector);
      if (recolector != null) {
        Abono nuevoAbono = Abono(
          id: '',
          abono: monto,
          cedularecolector: recolector.cedula,
        );
        await _abonoService.agregarAbono(nuevoAbono);
        // Actualizar totalAbonos en el recolector

        await updateRecolector(recolector, recolector.cedula);
      } else {
        print('Recolector no encontrado');
      }
    } catch (e) {
      print('Error al agregar abono: $e');
    }
  }
}
