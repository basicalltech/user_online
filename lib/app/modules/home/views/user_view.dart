// user_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../models/userModels.dart';

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Obx(() {
      if (homeController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (homeController.users.isEmpty) {
        return const Center(
          child: Text('No users found'),
        );
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            homeController.fetchUsers();
          },
          child: ListView.builder(
            itemCount: homeController.users.length,
            itemBuilder: (context, index) {
              UserModel user = homeController.users[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      user.name[0],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.username),
                  trailing: _buildOnlineIndicator(user.isOnline),
                  onTap: () {
                    // Tambahkan logika jika diperlukan saat item ditekan
                  },
                ),
              );
            },
          ),
        );
      }
    });
  }

  Widget _buildOnlineIndicator(bool isOnline) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOnline ? Colors.green : Colors.red,
      ),
    );
  }
}
