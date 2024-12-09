import 'package:course_selling/view/initials/Login/LoginControler.dart';
import 'package:course_selling/view/initials/Signup/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:course_selling/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var loginController = Get.put(Logincontroller());

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
              'Login Now',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'please login to continue using our app',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: loginController.email,
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
              controller: loginController.password,
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
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Forgot password',
                style: TextStyle(
                    color: redColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                loginController.login();
                print('hhlo');
              },
              child: Container(
                alignment: Alignment.center,
                height: 55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: redColor,
                    )),
                child: const Text(
                  'LOG IN',
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
                  "Didn't have an any account?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(SignupPage());
                  },
                  child: Text(
                    'Sign Up',
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
