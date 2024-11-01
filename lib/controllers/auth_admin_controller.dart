import 'package:agrocaf/pages/Apartados_admin/Home_Administrador.dart';
import 'package:agrocaf/pages/Login/login_admin.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart'; // Importar GetStorage
import '../services/auth_service.dart';

class AuthAdminController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  var isLoading = false.obs; // Observa si se está cargando una operación
  Rxn<User> user = Rxn<User>();

  final storage =
      GetStorage(); // Crear una instancia de GetStorage para almacenar las credenciales

  @override
  void onInit() {
    super.onInit();
    _autoLogin(); // Intentar login automático al iniciar
  }

  // Método para registrar el administrador y guardar datos en Firestore
  Future<void> register(String email, String password, String name) async {
    try {
      isLoading.value = true;
      User? newUser =
          await _firebaseService.registerWithEmail(email, password, name);
      if (newUser != null) {
        user.value = newUser; // Administrador registrado exitosamente
        await _saveCredentials(email, password); // Guardar credenciales
        Get.offAll(() => HomeAdmin()); // Redirigir a la vista principal
      } else {
        Get.snackbar("Error", "No se pudo registrar el administrador");
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
        user.value = loggedInUser; // Administrador inició sesión exitosamente
        await _saveCredentials(email, password); // Guardar credenciales
        Get.offAll(() => HomeAdmin()); // Redirigir a la vista principal
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
    Get.offAll(() => LoginAdmin()); // Redirigir a la vista de login
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
}
