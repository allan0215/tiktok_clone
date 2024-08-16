import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tiktok_clone/features/videos/view_models/upload_video_view_model.dart';
import 'package:tiktok_clone/features/videos/view_models/video_timeline_vm.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;
  const VideoPreviewScreen({super.key, required this.video, required this.isPicked});

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  bool _isSavedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.video.path));

    await _videoPlayerController.initialize();

    await _videoPlayerController.setLooping(true);

    await _videoPlayerController.setVolume(1);
    await _videoPlayerController.play();

    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_isSavedVideo) return;
    await GallerySaver.saveVideo(widget.video.path, albumName: "TikTok Clone");
    _isSavedVideo = true;
    setState(() {});
  }

  void _onUploadPressed() {
    ref.read(uploadVideoProvider.notifier).uploadVideo(File(widget.video.path), context);
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("video preview"),
          actions: [
            if (!widget.isPicked)
              IconButton(
                onPressed: _saveToGallery,
                icon: FaIcon(_isSavedVideo ? FontAwesomeIcons.check : FontAwesomeIcons.download),
              ),
            IconButton(
              onPressed: ref.watch(uploadVideoProvider).isLoading ? null : _onUploadPressed,
              icon: ref.watch(uploadVideoProvider).isLoading
                  ? const CircularProgressIndicator()
                  : const FaIcon(
                      FontAwesomeIcons.cloudArrowUp,
                    ),
            )
          ],
        ),
        body: _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController))
            : null);
  }
}
