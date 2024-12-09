import 'dart:io';
import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:course_selling/view/Student/Chat/ChatControler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoController extends GetxController {
  var chatccontroler = Get.put(Chatcontroler());
  var storagePermissionStatus = Rx<PermissionStatus>(PermissionStatus.denied);
  var title = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var videoFile = Rx<File?>(null);
  var isLoading = false.obs;
  var dio1 = dio.Dio();
  var videodata = [].obs;
  var courseid = 0.obs;
  var price = ''.obs;
  var paid = false.obs;
  var teacherid = 0.obs; 
  @override
  void onInit() {
    getvideo();

    super.onInit();
  }

  void requestPermissions() async {
    final status = await Permission.storage.request();
    storagePermissionStatus.value = status;
  }

  Future<void> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      videoFile.value = File(video.path);
    }
  }

  Future<void> uploadVideo() async {
    String fileName = videoFile.value!.path.split('/').last;

    final mimeType = _getMimeType(videoFile.value!.path);

    dio.FormData formData = dio.FormData.fromMap({
      'video': await dio.MultipartFile.fromFile(
        videoFile.value!.path,
        filename: fileName,
        contentType: MediaType(mimeType['type']!, mimeType['subtype']!),
      ),
      'title': title.text,
      'courseId': courseid
    });

    isLoading.value = true;

    try {
      var response = await dio1.post(
        '${Config.baseUrl}uploadvideo',
        data: formData,
      );
      if (response.statusCode == 200) {
        print(response.data);
        videoFile.value = null;
        getvideo();

        Get.snackbar('Success', 'Video uploaded successfully');
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, String> _getMimeType(String path) {
    final extension = path.split('.').last.toLowerCase();
    switch (extension) {
      case 'mp4':
        return {'type': 'video', 'subtype': 'mp4'};
      case 'mkv':
        return {'type': 'video', 'subtype': 'x-matroska'};
      case 'avi':
        return {'type': 'video', 'subtype': 'x-msvideo'};
      case 'webm':
        return {'type': 'video', 'subtype': 'webm'};
      case 'ogv':
        return {'type': 'video', 'subtype': 'ogg'};
      default:
        return {'type': 'application', 'subtype': 'octet-stream'};
    }
  }

  getvideo() async {
    try {
      var response = await dio1.get('${Config.baseUrl}getvideo/${courseid}');

      if (response.statusCode == 200) {
        videodata.value = response.data[0]['videos'];
        chatccontroler.courseid.value = response.data[0]['id'];
        chatccontroler.teacherid.value = response.data[0]['teacherid'];
        print(videodata);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<PermissionStatus> requestProperPermission() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      if (sdkInt >= 33) {
        // Android 13 corresponds to API level 33
        // Request for Android 13 specific permission
        status = await Permission.videos.request();
      } else {
        // Request for traditional storage permission
        status = await Permission.storage.request();
      }
    } else {
      // For iOS or other platforms, request photos permission
      status = await Permission.photos.request();
    }
    return status;
  }

  // payment mothed
  var publishkey =
      'pk_test_51PxkC0P60cLEUP81tNfkaAlC4umW7mISOekfaxXv51ezWhkHrc42hDwnU2nt9Fq0tNoELAeWZdfULIariiD0fRTq00X3r2Dhym';
  var secretkey =
      'sk_test_51PxkC0P60cLEUP81QmUIlxKoVYvwObyhfPylcNxhD82G4K8B9GGPonEzSztvIFrjbbtECnNIx0PNBf4CaGx2jmyL00IkTH3J5p';
  var clientSecret = ''.obs;

  // Method to initiate payment process
  makePayment() async {
    try {
      var result = await createPaymentIntent(20, 'usd');
      if (result == null) {
        print('Payment intent creation failed');
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: result,
          merchantDisplayName: 'Zeeshan Jamil',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      payment();

      print('Payment successful!');
    } catch (e) {
      print('Payment error: $e');
    }
  }

  // Method to create a payment intent
  createPaymentIntent(int amount, String currency) async {
    try {
      var data = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      final response = await dio1.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${secretkey}",
            "Content-Type":
                'application/x-www-form-urlencoded', // Corrected typo
          },
        ),
      );

      if (response.data != null) {
        print(response.data);
        clientSecret.value = response.data['client_secret'];
        return response.data['client_secret'];
      }
    } catch (e) {
      print('Error creating payment intent: $e');
    }
    return null;
  }

  calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

  Future<void> payment() async {
    try {
      // Prepare form data

      // Send POST request
      final response = await dio1.post('${Config.baseUrl}update', data: {
        "userId": userSD['id'],
        "courseId": courseid.value,
        "paid": true
      });
      print('Response: ${response.data}');
      print('Response: ');

      if (response.statusCode == 200) {
        paid.value = true;

        Get.snackbar('Success', 'Payment successful');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  chekpaid() async {
    try {
      final response = await dio1.get(
        '${Config.baseUrl}check',
        data: {
          "userId": userSD['id'],
          "courseId": courseid.value
        }, // Use queryParameters for GET request
      );

      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['success'] == true && response.data['paid'] == true) {
          paid.value = true;
        } else {
          paid.value = false;
        }
        print('your status is ${response.data}');
      } else {
        print('Request failed with status: ${response.statusCode}');
        paid.value = false;
      }
    } catch (e) {
      print('API call failed: $e');
      paid.value = false;
    }
  }
}
