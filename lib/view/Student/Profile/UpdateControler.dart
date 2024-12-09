import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:course_selling/_services/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class Updatecontroler extends GetxController {
  final name = TextEditingController();
  var image = ''.obs;
  var dio1 = dio.Dio();
  var data = {}.obs;
  @override
  void onInit() {
    UpdateProfile();

    super.onInit();
  }

  Future<void> UpdateProfile() async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'username': name.text,
      });

      // Conditionally add the image file if it exists
      if (image.value.isNotEmpty) {
        formData.files.add(
          MapEntry(
            'image',
            await dio.MultipartFile.fromFile(
              image.value,
              filename: image.value.split('/').last,
            ),
          ),
        );
      }

      final response = await dio1.post(
          '${Config.baseUrl}updateProfile/${userSD['id']}',
          data: formData);
      if (response.statusCode == 200) {
        data.value = response.data['user'];
        //  set data
        var userdata = response.data['user'];
        await SecureStorage().setLogin(userdata);
        // get data
        var user = await SecureStorage().getLogin();
        // store token
        userSD = user;

        // store token

        print(userSD);
      } else {
        print('No data');
      }
    } catch (e) {
      print('General error: $e');
    }
  }
}
