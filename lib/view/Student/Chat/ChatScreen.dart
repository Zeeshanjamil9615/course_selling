import 'package:course_selling/theme.dart';
import 'package:flutter/material.dart';

class Chatscreen extends StatelessWidget {
  const  Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        leading: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,
        ),
        title: Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                )),
            SizedBox(width: 10),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Hamza', style: TextStyle(color: Colors.black)),
                  Text(
                    'online',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Icon(
            Icons.more_vert_outlined,
            color: Colors.black,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: p),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                          child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: redColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'How are u',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '4pm',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                ),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'i am fine',
                                        style: TextStyle(),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '4pm',
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ));
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: 2,
                      style: const TextStyle(color: Colors.black),
                      // controller: emailController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                        hintText: 'Enter massage',
                        hintStyle: const TextStyle(color: Colors.grey),

                        // hintText: 'password',

                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                      backgroundColor: redColor,
                      child: Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
