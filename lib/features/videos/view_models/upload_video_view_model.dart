import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _videosRepo;

  @override
  FutureOr build() {
    _videosRepo = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final task = await _videosRepo.uploadVideoFile(video, user!.uid);
      final userProfile = ref.read(usersProvider).value;
      if (userProfile != null) {
        if (task.metadata != null) {
          await _videosRepo.saveVideo(VideoModel(
              description: "Hell yeah",
              fileURL: await task.ref.getDownloadURL(),
              thumbnailURL: "",
              creatorUid: user.uid,
              creator: userProfile.name,
              likes: 0,
              comments: 0,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              title: "From flutter"));
          context.pushReplacement("/home");
        }
      }
    });
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
