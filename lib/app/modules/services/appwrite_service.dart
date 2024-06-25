import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../models/userModels.dart'; // Asumsikan bahwa file model berada di folder models
import '../../../appwrite_client.dart'; // Pastikan jalur ini benar sesuai struktur proyekmu

class AppwriteService {
  final Client client;
  final String databaseId =
      '6667d6250029ff865981'; // ID database yang kamu berikan
  final String collectionId =
      '6667d62f000dee14896a'; // ID koleksi yang kamu berikan

  // Konstruktor untuk inisialisasi AppwriteService
  AppwriteService(this.client);

  // Fungsi untuk register user
  Future<UserModel?> register(UserModel user) async {
    try {
      Databases database = Databases(client);

      // Buat data tanpa `documentId` atau `$id`
      Map<String, dynamic> data = {
        'name': user.name,
        'username': user.username,
        'password': user.password,
        'phone': user.phone,
        'is_online': user.isOnline,
      };

      models.Document result = await database.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: 'unique()', // Gunakan 'unique()' untuk ID otomatis
        data: data,
      );

      // Setelah dokumen dibuat, update model dengan `documentId` yang benar
      return UserModel.fromMap({
        ...result.data,
        'documentId': result.$id, // Set documentId dari hasil dokumen
      });
    } catch (e) {
      print('Error registering user: $e');
      return null;
    }
  }

  // Fungsi untuk login user
  Future<UserModel?> login(String username, String password) async {
    try {
      Databases database = Databases(client);
      models.DocumentList result = await database.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [
          Query.equal('username', username),
          Query.equal('password', password),
        ],
      );

      if (result.documents.isNotEmpty) {
        var userMap = result.documents.first.data;
        UserModel user = UserModel.fromMap(userMap);

        // Update status online
        user.isOnline = true;
        await updateUser(user);
        return user;
      } else {
        print('Login failed: User not found or incorrect credentials');
        return null;
      }
    } catch (e) {
      print('Error logging in user: $e');
      return null;
    }
  }

  // Fungsi untuk logout user
  Future<bool> logout(String documentId) async {
    try {
      UserModel? user = await getUser(documentId);
      if (user != null) {
        user.isOnline = false;
        await updateUser(user);
        return true;
      } else {
        print('Logout failed: User not found');
        return false;
      }
    } catch (e) {
      print('Error logging out user: $e');
      return false;
    }
  }

  // Fungsi untuk menghapus akun user
  Future<bool> deleteUser(String documentId) async {
    try {
      Databases database = Databases(client);
      await database.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  // Fungsi untuk mendapatkan user berdasarkan documentId
  Future<UserModel?> getUser(String documentId) async {
    try {
      Databases database = Databases(client);
      models.Document result = await database.getDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
      return UserModel.fromMap(result.data);
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  // Fungsi untuk mendapatkan semua user
  Future<List<UserModel>> getAllUsers() async {
    try {
      Databases database = Databases(client);
      models.DocumentList result = await database.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
      );

      List<UserModel> users = result.documents.map((doc) {
        return UserModel.fromMap(doc.data);
      }).toList();

      return users;
    } catch (e) {
      print('Error fetching all users: $e');
      return [];
    }
  }

  // Fungsi untuk mengupdate data user
  Future<UserModel?> updateUser(UserModel user) async {
    try {
      Databases database = Databases(client);

      // Buat data tanpa `documentId` atau `$id`
      Map<String, dynamic> data = {
        'name': user.name,
        'username': user.username,
        'password': user.password,
        'phone': user.phone,
        'is_online': user.isOnline,
      };

      models.Document result = await database.updateDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: user.documentId,
        data: data,
      );

      return UserModel.fromMap(result.data);
    } catch (e) {
      print('Error updating user: $e');
      return null;
    }
  }
}
