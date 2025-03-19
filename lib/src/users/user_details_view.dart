import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_details_viewmodal.dart';
import 'user_details_model.dart';


class UserDetailsView extends StatelessWidget {
  UserDetailsView({super.key});

  final UserDetailsViewModel viewModel = Get.put(UserDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;
    final String userName = data['userName'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(userName),
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
                customTab(Tabs.profile, userName),
                customTab(Tabs.repo, userName),
              ],
            )),
      ),
    );
  }

  Widget customTab(Tabs type, String userName) {
    return type == Tabs.profile
      ? FutureBuilder(
      future: viewModel.getUserDetails(userName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Sorry! Your API rate limit exceeded"));
        } else if (snapshot.data != null) {
          Map<String, dynamic> dataMap = snapshot.data as Map<String, dynamic>;
          UserDetailsModel data = UserDetailsModel.fromJson(dataMap['data']);

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20, width: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200, 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(data.avatarUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Name: ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      data.name ?? 'N/A',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Bio: ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      data.bio ?? 'N/A',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Total Repositories: ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      data.publicRepos.toString(),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    )
    : FutureBuilder(
      future: viewModel.getAllRepositories(userName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Sorry! Your API rate limit exceeded"));
        } else if (snapshot.data != null) {
          Map<String, dynamic> reposMap = snapshot.data as Map<String, dynamic>;
          List<dynamic> repos = reposMap['data'];
          
          return ListView.builder(
            itemCount: repos.length,
            itemBuilder: (context, index) {
              final repo = repos[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(repo.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(repo.url, style: const TextStyle(fontWeight: FontWeight.normal)),
                ),
              );
          });
        } else {
          return const SizedBox();
        }
        
      },
    );
  }
}

enum Tabs {
  profile('Profile'),
  repo('Repositories');

  final String text;
  const Tabs(this.text);
}