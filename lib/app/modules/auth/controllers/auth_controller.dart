import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/appwrite_service.dart';
import '../../models/userModels.dart';

class AuthController extends GetxController {
  final AppwriteService appwriteService = Get.find<AppwriteService>();

  // State untuk menunjukkan indikator loading
  var isLoading = false.obs;

  // Fungsi untuk login
  void login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Username and Password cannot be empty',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true; // Set loading ke true

    try {
      UserModel? user = await appwriteService.login(username, password);

      if (user != null) {
        await saveUserToPreferences(user);
        Get.snackbar('Success', 'Login successful',
            snackPosition: SnackPosition.BOTTOM);
        Get.offNamed('/home');
      } else {
        Get.snackbar('Error', 'Invalid username or password',
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading.value = false; // Set loading ke false setelah selesai
    }
  }

  // Fungsi untuk registrasi
  void register(
      String name, String username, String password, String phone) async {
    if (name.isEmpty || username.isEmpty || password.isEmpty || phone.isEmpty) {
      Get.snackbar('Error', 'All fields must be filled',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true; // Set loading ke true

    try {
      UserModel newUser = UserModel(
        documentId: '', // Diabaikan saat pendaftaran, diisi oleh Appwrite
        name: name,
        username: username,
        password: password,
        phone: phone,
        isOnline: false,
      );

      UserModel? user = await appwriteService.register(newUser);

      if (user != null) {
        Get.snackbar('Success', 'Registration successful',
            snackPosition: SnackPosition.BOTTOM);
        Get.offNamed('/login');
      } else {
        Get.snackbar('Error', 'Registration failed',
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading.value = false; // Set loading ke false setelah selesai
    }
  }

  // Fungsi untuk menyimpan data user ke SharedPreferences
  Future<void> saveUserToPreferences(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('documentId', user.documentId);
    await prefs.setString('name', user.name);
    await prefs.setString('username', user.username);
    await prefs.setString('password', user.password);
    await prefs.setString('phone', user.phone);
    await prefs.setBool('isOnline', user.isOnline);
  }

  // Fungsi untuk mengambil data user dari SharedPreferences
  Future<UserModel?> getUserFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? documentId = prefs.getString('documentId');
    String? name = prefs.getString('name');
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    String? phone = prefs.getString('phone');
    bool? isOnline = prefs.getBool('isOnline');

    if (documentId != null &&
        name != null &&
        username != null &&
        password != null &&
        phone != null &&
        isOnline != null) {
      return UserModel(
        documentId: documentId,
        name: name,
        username: username,
        password: password,
        phone: phone,
        isOnline: isOnline,
      );
    }
    return null;
  }

  // Fungsi untuk logout dan menghapus data user dari SharedPreferences
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data user
    Get.offNamed('/login'); // Mengarahkan kembali ke halaman login
  }
}
