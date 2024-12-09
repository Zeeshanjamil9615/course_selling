import 'package:course_selling/theme.dart';
import 'package:course_selling/view/Admin/AllCources/AllCources.dart';
import 'package:course_selling/view/Admin/AllStudent.dart/AllStudent.dart';
import 'package:course_selling/view/Admin/AllTeacher.dart/AllTeacher.dart';
import 'package:course_selling/view/Admin/Payment/PaymentPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(p),
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  context,
                  'All Teachers',
                  Icons.person_outline,
                  () {
                    Get.to(AllTeachersPage());
                  },
                ),
                _buildButton(
                  context,
                  'All Students',
                  Icons.people_outline,
                  () {
                    Get.to(AllStudentPage());
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  context,
                  'All Courses',
                  Icons.book_outlined,
                  () {
                    Get.to(AllcourcesPage());
                  },
                ),
                _buildButton(
                  context,
                  'Payments',
                  Icons.payment,
                  () {
                    Get.to(Paymentpage());
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, IconData icon,
      VoidCallback onPressed) {
    return Expanded(
      child: Container(
        height: 150.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 239, 72, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          ),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50.0, color: Colors.white),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
