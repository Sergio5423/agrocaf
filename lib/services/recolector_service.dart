import 'package:agrocaf/models/recolector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecolectorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para obtener todos los ítems de Firestore
  Stream<List<Recolector>> getRecolectores() {
    return _firestore.collection('recolectores').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Recolector.fromMap(doc)).toList();
    });
  }

  // Método para guardar el ítem en Firestore
  Future<void> saveRecolector(Recolector recolector) async {
    try {
      await _firestore
          .collection('recolectores')
          .doc(recolector.cedula)
          .set(recolector.toMap());
    } catch (e) {
      print('Error al guardar recolector en Firestore: $e');
    }
  }

  // Método para actualizar un ítem existente en Firestore
  Future<void> updateRecolector(Recolector recolector) async {
    try {
      await _firestore
          .collection('recolectores')
          .doc(recolector.cedula)
          .update(recolector.toMap());
    } catch (e) {
      print('Error al actualizar el recolector en Firestore: $e');
    }
  }

  // Método para eliminar un ítem de Firestore por su ID
  Future<void> deleteRecolector(String recolectorId) async {
    try {
      await _firestore.collection('recolectores').doc(recolectorId).delete();
    } catch (e) {
      print('Error al eliminar recolector en Firestore: $e');
    }
  }

  // Método para obtener un ítem de Firestore por su ID
  Future<Recolector?> getRecolector(String recolectorCedula) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('recolectores')
          .doc(recolectorCedula)
          .get();
      if (doc.exists) {
        return Recolector.fromMap(doc);
      } else {
        print('El recolector no existe.');
        return null;
      }
    } catch (e) {
      print('Error al obtener recolector de Firestore: $e');
      return null;
    }
  }
}
