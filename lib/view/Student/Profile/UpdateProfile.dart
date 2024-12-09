import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:course_selling/theme.dart';
import 'package:course_selling/view/Student/Profile/UpdateControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Updateprofile extends StatelessWidget {
  final profileController = Get.put(Updatecontroler());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        backgroundColor: redColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();

                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        profileController.image.value = image.path;
                      }
                    },
                    child: Stack(
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
                        Positioned(
                            bottom: 5,
                            right: 2,
                            child: Icon(
                              Icons.image,
                              color: redColor,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Change Profile Picture',
                    style: TextStyle(
                      fontSize: 16,
                      color: redColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: profileController.name,
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: userSD['username'].toString(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: redColor),
              onPressed: () {
                // Handle save action
                // Update the profile logic here
                profileController.UpdateProfile();
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
