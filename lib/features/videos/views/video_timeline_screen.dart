import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/video_timeline_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  final bool _isSelected;

  const VideoTimelineScreen({super.key, required bool isSelected})
      : _isSelected = isSelected;

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  final int _itemCount = 4;
  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.easeOut;

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int page) {
    _pageController.animateToPage(page,
        duration: _scrollDuration, curve: _scrollCurve);
    if (page == _itemCount - 1) {
      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
    //_pageController.nextPage(duration: _scrollDuration, curve: _scrollCurve);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos. $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          data: (videos) => RefreshIndicator(
            displacement: 50,
            edgeOffset: 10,
            color: Theme.of(context).primaryColor,
            onRefresh: _onRefresh,
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                      onVideoFinished: _onVideoFinished,
                      index: index,
                      videoData: videoData);
                }),
          ),
        );
  }
}
