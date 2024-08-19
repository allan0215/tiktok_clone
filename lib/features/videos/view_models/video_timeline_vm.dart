import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class VideoTimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  List<VideoModel> _list = [
    VideoModel.onlyTitle(title: "First video"),
  ];

  // 분리된 ViewModel에 적어줄 내용
  // void uploadVideo() async {
  //   state = const AsyncValue.loading();
  //   await Future.delayed(const Duration(seconds: 5));
  //   final newVideo = VideoModel.onlyTitle(title: "${DateTime.now()}");
  //   _list = [..._list, newVideo];

  //   // AsyncValue 안에는 loading, error, data 등의 값이 있음.
  //   // data 안에 넣어줘야 함.
  //   state = AsyncValue.data(_list);
  // }

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videoRepo);
    final result = await _repository.fetchVideos();
    final videoList = result.docs.map(
      (doc) => VideoModel.fromJson(doc.data()),
    );
    // 추후 페이지네이션에 아이템을 "추가"하는 방식으로 작동시키기 위해
    // videoList를 바로 리턴하지 않고 _list를 재할당
    _list = videoList.toList();
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<VideoTimelineViewModel, List<VideoModel>>(
        () => VideoTimelineViewModel());
