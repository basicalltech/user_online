// userModel.dart
import 'package:meta/meta.dart';

class UserModel {
  String documentId; // ID dokumen dari Appwrite
  String name;
  String username;
  String password;
  String phone;
  bool isOnline;

  // Konstruktor
  UserModel({
    required this.documentId,
    required this.name,
    required this.username,
    required this.password,
    required this.phone,
    required this.isOnline,
  });

  // Metode untuk mengubah UserModel ke Map
  Map<String, dynamic> toMap() {
    return {
      '\$id':
          documentId, // Appwrite menggunakan `$id` untuk menyimpan ID dokumen
      'name': name,
      'username': username,
      'password': password,
      'phone': phone,
      'is_online': isOnline,
    };
  }

  // Metode untuk membuat UserModel dari Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      documentId: map['\$id'] ?? '', // Ambil ID dokumen dari `$id`
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      isOnline: map['is_online'] ?? false,
    );
  }

  // Optional: Metode untuk debug, menampilkan UserModel sebagai String
  @override
  String toString() {
    return 'UserModel{documentId: $documentId, name: $name, username: $username, password: $password, phone: $phone, isOnline: $isOnline}';
  }
}
