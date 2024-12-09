import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:course_selling/_services/storage.dart';
import 'package:course_selling/view/component/StudentNavbar.dart';
import 'package:course_selling/view/component/TeacherNavbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signupcontroler extends GetxController {
  var selectedValue = ''.obs;
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  var dio = Dio();

  signupdata() async {
    try {
      var response = await dio.post('${Config.baseUrl}signup', data: {
        "username": name.text,
        "email": email.text,
        "password": password.text,
        "role": selectedValue.value,
      });
      if (response.statusCode == 200) {
        print(response.data);
        //  set data
        var token1 = response.data['token'];
        await SecureStorage().SetData('token', token1);
        var userdata = response.data['user'];
        await SecureStorage().setLogin(userdata);
        // get data
        var token2 = await SecureStorage().GetSecureData('token');
        var user = await SecureStorage().getLogin();
        // store token
        userSD = user;

        token = token2!;
        if (response.data["user"]["role"] == "Teacher") {
          Get.to(() => Teachernavbar());
        } else if (response.data['user']['role'] == 'Student') {
          Get.to(() => Studentnavbar());
        } else {
          Get.snackbar(
            'Login Failed',
            'Unknown role',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
