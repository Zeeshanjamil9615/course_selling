import 'package:course_selling/view/Student/Chat/ChatPage.dart';
import 'package:course_selling/view/Student/Home/HomePage.dart';
import 'package:course_selling/view/Student/Profile/ProfilePage.dart';
// import 'package:course_selling/view/Student/Search/SearchPage.dart';
import 'package:flutter/material.dart';

class Studentnavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Initial selected index set to 3

  static List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    // Searchpage(),
    Chatpage(),
    Profilepage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.black,
            //  const Color.fromARGB(255, 74, 219, 149)
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildNavItem(Icons.home, 0),
              // _buildNavItem(Icons.search, 1),
              _buildNavItem(Icons.chat_bubble, 1),
              _buildNavItem(Icons.person, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        height: 50,
        width: 60,
        // decoration: BoxDecoration(
        //   shape: BoxShape.circle,
        //   color: _selectedIndex == index ? Colors.white : Colors.transparent,
        // ),
        padding: EdgeInsets.all(10.0),
        child: Icon(
          icon,
          size: 25,
          color: _selectedIndex == index ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
