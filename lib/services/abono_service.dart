import 'package:agrocaf/models/abono_model.dart';
import 'package:agrocaf/models/recolector_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AbonoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Abono>> getAbonos() {
    return _firestore.collection('abonos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Abono.fromFirestore(doc);
      }).toList();
    });
  }

  Stream<List<Recolector>> getRecolectores() {
    return _firestore.collection('recolectores').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Recolector.fromFirestore(doc)).toList();
    });
  }

  Future<void> agregarAbono(Abono abono) async {
    try {
      //print('Guardando pesada: ${pesada.toFirestore()}');
      DocumentReference docRef =
          await _firestore.collection('abonos').add(abono.toFirestore());
      abono.id = docRef.id;
      //print('Pesada guardada con ID: ${pesada.id}');
    } catch (e) {
      print('Error al guardar el abono en Firestore: $e');
    }
  }

  // Método para actualizar una pesada existente en Firestore
  /*Future<void> updateAbono(Abono abono) async {
    try {
      await _firestore
          .collection('abonos')
          .doc(abono.id)
          .update(abono.toFirestore());
    } catch (e) {
      print('Error al actualizar la pesada en Firestore: $e');
    }
  }*/

  Future<void> deleteAbono(String abonoId) async {
    try {
      await _firestore.collection('abonos').doc(abonoId).delete();
    } catch (e) {
      print('Error al eliminar la pesada en Firestore: $e');
    }
  }
}
