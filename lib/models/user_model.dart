import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String uid;
  String cargo;

  Usuario({this.uid = '', this.cargo = ''});

  factory Usuario.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Usuario(
      uid: doc.id,
      cargo: data['cargo'] ?? '',
    );
  }
}
