import 'package:cloud_firestore/cloud_firestore.dart';

class Pezada {
  final String id;
  final double peso;
  final String calidad;
  final DateTime fecha;
  final String recolectorCedula; // Asociación con el recolector

  Pezada({
    required this.id,
    required this.peso,
    required this.calidad,
    required this.fecha,
    required this.recolectorCedula,
  });

  // Convertir los datos de Firestore a una instancia de Pezada
  factory Pezada.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Pezada(
      id: doc.id,
      peso: data['peso'],
      calidad: data['calidad'],
      fecha: (data['fecha'] as Timestamp).toDate(),
      recolectorCedula: data['recolectorCedula'],
    );
  }

  // Convertir una instancia de Pezada a un formato que se pueda guardar en Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'peso': peso,
      'calidad': calidad,
      'fecha': fecha,
      'recolectorCedula': recolectorCedula,
    };
  }
}
