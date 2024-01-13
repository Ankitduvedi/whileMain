import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/view/create_screen.dart';
import 'package:while_app/view/feed_screen.dart';
import 'package:while_app/view/profile/user_profile_screen.dart';
import 'package:while_app/view/reels_screen.dart';
import 'package:while_app/view/social/social_home_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // listUsersFollowers();
    APIs.getSelfInfo();
    super.initState();
  }

  final List<Widget> _screens = [
    const FeedScreen(),
    const CreateScreen(),
    const ReelsScreen(),
    const SocialScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    //final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      body: _screens[_currentIndex], // replace with _currentIndex
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        height: 50,
        // shape: const CircularNotchedRectangle(),
        //color: currentTheme.primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {
                _onTabTapped(0);
              },
              icon: const Icon(
                Icons.home_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                _onTabTapped(1);
              },
              icon: const Icon(
                Icons.videocam_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            IconButton(
                iconSize: 65,
                onPressed: () {
                  _onTabTapped(2);
                },
                icon: const Icon(
                  Icons.slow_motion_video_outlined,
                  size: 30,
                  color: Colors.white,
                )),
            IconButton(
              onPressed: () {
                _onTabTapped(3);
              },
              icon: const Icon(
                Icons.message_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                _onTabTapped(4);
              },
              icon: const Icon(
                Icons.account_circle_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
