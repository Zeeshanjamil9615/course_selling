import 'package:course_selling/Configs.dart';
import 'package:course_selling/_helpers/global.dart';
import 'package:course_selling/theme.dart';
import 'package:course_selling/view/Student/Chat/ChatControler.dart';
import 'package:course_selling/view/Student/Chat/ChatPage.dart';
import 'package:course_selling/view/Teacher/video/VideoControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:video_player/video_player.dart';

class Videoscreen extends StatefulWidget {
  @override
  State<Videoscreen> createState() => _VideoscreenState();
}

class _VideoscreenState extends State<Videoscreen> {
  VideoPlayerController? videoPlayerController;
  CustomVideoPlayerController? _customVideoPlayerController;
  String currentVideoUrl = "";

  @override
  void initState() {
    super.initState();
    final videocontroller = Get.put(VideoController());

    videocontroller.videodata.listen((videos) {
      if (videos.isNotEmpty && currentVideoUrl.isEmpty) {
        String initialVideoUrl = Config.imgUrl + videos[0]['path'];
        playSelectedVideo(initialVideoUrl);
      }
    });
  }

  void initializePlayer(String url) {
    videoPlayerController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {}); // Update UI when video is initialized
      });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController!,
    );
  }

  void onImageSelected(int index) async {
    final videocontroller = Get.put(VideoController());

    if (index != 0 && videocontroller.paid.value == false) {
      // Show dialog asking the user to make payment first
      bool proceedWithPayment = await _showPaymentDialog();
      if (proceedWithPayment) {
        // If the user agrees to make the payment
        await videocontroller.makePayment();
      } else {
        return;
      }
    }

    // Play the selected video
    if (videocontroller.paid.value == true) {
      String selectedVideoUrl =
          Config.imgUrl + videocontroller.videodata[index]['path'];
      playSelectedVideo(selectedVideoUrl);
    }
  }

  Future<bool> _showPaymentDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Required'),
        content: Text('You need to make a payment before viewing this video.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // Cancel
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // Proceed with payment
            },
            child: Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController?.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  void playSelectedVideo(String url) {
    if (currentVideoUrl != url) {
      setState(() {
        currentVideoUrl = url;
        videoPlayerController?.dispose(); // Dispose of the old controller
        initializePlayer(currentVideoUrl); // Initialize the new video
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final videocontroller = Get.put(VideoController());
    var chatccontroler = Get.put(Chatcontroler());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lectures'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: videoPlayerController != null &&
                      videoPlayerController!.value.isInitialized
                  ? CustomVideoPlayer(
                      customVideoPlayerController:
                          _customVideoPlayerController!,
                    )
                  : Center(child: CircularProgressIndicator()), // Show loader
            ),
            // Add TabBar
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: redColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: "Lectures"),
                Tab(text: "Description"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Lecture tab with ListView
                  Obx(() => videocontroller.videodata.isNotEmpty
                      ? ListView.builder(
                          itemCount: videocontroller.videodata.length,
                          itemBuilder: (context, index) {
                            var data = videocontroller.videodata[index];
                            return ListTile(
                              leading: Icon(
                                Icons.play_circle_fill,
                                color: redColor,
                                size: 40,
                              ),
                              title: Text('${data['title']}'),
                              subtitle: Text(
                                '2:30',
                                style: TextStyle(fontSize: 10),
                              ),
                              onTap: () {
                                if (userSD['role'] == 'Student') {
                                  onImageSelected(index);
                                } else {
                                  playSelectedVideo(
                                      Config.imgUrl + data['path']);
                                }

                                // Handle image selection
                              },
                            );
                          },
                        )
                      : Center(child: Text('No Videos'))),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'This course offers a comprehensive understanding of computer science.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            if (userSD['role'] == 'Student')
              Obx(
                () => videocontroller.paid.value == false
                    ? GestureDetector(
                        onTap: () async {
                          await videocontroller.makePayment();
                          //
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(color: redColor),
                          child: Text(
                            'Pay ${videocontroller.price}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          print('hhhlo');
                          print('Response: ${chatccontroler.userid}');
                          print(
                              'the tecid is ${chatccontroler.teacherid.value}');
                          print(
                              'the course is ${chatccontroler.courseid.value}');

                          chatccontroler.createchatroom();
                          chatccontroler.getchatroom();
                          Get.to(Chatpage());
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: redColor, // Background color
                              borderRadius: BorderRadius.circular(
                                  16.0), // Rounded corners
                            ),
                            child: Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
              ),
          ],
        ),
        floatingActionButton: userSD['role'] != "Student"
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: videocontroller.title,
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
                            Center(
                              child: Obx(() {
                                return GestureDetector(
                                  onTap: () {
                                    videocontroller.pickVideo();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: redColor)),
                                    child: videocontroller.videoFile.value ==
                                            null
                                        ? Text('Select video.')
                                        : Text(
                                            'Video selected: ${videocontroller.videoFile.value}'),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                videocontroller.uploadVideo();
                                Navigator.pop(context);
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
                                  'Add File',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                child: Icon(
                  Icons.add,
                  color: redColor,
                ),
              )
            : null, // Hide the button if the role is not "Teacher"
      ),
    );
  }
}
