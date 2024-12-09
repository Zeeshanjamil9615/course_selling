import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class StuHomecontroler extends GetxController {
  
  var dio1 = dio.Dio();

  var image = ''.obs;
  var title = TextEditingController();
  var subtitle = TextEditingController();
  var description = TextEditingController();
  var price = TextEditingController();
  var email = userSD['email'];
  var corusedata = [].obs;
  @override
  void onInit() {
    getcourse();

    super.onInit();
  }

  Future<void> uploadCourse() async {
    try {
      // Prepare form data
      final formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(image.value,
            filename: 'image.jpg'),
        'title': title.text,
        'subtitle': subtitle.text,
        'description': description.text,
        'price': price.text,
        'email': email,
      });

      // Send POST request
      final response =
          await dio1.post('${Config.baseUrl}uploadcourse', data: formData);
      print('Response: ${response.data}');
      print('Response: ');

      if (response.statusCode == 200) {
        image.value = '';
        title.clear();
        subtitle.clear();
        description.clear();
        price.clear();
        getcourse();

        Get.snackbar('Success', 'Course uploaded successfully');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  getcourse() async {
    try {
      final response = await dio1.get('${Config.baseUrl}getallcourse');
      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        corusedata.value = response.data;
      }
    } catch (e) {
      print(e);
    }
  }
}
