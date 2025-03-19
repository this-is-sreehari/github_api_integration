import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'user_details_model.dart';

class UserDetailsViewModel extends GetxController {
  var userData = <String, dynamic>{}.obs;
  var selectedIndex = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
    userData.assignAll(Get.arguments ?? {});
  }
  

  final dio = Dio();

  static const String baseURL = 'https://api.github.com'; 

  dynamic getUserDetails(String userName) async {
    final response = await dio.get(
      '$baseURL/users/$userName',
      options: Options(
        headers: {
          'Accept': 'application/vnd.github+json',
          'X-GitHub-Api-Version': '2022-11-28'
      })
    );
    return {'data': response.data, 'statusCode': response.statusCode};
  }

  dynamic getAllRepositories(String userName) async {
    final response = await dio.get(
      '$baseURL/users/$userName/repos',
      options: Options(
        headers: {
          'Accept': 'application/vnd.github+json',
          'X-GitHub-Api-Version': '2022-11-28'
      })
    );
    return {'data': response.data, 'statusCode': response.statusCode};
  }
}
