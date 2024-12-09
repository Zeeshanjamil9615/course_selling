// import 'package:course_selling/Config.dart';
// import 'package:course_selling/theme.dart';
// import 'package:course_selling/view/Student/DispalyVideo/DisplayControler.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:video_player/video_player.dart';

// class Displayvideo extends StatefulWidget {
//   @override
//   State<Displayvideo> createState() => _DisplayvideoState();
// }

// class _DisplayvideoState extends State<Displayvideo> {
//   VideoPlayerController? videoPlayerController;
//   CustomVideoPlayerController? _customVideoPlayerController;
//   String currentVideoUrl = "";

//   @override
//   void initState() {
//     super.initState();
//   }

//   void initializePlayer(String url) {
//     videoPlayerController = VideoPlayerController.network(url)
//       ..initialize().then((_) {
//         setState(() {}); // Update UI when video is initialized
//       });
//     _customVideoPlayerController = CustomVideoPlayerController(
//       context: context,
//       videoPlayerController: videoPlayerController!,
//     );
//   }

//   @override
//   void dispose() {
//     _customVideoPlayerController?.dispose();
//     videoPlayerController?.dispose();
//     super.dispose();
//   }

//   void playSelectedVideo(String url) {
//     if (currentVideoUrl != url) {
//       setState(() {
//         currentVideoUrl = url;
//         videoPlayerController?.dispose(); // Dispose of the old controller
//         initializePlayer(currentVideoUrl); // Initialize the new video
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final videocontroller = Get.put(StuVideoController());

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Lectures'),
//           backgroundColor: Colors.red,
//         ),
//         body: Container(
//           child: Column(
//             children: [
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 child: videoPlayerController != null &&
//                         videoPlayerController!.value.isInitialized
//                     ? CustomVideoPlayer(
//                         customVideoPlayerController:
//                             _customVideoPlayerController!,
//                       )
//                     : Container(
//                         width: double.infinity,
//                         child: Center(
//                             child: Image.network(
//                                 width: double.infinity,
//                                 videocontroller.image.value)),
//                       ), // Show loader
//               ),
//               // Add TabBar
//               TabBar(
//                 labelColor: Colors.black,
//                 unselectedLabelColor: Colors.grey,
//                 indicatorColor: redColor,
//                 indicatorSize: TabBarIndicatorSize.label,
//                 tabs: [
//                   Tab(text: "Lectures"),
//                   Tab(text: "Description"),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     // Lecture tab with ListView
//                     Obx(() => videocontroller.videodata.isNotEmpty
//                         ? ListView.builder(
//                             itemCount: videocontroller.videodata.length,
//                             itemBuilder: (context, index) {
//                               var data = videocontroller.videodata[index];
//                               return ListTile(
//                                 leading: Container(
//                                     child: Icon(
//                                   Icons.play_circle_fill,
//                                   color: redColor,
//                                   size: 40,
//                                 )),
//                                 title: Text('${data['title']}'),
//                                 subtitle: Text(
//                                   '2:30',
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                                 onTap: () {
//                                   playSelectedVideo(
//                                       Config.imgUrl + data['path']);
//                                 },
//                               );
//                             },
//                           )
//                         : Center(child: Text('No Videos'))),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         'This course offers a comprehensive understanding of computer science.',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
