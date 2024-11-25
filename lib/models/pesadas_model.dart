import 'package:cloud_firestore/cloud_firestore.dart';

class Pesada {
  String? id;
  final String cedula;
  final String nombre;
  final String peso;
  final DateTime fecha;
  //final String lote;

  Pesada({
    this.id,
    required this.cedula,
    required this.nombre,
    required this.peso,
    required this.fecha,
    //required this.lote,
  });

  static Pesada fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pesada(
      id: doc.id,
      cedula: data['cedula'],
      nombre: data['nomRecolector'],
      peso: data['peso'],
      fecha: (data['fecha'] as Timestamp).toDate(),
      //lote: data['lote'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'cedula': cedula,
      'nomRecolector': nombre,
      'peso': peso,
      'fecha': fecha,
      //'lote': lote,
    };
  }
}
