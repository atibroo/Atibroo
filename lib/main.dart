import 'package:flutter/material.dart';

void main() {
  runApp(const AtibrooApp());
}

class AtibrooApp extends StatelessWidget {
  const AtibrooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atibroo',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isLiked = false;
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.play_circle_outline,
              color: Colors.white38,
              size: 90,
            ),
          ),

          Positioned(
            top: 55,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Atibroo',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isArabic
                        ? 'المتابَعون     |     لك'
                        : 'Following     |     For You',
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 15,
            bottom: 110,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Icon(
                  Icons.comment,
                  size: 35,
                ),
                const SizedBox(height: 20),
                const Icon(
                  Icons.share,
                  size: 35,
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 110,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '@Atibroo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isArabic
                      ? 'مرحباً بك في Atibroo 🎬'
                      : 'Welcome to Atibroo 🎬',
                ),
              ],
            ),
          ),

          Positioned(
            top: 45,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                setState(() {
                  isArabic = !isArabic;
                });
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: isArabic ? 'الرئيسية' : 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: isArabic ? 'اكتشف' : 'Discover',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_box),
            label: isArabic ? 'نشر' : 'Upload',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: isArabic ? 'الإشعارات' : 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: isArabic ? 'حسابي' : 'Profile',
          ),
        ],
      ),
    );
  }
}
