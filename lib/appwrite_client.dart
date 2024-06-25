import 'package:appwrite/appwrite.dart';

class AppwriteClientService {
  Client client = Client();

  AppwriteClientService() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('6667d453002486a2201f')
        .setSelfSigned(status: true); // Hanya untuk pengembangan
  }
}
