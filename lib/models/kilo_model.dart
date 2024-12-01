import 'package:cloud_firestore/cloud_firestore.dart';

class Kilo {
  String? id;
  final int valor;

  Kilo({
    this.id,
    required this.valor,
  });

  static Kilo fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Kilo(
      id: doc.id,
      valor: data['valor'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'valor': valor};
  }
}
