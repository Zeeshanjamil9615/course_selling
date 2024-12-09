// import 'dart:io';
// import 'package:course_selling/Config.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:image_picker/image_picker.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:permission_handler/permission_handler.dart';

// class StuVideoController extends GetxController {
//   var storagePermissionStatus = Rx<PermissionStatus>(PermissionStatus.denied);
//   var title = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   var videoFile = Rx<File?>(null);
//   var isLoading = false.obs;
//   var dio1 = dio.Dio();
//   var videodata = [].obs;
//   var courseid = 0.obs;
//   var image = ''.obs;
//   @override
//   void onInit() {
//     getvideo();

//     super.onInit();
//   }

//   void requestPermissions() async {
//     final status = await Permission.storage.request();
//     storagePermissionStatus.value = status;
//   }

//   Future<void> pickVideo() async {
//     final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
//     if (video != null) {
//       videoFile.value = File(video.path);
//     }
//   }

//   Future<void> uploadVideo() async {
//     String fileName = videoFile.value!.path.split('/').last;

//     final mimeType = _getMimeType(videoFile.value!.path);

//     dio.FormData formData = dio.FormData.fromMap({
//       'video': await dio.MultipartFile.fromFile(
//         videoFile.value!.path,
//         filename: fileName,
//         contentType: MediaType(mimeType['type']!, mimeType['subtype']!),
//       ),
//       'title': title.text,
//       'courseId': courseid
//     });

//     isLoading.value = true;

//     try {
//       var response = await dio1.post(
//         '${Config.baseUrl}uploadvideo',
//         data: formData,
//       );
//       if (response.statusCode == 200) {
//         print(response.data);
//         videoFile.value = null;
//         getvideo();

//         Get.snackbar('Success', 'Video uploaded successfully');
//       }
//     } catch (e) {
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Map<String, String> _getMimeType(String path) {
//     final extension = path.split('.').last.toLowerCase();
//     switch (extension) {
//       case 'mp4':
//         return {'type': 'video', 'subtype': 'mp4'};
//       case 'mkv':
//         return {'type': 'video', 'subtype': 'x-matroska'};
//       case 'avi':
//         return {'type': 'video', 'subtype': 'x-msvideo'};
//       case 'webm':
//         return {'type': 'video', 'subtype': 'webm'};
//       case 'ogv':
//         return {'type': 'video', 'subtype': 'ogg'};
//       default:
//         return {'type': 'application', 'subtype': 'octet-stream'};
//     }
//   }

//   getvideo() async {
//     try {
//       var response = await dio1.get('${Config.baseUrl}getvideo/${courseid}');

//       if (response.statusCode == 200) {
//         videodata.value = response.data[0]['videos'];
//         print(videodata);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<PermissionStatus> requestProperPermission() async {
//     PermissionStatus status;
//     if (Platform.isAndroid) {
//       var androidInfo = await DeviceInfoPlugin().androidInfo;
//       var sdkInt = androidInfo.version.sdkInt;
//       if (sdkInt >= 33) {
//         // Android 13 corresponds to API level 33
//         // Request for Android 13 specific permission
//         status = await Permission.videos.request();
//       } else {
//         // Request for traditional storage permission
//         status = await Permission.storage.request();
//       }
//     } else {
//       // For iOS or other platforms, request photos permission
//       status = await Permission.photos.request();
//     }
//     return status;
//   }
// }
