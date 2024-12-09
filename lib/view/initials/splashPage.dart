import 'dart:async';
import 'package:course_selling/_helpers/global.dart';
import 'package:course_selling/_services/storage.dart';
import 'package:course_selling/view/component/StudentNavbar.dart';
import 'package:course_selling/view/component/TeacherNavbar.dart';
import 'package:course_selling/view/initials/Login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => navigateToScreen());
  }

  Future<void> navigateToScreen() async {
    String? token = await SecureStorage().GetSecureData('token');
    var user = await SecureStorage().getLogin();

    token = token!;

    print('my token is ${token}');

    if (token.isEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      userSD = user;
      print('my user data is ${userSD}');

      if (user["role"] == "Teacher") {
        Get.off(() => Teachernavbar());
      } else if (user['role'] == 'Student') {
        Get.off(() => Studentnavbar());
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: const CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
