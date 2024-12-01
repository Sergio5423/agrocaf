import 'package:agrocaf/models/kilo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KiloService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Kilo>> getKilo() {
    return _firestore.collection('kilo').snapshots().map((snapshot) {
      //print('Documentos recibidos: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        //print('Kilo: ${doc.data()}');
        return Kilo.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> saveKilo(Kilo kilo) async {
    try {
      //print('Guardando Kilo: ${kilo.toFirestore()}');
      DocumentReference docRef =
          await _firestore.collection('kilo').add(kilo.toFirestore());
      kilo.id = docRef.id;
      //print('Kilo guardado con ID: ${kilo.id}');
    } catch (e) {
      print('Error al guardar el Kilo en Firestore: $e');
    }
  }

  Future<void> updateKilo(Kilo kilo, String id) async {
    try {
      /*if (id != null) {*/
      await _firestore.collection('kilo').doc(id).update(kilo.toFirestore());
      /*} else {
        print('El kilo no tiene un ID válido para actualizar.');
      }*/
    } catch (e) {
      print('Error al actualizar el kilo en Firestore: $e');
    }
  }

  /*Future<void> deleteLote(String loteId) async {
    try {
      await _firestore.collection('lotes').doc(loteId).delete();
    } catch (e) {
      print('Error al eliminar el lote en Firestore: $e');
    }
  }*/
}
