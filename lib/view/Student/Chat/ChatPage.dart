import 'package:course_selling/Configs.dart';
import 'package:course_selling/theme.dart';
import 'package:course_selling/view/Student/Chat/ChatControler.dart';
import 'package:course_selling/view/Student/Chat/conservation.dart';
// import 'package:course_selling/view/Student/Chat/conservation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chatpage extends StatelessWidget {
  const Chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    var chatccontroler = Get.put(Chatcontroler());

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: p),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Chat',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Obx(
                () {
                  if (chatccontroler.chatroom.isEmpty) {
                    // If chatroom list is empty, show a message
                    return Center(
                      child: Text(
                        'No chat',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  } else {
                    // If chatroom list is not empty, show chat items
                    return Wrap(
                      children: List.generate(
                        chatccontroler.chatroom.length,
                        (index) {
                          var data = chatccontroler.chatroom[index];
                          var receiverImageUrl = data['Receiver']['imageUrl'];
                          return GestureDetector(
                            onTap: () {
                              Get.to(ChattingScreen1(
                                chatroomid: data['id'],
                                receverid: data['Receiver']['id'],
                              ));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 25,
                                          backgroundImage: receiverImageUrl !=
                                                      null &&
                                                  receiverImageUrl.isNotEmpty
                                              ? NetworkImage(
                                                  '${Config.imgUrl + receiverImageUrl}')
                                              : null,
                                          child: receiverImageUrl == null ||
                                                  receiverImageUrl.isEmpty
                                              ? Icon(
                                                  Icons.person_2_outlined,
                                                  color: Colors.white,
                                                  size: 25,
                                                )
                                              : null,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${data['Receiver']['username']}', // Correct key
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              'where are u',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Text('2pm',
                                            style: TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
