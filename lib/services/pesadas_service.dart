import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agrocaf/models/pesadas_model.dart';

class PesadaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Pesada>> getPesadas() {
    return _firestore.collection('pesadas').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Pesada.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> savePesada(Pesada pesada) async {
    try {
      print('Guardando pesada: ${pesada.toFirestore()}');
      DocumentReference docRef =
          await _firestore.collection('pesadas').add(pesada.toFirestore());
      pesada.id = docRef.id;
      print('Pesada guardada con ID: ${pesada.id}');
    } catch (e) {
      print('Error al guardar la pesada en Firestore: $e');
    }
  }

  // Método para actualizar una pesada existente en Firestore
  Future<void> updatePesada(Pesada pesada) async {
    try {
      await _firestore
          .collection('pesadas')
          .doc(pesada.id)
          .update(pesada.toFirestore());
    } catch (e) {
      print('Error al actualizar la pesada en Firestore: $e');
    }
  }

  // Método para eliminar una pesada por su ID
  Future<void> deletePesada(String pesadaId) async {
    try {
      await _firestore.collection('pesadas').doc(pesadaId).delete();
    } catch (e) {
      print('Error al eliminar la pesada en Firestore: $e');
    }
  }
}
