import 'package:course_selling/theme.dart';
import 'package:course_selling/view/component/StudentNavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllStudentPage extends StatelessWidget {
  const AllStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Student'),
        backgroundColor: redColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: p),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                onTap: () {
                  Get.to(Studentnavbar());
                },
                contentPadding: const EdgeInsets.all(16.0),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/t.jpg'),
                  radius: 30.0,
                ),
                title: Text(
                  'Zeeshan',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (String result) {
                    if (result == 'Block') {
                    } else if (result == 'Unblock') {}
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Block',
                      child: Text('Block'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Unblock',
                      child: Text('Unblock'),
                    ),
                  ],
                  icon: Icon(Icons.more_vert, color: Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
