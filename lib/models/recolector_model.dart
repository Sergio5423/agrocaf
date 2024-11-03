import 'package:cloud_firestore/cloud_firestore.dart';

class Recolector {
  String cedula;
  String nombre;
  String telefono;
  String metodopago;
  String ncuenta;

  // Constructor
  Recolector({
    this.cedula = '',
    this.nombre = '',
    this.telefono = '',
    this.metodopago = '',
    this.ncuenta = '',
  });

  // Método para convertir un documento de Firestore en una instancia de Item
  factory Recolector.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Recolector(
      cedula: data['cedula'] ?? '',
      nombre: data['nombre'] ?? '',
      telefono: data['telefono'] ?? '',
      metodopago: data['metodopago'] ?? '',
      ncuenta: data['ncuenta'] ?? '',
    );
  }

  // Método para convertir un objeto Item a Map (para guardar en Firestore)
  Map<String, dynamic> toFirestore() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'telefono': telefono,
      'metodopago': metodopago,
      'ncuenta': ncuenta,
    };
  }
}
