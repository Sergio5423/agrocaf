import 'package:cloud_firestore/cloud_firestore.dart';

class Lote {
  String? id;
  final String nombre;

  Lote({
    this.id,
    this.nombre = '',
  });

  static Lote fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Lote(
      id: doc.id,
      nombre: data['nombre'], // Consistente con toFirestore
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre, // Consistente con fromFirestore
    };
  }
}
