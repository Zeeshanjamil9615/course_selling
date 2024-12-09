import 'package:course_selling/theme.dart';
import 'package:course_selling/view/Student/Chat/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chatperson extends StatelessWidget {
  const Chatperson({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Container(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(Chatscreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 25,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Zeeshan',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'where are u',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                )
                              ],
                            ),
                            Spacer(),
                            Text('2pm', style: TextStyle(fontSize: 10))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
