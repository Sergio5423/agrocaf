import 'package:cloud_firestore/cloud_firestore.dart';

class Pago {
  String? id;
  String cedulaRecolector;
  String nombRecolector;
  String telefono;
  String metodopago;
  String ncuenta;
  double monto;

  Pago({
    this.id,
    this.cedulaRecolector = '',
    this.nombRecolector = '',
    this.telefono = '',
    this.metodopago = '',
    this.ncuenta = '',
    this.monto = 0,
  });

  /*factory Pago.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Pago(
      id: doc.id,
      cedulaRecolector: data['cedulaRecolector'] ?? '',
      nombRecolector: data['nombRecolector'] ?? '',
      monto: (data['monto'] ?? 0.0).toDouble(),
    );
  }*/
  @override
  String toString() {
    return 'Pago(cedulaRecolector: $cedulaRecolector, nombre: $nombRecolector, telefono $telefono, metodoDePago $metodopago, ncuenta $ncuenta, monto: $monto)';
  }
  /*Map<String, dynamic> toFirestore() {
    return {
      'cedulaRecolector': cedulaRecolector,
      'monto': monto,     
    };
  }*/
}
