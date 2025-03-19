import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../users/user_details_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  const HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  void _onButtonPressed() {
    String userName = _controller.text;
    Get.to(UserDetailsView(), arguments: {"userName": userName});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Find GitHub Users")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                
                labelText: "Enter user name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: _onButtonPressed,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Search",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}