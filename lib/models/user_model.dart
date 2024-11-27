class Usuario {
  final String name;
  final String email;
  final String cargo;

  Usuario({required this.name, required this.email, required this.cargo});

  factory Usuario.fromMap(Map<String, dynamic> data) {
    return Usuario(
      name: data['name'],
      email: data['email'],
      cargo: data['cargo'],
    );
  }
}
