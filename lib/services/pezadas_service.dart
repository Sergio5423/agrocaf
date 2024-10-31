/* import 'package:agrocaf/models/pezadas_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Importar el modelo de Pezada

class PezadaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para obtener todas las pezadas desde Firestore
  Stream<List<Pezada>> getPezadas() {
    return _firestore.collection('pezadas').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Pezada.fromFirestore(doc)).toList();
    });
  }

  // Método para guardar una nueva pezada en Firestore
  Future<void> savePezada(Pezada pezada) async {
    try {
      await _firestore.collection('pezadas').doc(pezada.id).set(pezada.toFirestore());
    } catch (e) {
      print('Error al guardar la pezada en Firestore: $e');
    }
  }

  // Método para actualizar una pezada existente en Firestore
  Future<void> updatePezada(Pezada pezada) async {
    try {
      await _firestore.collection('pezadas').doc(pezada.id).update(pezada.toFirestore());
    } catch (e) {
      print('Error al actualizar la pezada en Firestore: $e');
    }
  }

  // Método para eliminar una pezada por su ID
  Future<void> deletePezada(String pezadaId) async {
    try {
      await _firestore.collection('pezadas').doc(pezadaId).delete();
    } catch (e) {
      print('Error al eliminar la pezada en Firestore: $e');
    }
  }

  // Método para obtener una pezada por su ID desde Firestore
  Future<Pezada?> getPezada(String pezadaId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('pezadas').doc(pezadaId).get();
      if (doc.exists) {
        return Pezada.fromFirestore(doc);
      } else {
        print('La pezada no existe.');
        return null;
      }
    } catch (e) {
      print('Error al obtener la pezada de Firestore: $e');
      return null;
    }
  }
}
 */