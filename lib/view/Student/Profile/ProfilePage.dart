import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:course_selling/_services/storage.dart';
import 'package:course_selling/view/Student/EnrollCources/EnrollCources.dart';
import 'package:course_selling/view/Student/Profile/UpdateControler.dart';
import 'package:course_selling/view/Teacher/Profile/EditProfile.dart';
import 'package:course_selling/view/initials/Login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(Updatecontroler());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
              child: Column(
                children: [
                  Obx(
                    () {
                      var imageUrl = profileController.data['imageUrl'];

                      if (imageUrl != null && imageUrl.isNotEmpty) {
                        return CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 50,
                          backgroundImage:
                              NetworkImage('${Config.imgUrl + imageUrl}'),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 50,
                          child: Icon(
                            Icons.person_2_outlined,
                            color: Colors.white,
                            size: 50,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    userSD['username'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    userSD['role'],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    userSD['email'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.grey[300]),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.edit, color: Colors.grey),
              title: Text('Edit Profile'),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
              onTap: () {
                Get.to(Editprofile());
              },
            ),
            ListTile(
              leading: Icon(Icons.book_outlined, color: Colors.grey),
              title: Text('Enroll'),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
              onTap: () {
                Get.to(Enrollcources());
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Log Out'),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
              onTap: () async {
                await SecureStorage().deleteAllSecureData();
                Get.to(LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
