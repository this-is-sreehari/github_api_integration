import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController {
  var selectedIndex = 0.obs; // Observable index for tabs
}

class UserDetailsView extends StatelessWidget {
  UserDetailsView({super.key});

  final UserDetailsController controller = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(data["userName"]),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Repositories'),
            ],
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
          ),
        ),
        body: Obx(() => IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                ProfileTab(data: data),
                RepositoriesTab(),
              ],
            )),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  final Map<String, dynamic> data;
  ProfileTab({required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Information'),
    );
  }
}

class RepositoriesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Repositories Information'),
    );
  }
}
