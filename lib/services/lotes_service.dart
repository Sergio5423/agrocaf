import 'package:agrocaf/models/lotes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Lote>> getLotes() {
    return _firestore.collection('lotes').snapshots().map((snapshot) {
      print('Documentos recibidos: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        print('Lote: ${doc.data()}');
        return Lote.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> saveLote(Lote lote) async {
    try {
      print('Guardando Lote: ${lote.toFirestore()}');
      DocumentReference docRef =
          await _firestore.collection('lotes').add(lote.toFirestore());
      lote.id = docRef.id;
      print('Lote guardado con ID: ${lote.id}');
    } catch (e) {
      print('Error al guardar el lote en Firestore: $e');
    }
  }

  Future<void> updateLote(Lote lote, String loteId) async {
    try {
      if (lote.id != null) {
        await _firestore
            .collection('lotes')
            .doc(lote.id)
            .update(lote.toFirestore());
      } else {
        print('El lote no tiene un ID válido para actualizar.');
      }
    } catch (e) {
      print('Error al actualizar el lote en Firestore: $e');
    }
  }

  Future<void> deleteLote(String loteId) async {
    try {
      await _firestore.collection('lotes').doc(loteId).delete();
    } catch (e) {
      print('Error al eliminar el lote en Firestore: $e');
    }
  }
}
