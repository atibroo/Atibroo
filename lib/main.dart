import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AtibrooApp());
}

class AtibrooApp extends StatelessWidget {
  const AtibrooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atibroo',
      home: VideoHome(),
    );
  }
}

class VideoHome extends StatefulWidget {
  const VideoHome({super.key});

  @override
  State<VideoHome> createState() => _VideoHomeState();
}

class _VideoHomeState extends State<VideoHome> {
  bool arabic = true;
  int currentIndex = 0;

  final List<String> videos = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return VideoItem(
                key: ValueKey(index),
                url: videos[index],
                active: index == currentIndex,
                arabic: arabic,
              );
            },
          ),

          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Atibroo',
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    arabic
                        ? 'المتابَعون  |  لك'
                        : 'Following  |  For You',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 45,
            right: 10,
            child: IconButton(
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  arabic = !arabic;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoItem extends StatefulWidget {
  final String url;
  final bool active;
  final bool arabic;

  const VideoItem({
    super.key,
    required this.url,
    required this.active,
    required this.arabic,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController controller;
  bool liked = false;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );

    controller.initialize().then((_) {
      if (!mounted) return;

      controller.setLooping(true);

      if (widget.active) {
        controller.play();
      }

      setState(() {});
    });
  }

  @override
  void didUpdateWidget(VideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.active && controller.value.isInitialized) {
      controller.play();
    } else {
      controller.pause();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (controller.value.isInitialized)
          GestureDetector(
            onTap: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
              setState(() {});
            },
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            ),
          )
        else
          const Center(
            child: CircularProgressIndicator(
              color: Colors.cyanAccent,
            ),
          ),

        Positioned(
          right: 15,
          bottom: 120,
          child: Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: 35,
                  color: liked ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    liked = !liked;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.comment,
                color: Colors.white,
                size: 35,
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.share,
                color: Colors.white,
                size: 35,
              ),
            ],
          ),
        ),

        Positioned(
          left: 15,
          bottom: 80,
          child: Text(
            widget.arabic
                ? '@Atibroo\nمرحباً بك في Atibroo 🎬'
                : '@Atibroo\nWelcome to Atibroo 🎬',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
