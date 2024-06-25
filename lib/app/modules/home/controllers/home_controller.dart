import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/appwrite_service.dart';
import '../../models/userModels.dart';

class HomeController extends GetxController {
  final AppwriteService appwriteService = Get.find<AppwriteService>();
  var users = <UserModel>[].obs;
  var isLoading = false.obs; // State untuk loading

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    isLoading.value = true; // Mulai loading
    List<UserModel> fetchedUsers = await appwriteService.getAllUsers();
    users.assignAll(fetchedUsers);
    isLoading.value = false; // Selesai loading
  }

  void logout() async {
    UserModel? currentUser = await getUserFromPreferences();
    if (currentUser != null) {
      currentUser.isOnline = false;
      await appwriteService.updateUser(currentUser);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Get.offAllNamed('/login');
    }
  }

  Future<void> updateUserProfile(UserModel user) async {
    await appwriteService.updateUser(user);
    await saveUserToPreferences(user);
  }

  Future<void> deleteUserAccount(String documentId) async {
    await appwriteService.deleteUser(documentId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed('/login');
  }

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

  Future<void> saveUserToPreferences(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('documentId', user.documentId);
    await prefs.setString('name', user.name);
    await prefs.setString('username', user.username);
    await prefs.setString('password', user.password);
    await prefs.setString('phone', user.phone);
    await prefs.setBool('isOnline', user.isOnline);
  }
}
