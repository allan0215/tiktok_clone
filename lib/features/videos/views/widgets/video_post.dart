import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/comment.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function _onVideoFinished;
  final int index;
  final VideoModel videoData;
  const VideoPost({
    super.key,
    required onVideoFinished,
    required this.index,
    required this.videoData,
  }) : _onVideoFinished = onVideoFinished;

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  // video state
  bool _isPaused = false;

  final Duration _animationDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;

  // textbox state
  final String _caption =
      "This is practice video This is practice video This is practice video This is practice video This is practice video This is practice video This is practice video";
  final TextStyle _captionStyle = const TextStyle(
    color: Colors.white,
    fontSize: Sizes.size16,
  );
  bool _seeMore = false;
  late bool _isTextOverFlowed;
  bool _isMuted = false;

  void _onTogglePause() {
    if (!mounted) {
      return;
    }
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget._onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/video/taigo_vid.mp4");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
      _isMuted = true;
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  void _onMuteTap() async {
    if (_isMuted) {
      await _videoPlayerController.setVolume(1);
    } else {
      await _videoPlayerController.setVolume(0);
    }
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const VideoComment();
      },
    );
    _onTogglePause();
  }

// text box method

  void _onSeeMoreTap() {
    _seeMore = !_seeMore;
    setState(() {});
  }

  bool hasTextOverflow(String text, TextStyle style,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    _isTextOverFlowed =
        hasTextOverflow(_caption, _captionStyle, maxLines: 1, maxWidth: 200);
    if (ref.read(playbackConfigProvider).muted)
      _videoPlayerController.setVolume(0);

    _onPlaybackConfigChanged();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction >= 0.5 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoPlay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction < 0.5) {
      _onTogglePause();
    }
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    if (ref.read(playbackConfigProvider).muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    widget._onVideoFinished;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // normal way to do
    // final videoConfig = context.dependOnInheritedWidgetOfExactType<VideoConfig>();

    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
              child: GestureDetector(
            onTap: _onTogglePause,
          )),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.videoData.creator}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Sizes.size20,
                  ),
                ),
                Gaps.v10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        widget.videoData.description,
                        style: _captionStyle,
                        maxLines: _seeMore ? null : 1,
                        overflow: _seeMore ? null : TextOverflow.ellipsis,
                      ),
                    ),
                    Gaps.h10,
                    Offstage(
                      offstage: !_isTextOverFlowed,
                      child: GestureDetector(
                        onTap: _onSeeMoreTap,
                        child: Text(
                          !(!_seeMore && _isTextOverFlowed)
                              ? "간략히 보기"
                              : "자세히 보기",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              icon: FaIcon(
                ref.watch(playbackConfigProvider).muted
                    ? FontAwesomeIcons.volumeXmark
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: ref.read(playbackConfigProvider.notifier).toggleMuted,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/tik-tok-clone-seanwho.appspot.com/o/avatars%2FM4OW0jHZd8blvrarwUVkvDkNCBS2?alt=media"),
                  child: Text(widget.videoData.creator),
                ),
                Gaps.v24,
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _onMuteTap,
                  child: FaIcon(
                    _isMuted
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh,
                    color: Colors.white,
                  ),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(widget.videoData.likes),
                ),
                Gaps.v24,
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _onCommentTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(widget.videoData.comments),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
