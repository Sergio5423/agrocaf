import 'package:cloud_firestore/cloud_firestore.dart';

class Recolector {
  String cedula;
  String nombre;
  String telefono;
  String metodopago;
  String ncuenta;

  // Constructor
  Recolector({
    required this.cedula,
    required this.nombre,
    required this.telefono,
    required this.metodopago,
    required this.ncuenta,
  });

  // Método para convertir un documento de Firestore en una instancia de Item
  factory Recolector.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Recolector(
      cedula: data['cedula'] ?? '',
      nombre: data['nombre'] ?? '',
      telefono: data['telefono'] ?? '',
      metodopago: data['metodopago'] ?? '',
      ncuenta: data['ncuenta'] ?? '',
    );
  }

  // Método para convertir un objeto Item a Map (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'telefono': telefono,
      'metodopago': metodopago,
      'ncuenta': ncuenta,
    };
  }
}
