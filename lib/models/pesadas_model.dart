import 'package:cloud_firestore/cloud_firestore.dart';

class Pesada {
  String? id;
  final String cedRecolector;
  final String peso;
  final DateTime fecha;

  Pesada({
    this.id,
    required this.cedRecolector,
    required this.peso,
    required this.fecha,
  });

  static Pesada fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pesada(
      id: doc.id,
      cedRecolector: data['cedRecolector'],
      peso: data['peso'],
      fecha: (data['fecha'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'cedRecolector': cedRecolector,
      'peso': peso,
      'fecha': fecha,
    };
  }
}
