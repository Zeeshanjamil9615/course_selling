import 'dart:io';
import 'package:timeago/timeago.dart' as timeago;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:course_selling/theme.dart';
import 'package:course_selling/view/Teacher/Home/HomeControler.dart';
import 'package:course_selling/view/Teacher/video/VideoControler.dart';
import 'package:course_selling/view/Teacher/video/VideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final List<String> imgList = [
    'assets/images/image1.jpg',
    // 'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    var homecontroler = Get.put(Homecontroler());
    var videoController = Get.put(VideoController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 25,
                      backgroundImage: userSD["imageUrl"] != null
                          ? NetworkImage(
                              '${Config.imgUrl + userSD["imageUrl"]}')
                          : AssetImage('')),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${userSD['username']}'),
                      Text(
                        userSD['role'],
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    scrollDirection: Axis.horizontal,
                    enableInfiniteScroll: true,
                  ),
                  items: imgList
                      .map((item) => Container(
                            child: Center(
                              child: Image.asset(item,
                                  fit: BoxFit.cover, width: double.infinity),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Courses',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Obx(() => homecontroler.corusedata.isNotEmpty
                  ? Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(homecontroler.corusedata.length,
                          (index) {
                        var data = homecontroler.corusedata[index];
                        return InkWell(
                          onTap: () {
                            videoController.courseid.value = data['id'];
                            videoController.getvideo();
                            videoController.price.value =
                                '${data['price'].toString()}';

                            Get.to(Videoscreen());
                          },
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    child: Image.network(
                                      '${Config.imgUrl + data['imageUrl']}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data['title']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Text(
                                          '${data['subtitle']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Text(
                                          timeago.format(DateTime.parse(
                                              data['createdAt'])),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : Text('NO DATA')),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: homecontroler.title,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                        hintText: 'Title ',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: homecontroler.subtitle,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                        hintText: 'Subtitle ',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();

                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          homecontroler.image.value = image.path;
                        }
                      },
                      child: Obx(() => Container(
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: redColor)),
                          child: homecontroler.image.value.isNotEmpty
                              ? Image.file(
                                  width: 200,
                                  fit: BoxFit.cover,
                                  File(homecontroler.image.value))
                              : Center(child: Text('Slect image ')))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      maxLines: 5,
                      style: const TextStyle(color: Colors.black),
                      controller: homecontroler.description,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                        hintText: 'Description',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: homecontroler.price,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                        hintText: 'Price',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: redColor)),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        homecontroler.uploadCourse();
                        Navigator.pop(context);
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
                          'ADD ',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.pink[50],
        child: Icon(
          Icons.add,
          color: redColor,
        ),
      ),
    );
  }
}
