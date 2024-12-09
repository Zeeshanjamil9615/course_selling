import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chatcontroler extends GetxController {
  var courseid = 0.obs;
  var teacherid = 0.obs;
  var userid = userSD['id'];
  var dio1 = dio.Dio();
  var chatroom = [].obs;
  IO.Socket? socket;

  @override
  void onInit() {
    getchatroom();
    super.onInit();
  }

  

  Future<void> createchatroom() async {
    try {
      final response = await dio1.post('${Config.baseUrl}createchatroom',
          data: {
            "senderId": userid,
            "receiverId": teacherid.value,
            "courseId": courseid.value
          });
      print('Response: ${userid + teacherid.value + courseid.value}');
      print('Response: ');

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Chat room Created');
      }
    } catch (e) {
      print('Response: ${userid + teacherid.value + courseid.value}');

      print('Error: $e');
    }
  }

  getchatroom() async {
    try {
      var response = await dio1.get('${Config.baseUrl}UserChatrooms/${userid}');

      if (response.statusCode == 200) {
        print(response.data);
        chatroom.value = response.data;
      }
    } catch (e) {
      print(e);
    }
  }
}
