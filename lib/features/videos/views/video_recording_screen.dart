import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/views/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _appActivated = true;
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late CameraController _cameraController;
  late FlashMode _flashMode;
  late final AnimationController _buttonAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
  late final AnimationController _progressAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );
  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);
  double maxZoom = 1;

  late final bool _noCamera = false; //kDebugMode && Platform.isIOS;

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController =
        CameraController(cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();

    // only for ios
    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    _initMaxZoom();
    setState(() {});
  }

  // init max zoom
  Future<void> _initMaxZoom() async {
    maxZoom = await _cameraController.getMaxZoomLevel();
  }

  Future<void> _initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied = cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied = micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      await _initCamera();
      _hasPermission = true;
      setState(() {});
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await _initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    final video = await _cameraController.stopVideoRecording();

    // async 안에서 context를 사용하면 경고를 내뱉음
    // 아래 마운트 여부 확인 한 줄로 해결 가능
    if (!mounted) return; // << 이거

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPreviewScreen(
            video: video,
            isPicked: false,
          ),
        ));
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;
    if (!mounted) return;
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPreviewScreen(
            video: video,
            isPicked: true,
          ),
        ));

    _initCamera();
  }

  void _onVerticalDrag(DragUpdateDetails details) {
    double zoom = 1;
    double draggableLength = MediaQuery.of(context).size.height;
    zoom -= details.localPosition.dy * maxZoom / draggableLength;
    zoom = clampDouble(zoom, 1, maxZoom);
    _cameraController.setZoomLevel(zoom);
  }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_noCamera) return;
    if (!_cameraController.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _appActivated = true;
        await _initPermission();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        _appActivated = false;
        setState(() {});
// 위젯 트리에서 CameraPreview를 제거 후, dispose 해야한다.
// setState와의 순서 중요
        _cameraController.dispose();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      _initPermission();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !_hasPermission || !_cameraController.value.isInitialized
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Requesting permissions.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  )
                ],
              ),
            )
          : SizedBox(
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_appActivated) CameraPreview(_cameraController),
                  SafeArea(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Positioned(
                          top: 0,
                          left: 0,
                          child: CloseButton(
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Column(
                            children: [
                              IconButton(
                                color: Colors.white,
                                onPressed: _toggleSelfieMode,
                                icon: const Icon(
                                  Icons.cameraswitch,
                                ),
                              ),
                              Gaps.v10,
                              IconButton(
                                color:
                                    _flashMode == FlashMode.always ? Colors.yellow : Colors.white,
                                onPressed: () => _setFlashMode(FlashMode.always),
                                icon: const Icon(Icons.flash_on_rounded),
                              ),
                              Gaps.v10,
                              IconButton(
                                color: _flashMode == FlashMode.off ? Colors.yellow : Colors.white,
                                onPressed: () => _setFlashMode(FlashMode.off),
                                icon: const Icon(Icons.flash_off_rounded),
                              ),
                              Gaps.v10,
                              IconButton(
                                color: _flashMode == FlashMode.auto ? Colors.yellow : Colors.white,
                                onPressed: () => _setFlashMode(FlashMode.auto),
                                icon: const Icon(Icons.flash_auto_rounded),
                              ),
                              Gaps.v10,
                              if (!_isSelfieMode)
                                IconButton(
                                  color:
                                      _flashMode == FlashMode.torch ? Colors.yellow : Colors.white,
                                  onPressed: () => _setFlashMode(FlashMode.torch),
                                  icon: const Icon(Icons.flashlight_on_rounded),
                                ),
                            ],
                          ),
                        ),
                        Positioned(
                          width: MediaQuery.of(context).size.width,
                          bottom: Sizes.size52,
                          child: Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTapDown: _startRecording,
                                onTapUp: (details) => _stopRecording(),
                                onVerticalDragUpdate: (details) => _onVerticalDrag(details),
                                child: ScaleTransition(
                                  scale: _buttonAnimation,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: Sizes.size80 + Sizes.size14,
                                        height: Sizes.size80 + Sizes.size14,
                                        child: CircularProgressIndicator(
                                          color: Colors.red.shade400,
                                          strokeWidth: Sizes.size6,
                                          value: _progressAnimationController.value,
                                        ),
                                      ),
                                      Container(
                                        width: Sizes.size80,
                                        height: Sizes.size80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                      onPressed: _onPickVideoPressed,
                                      icon: const FaIcon(
                                        FontAwesomeIcons.image,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
