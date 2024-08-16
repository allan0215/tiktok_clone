import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class VideoTimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [
    VideoModel.onlyTitle(title: "First video"),
  ];

  void uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 5));
    final newVideo = VideoModel.onlyTitle(title: "${DateTime.now()}");
    _list = [..._list, newVideo];

    // AsyncValue 안에는 loading, error, data 등의 값이 있음.
    // data 안에 넣어줘야 함.
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<VideoTimelineViewModel, List<VideoModel>>(() => VideoTimelineViewModel());
