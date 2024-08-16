import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/nav_tab.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/post_video_button.dart';

import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';

import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_timeline_screen.dart';

class MainNavigation extends StatefulWidget {
  static const String routeName = "mainNavigation";
  final String tab;
  const MainNavigation({super.key, required this.tab});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxx",
    "inbox",
    "profile",
  ];
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: VideoTimelineScreen(isSelected: _selectedIndex == 0),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "Seanwho",
              tab: "likes",
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(Sizes.size12),
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              selectedIcon: FontAwesomeIcons.house,
              iconData: FontAwesomeIcons.house,
              text: "Home",
              isSelected: _selectedIndex == 0,
              onTap: () => _onTap(0),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              selectedIcon: FontAwesomeIcons.solidCompass,
              iconData: FontAwesomeIcons.compass,
              text: "Discover",
              isSelected: _selectedIndex == 1,
              onTap: () => _onTap(1),
              selectedIndex: _selectedIndex,
            ),
            Gaps.h24,
            GestureDetector(
              onTap: _onPostVideoButtonTap,
              child: PostVideoButton(inverted: _selectedIndex != 0),
            ),
            Gaps.h24,
            NavTab(
              selectedIcon: FontAwesomeIcons.solidMessage,
              iconData: FontAwesomeIcons.message,
              text: "Inbox",
              isSelected: _selectedIndex == 3,
              onTap: () => _onTap(3),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              selectedIcon: FontAwesomeIcons.solidUser,
              iconData: FontAwesomeIcons.user,
              text: "Profile",
              isSelected: _selectedIndex == 4,
              onTap: () => _onTap(4),
              selectedIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
