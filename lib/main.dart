import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'appwrite_client.dart';
import './app/modules/services/appwrite_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi AppwriteClientService
  AppwriteClientService appwriteClientService = AppwriteClientService();
  Get.put(appwriteClientService);

  // Inisialisasi AppwriteService dengan Client dari AppwriteClientService
  AppwriteService appwriteService =
      AppwriteService(appwriteClientService.client);
  Get.put(appwriteService);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
