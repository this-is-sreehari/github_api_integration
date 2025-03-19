import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_details_viewmodal.dart';


class UserDetailsView extends StatelessWidget {
  UserDetailsView({super.key});

  final UserDetailsViewModel viewModel = Get.put(UserDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;
    if (data["userName"] != null) viewModel.getUserDetails(data["userName"]);
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
              viewModel.selectedIndex.value = index;
            },
          ),
        ),
        body: Obx(() => IndexedStack(
              index: viewModel.selectedIndex.value,
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
