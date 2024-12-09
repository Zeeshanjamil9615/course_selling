import 'package:course_selling/theme.dart';
import 'package:course_selling/view/Admin/AllCources/DispalyCouces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllcourcesPage extends StatelessWidget {
  const AllcourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Cources'),
        backgroundColor: redColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: p),
        child: Container(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(Dispalycouces());
                },
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: Image.asset(
                            'assets/images/c.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Learn Computer',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                '2 days ago',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 10,
                                      child: Icon(
                                        color: Colors.white,
                                        Icons.person,
                                        size: 10,
                                      )),
                                  SizedBox(width: 10),
                                  Text('Sir Hamza')
                                ],
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
