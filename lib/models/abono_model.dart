import 'package:cloud_firestore/cloud_firestore.dart';

class Abono {
  String? id;
  String abono;
  String cedularecolector;

  Abono({
    this.id,
    this.abono = '',
    this.cedularecolector = '',
  });

  // Constructor para convertir desde Firestore
  factory Abono.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Abono(
      id: doc.id, // Toma el ID del documento
      abono: data['abono'] ?? '', // Validación para evitar valores nulos
      cedularecolector: data['cedularecolector'] ?? '',
    );
  }

  // Método para convertir a Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'abono': abono,
      'cedularecolector': cedularecolector,
    };
  }

  @override
  String toString() {
    return 'Abono(Cedula $cedularecolector, Monto $abono)';
  }
}
