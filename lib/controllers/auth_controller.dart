import 'package:agrocaf/models/user_model.dart';
import 'package:agrocaf/pages/Apartados_Operador/Home_Operador.dart';
import 'package:agrocaf/pages/Apartados_admin/Home_Administrador.dart';
import 'package:agrocaf/pages/Login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart'; // Importar GetStorage
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final Usuario usuario = Usuario();
  var isLoading = false.obs; // Observa si se está cargando una operación
  Rxn<User> user = Rxn<User>();
  var cargo0;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  // Método para registrar el administrador y guardar datos en Firestore
  Future<void> register(
      String email, String password, String name, String cargo) async {
    try {
      isLoading.value = true;
      User? newUser = await _firebaseService.registerWithEmail(
          email, password, name, cargo, 'usuarios');
      if (newUser != null) {
        if (cargo == 'admin') {
          user.value = newUser; // Administrador registrado exitosamente
          await _saveCredentials(email, password); // Guardar credenciales
          Get.offAll(() => HomeAdmin()); // Redirigir a la vista principal
        } else {
          user.value = newUser; // Administrador registrado exitosamente
          await _saveCredentials(email, password); // Guardar credenciales
          Get.offAll(() => HomeOperador()); // Redirigir a la vista principal
        }
      } else {
        Get.snackbar("Error", "No se pudo registrar el usuario");
      }
    } catch (e) {
      Get.snackbar("Error", "Ocurrió un error durante el registro");
    } finally {
      isLoading.value = false;
    }
  }

  // Método para iniciar sesión
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      User? loggedInUser =
          await _firebaseService.loginWithEmail(email, password);
      if (loggedInUser != null) {
        var uid0 = loggedInUser.uid;
        var email0 = loggedInUser.email;

        // Esperar el primer valor del stream
        cargo0 = await getCargo(loggedInUser.uid).first;

        var userData = {
          'uid0': uid0,
          'email0': email0,
          'cargo0': cargo0,
        };
        print('userData: ${userData['cargo0']}');

        if (userData['cargo0'] == 'admin') {
          user.value = loggedInUser; // Administrador inició sesión exitosamente
          await _saveCredentials(email, password); // Guardar credenciales
          Get.offAll(() => HomeAdmin()); // Redirigir a la vista principal
        } else {
          user.value =
              loggedInUser; // Otro tipo de usuario inició sesión exitosamente
          await _saveCredentials(email, password); // Guardar credenciales
          Get.offAll(() => HomeOperador()); // Redirigir a la vista principal
        }
      } else {
        Get.snackbar("Error", "No se pudo iniciar sesión");
      }
    } catch (e) {
      Get.snackbar("Error", "Ocurrió un error durante el inicio de sesión");
    } finally {
      isLoading.value = false;
    }
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _firebaseService.signOut();
    await _clearCredentials(); // Eliminar credenciales guardadas
    user.value = null; // Administrador ha cerrado sesión
    Get.snackbar("Sesión cerrada", "Hasta pronto");
    Get.offAll(() => Login()); // Redirigir a la vista de login
  }

  // Guardar las credenciales de administrador usando GetStorage
  Future<void> _saveCredentials(String email, String password) async {
    storage.write('email', email);
    storage.write('password', password);
  }

  // Intentar login automático
  Future<void> _autoLogin() async {
    String? email = storage.read('email');
    String? password = storage.read('password');

    if (email != null && password != null) {
      await login(email, password); // Auto login con credenciales guardadas
    }
  }

  // Eliminar las credenciales guardadas
  Future<void> _clearCredentials() async {
    storage.remove('email');
    storage.remove('password');
  }

  User? get userlogueado => user.value;

  Stream<String> getCargo(String uid) {
    return FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        final usuario = Usuario.fromFirestore(snapshot);
        return usuario.cargo;
      }
      return '';
    });
  }
}
