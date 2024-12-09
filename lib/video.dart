import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  List<String> videoUrls = [
    "http://192.168.18.45:3001/1725520914849.mp4",
    "http://192.168.18.45:3001/1725520899247.mp4",
    "http://192.168.18.45:3001/1725520914849.mp4",
  ];

  String currentVideoUrl = "";

  @override
  void initState() {
    super.initState();
    currentVideoUrl = videoUrls[1]; // Default to the first video
    initializePlayer(currentVideoUrl);
  }

  void initializePlayer(String url) {
    videoPlayerController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {}); // Update UI when video is initialized
      });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  void playSelectedVideo(String url) {
    if (currentVideoUrl != url) {
      setState(() {
        currentVideoUrl = url;
        videoPlayerController.dispose(); // Dispose of the old controller
        initializePlayer(currentVideoUrl); // Initialize the new video
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: videoUrls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Video ${index + 1}'),
                  onTap: () {
                    playSelectedVideo(videoUrls[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
