import 'package:carousel_slider/carousel_slider.dart';
import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:course_selling/theme.dart';
import 'package:course_selling/view/Student/Home/HomeControler.dart';
import 'package:course_selling/view/Teacher/video/VideoControler.dart';
import 'package:course_selling/view/Teacher/video/VideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final List<String> imgList = [
    'assets/images/image1.jpg',
    // 'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    var homecontroler = Get.put(StuHomecontroler());
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
                  'Recomemded Courses',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            videoController.chekpaid();

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
                                  Spacer(),
                                  Column(children: [
                                    Text(
                                      'price',
                                      style: TextStyle(color: redColor),
                                    ),
                                    Text(
                                      data['price'].toString(),
                                      style: TextStyle(),
                                    )
                                  ]),
                                  SizedBox(width: 10)
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
    );
  }
}
