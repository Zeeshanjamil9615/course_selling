import 'package:course_selling/theme.dart';
import 'package:course_selling/view/initials/Login/LoginPage.dart';
import 'package:course_selling/view/initials/Signup/SignupControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SignupController = Get.put(Signupcontroler());

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/e.png',
              height: 150,
            ),
            SizedBox(height: 20),
            const Text(
              'Signup Now',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'please signup to continue using our app',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: SignupController.name,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: redColor,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: redColor)),
                hintText: 'Username',
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: redColor)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: SignupController.email,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: redColor,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: redColor)),
                hintText: 'Email Address ',
                hintStyle: const TextStyle(color: Colors.grey),

                // hintText: 'password',

                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: redColor)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              // obscureText: _obscureText,
              style: TextStyle(color: Colors.black),
              controller: SignupController.password,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: redColor,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: redColor)),
                hintText: 'Enter Password',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.visibility, color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: redColor)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 10, left: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: redColor),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_2_outlined,
                    color: redColor,
                  ),
                  SizedBox(width: 10),
                  // Display the selected value in the text
                  Obx(() => Text(
                        SignupController.selectedValue.value.isEmpty
                            ? 'Select role'
                            : '${SignupController.selectedValue.value}',
                        style: TextStyle(color: Colors.grey),
                      )),
                  Spacer(), // Space between text and dropdown
                  // Dropdown Button
                  DropdownButton<String>(
                    value:
                        null, // Always set to null to avoid showing the selected value
                    icon: Icon(Icons.arrow_drop_down), // Custom icon
                    underline: SizedBox(), // Removes the underline
                    items: <String>['Teacher', 'Student']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      SignupController.selectedValue.value = newValue!;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                SignupController.signupdata();
              },
              child: Container(
                alignment: Alignment.center,
                height: 55,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: redColor,
                    )),
                child: const Text(
                  'Sign UP',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an any account?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(LoginPage());
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: redColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
