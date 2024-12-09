import 'package:course_selling/pamentcontroler.dart';

import 'package:course_selling/theme.dart';
import 'package:course_selling/view/initials/splashPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

void main() async {
  await setup();

  runApp(const MyApp());
}

setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Pamentcontroler().publishkey;
}

MaterialColor colorCustom = const MaterialColor(0xFF2E395C, {
  50: Color.fromRGBO(46, 57, 92, .1),
  100: Color.fromRGBO(46, 57, 92, .2),
  200: Color.fromRGBO(46, 57, 92, .3),
  300: Color.fromRGBO(46, 57, 92, .4),
  400: Color.fromRGBO(46, 57, 92, .5),
  490: Color.fromRGBO(46, 57, 92, .6),
  600: Color.fromRGBO(46, 57, 92, .7),
  700: Color.fromRGBO(46, 57, 92, .8),
  800: Color.fromRGBO(46, 57, 92, .9),
  900: Color.fromRGBO(46, 57, 92, 1),
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AutoMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'nr',
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundDarkColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: lightColor),
          titleTextStyle: TextStyle(
            color: lightColor,
            fontFamily: 'nb',
          ),
        ),
        dividerColor: dividerColor,
        dividerTheme: DividerThemeData(color: dividerColor),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 0,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: dividerColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: dividerColor),
          ),
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(color: darkColor, fontSize: 14),
          bodyLarge: TextStyle(color: darkColor, fontSize: 14),
          bodyMedium: TextStyle(color: darkColor, fontSize: 14),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: colorCustom)
            .copyWith(secondary: primaryColor),
      ),
      home: Splashscreen(),
    );
  }
}
// _controller = VideoPlayerController.networkUrl(
//       Uri.parse('http://192.168.18.45:3001/1725520914849.mp4'),
//     );