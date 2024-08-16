import 'package:flutter/widgets.dart';

/* class VideoConfigData extends InheritedWidget {
  const VideoConfigData(
      {super.key, required super.child, required this.autoMute, required this.toggleMuted});

  final bool autoMute;
  // 생성자에 void 함수를 포함할 때는 아래와 같이 쓰기
  final void Function() toggleMuted;

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // 위젯을 rebuild할지 여부를 반환함.
    // covariant가 뭐지
    return true;
  }
}

class VideoConfig extends StatefulWidget {
  final Widget child;

  const VideoConfig({super.key, required this.child});

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;
  void toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      autoMute: autoMute,
      toggleMuted: toggleMuted,
      child: widget.child,
    );
  }
} */

// 변경사항을 "듣고"있는 화면들에게 변경을 알려야 함.
/* class VideoConfig extends ChangeNotifier {
  bool autoMute = false;
  void toggleAutoMute() {
    autoMute = !autoMute;
    print(autoMute);
    notifyListeners();
  }
}

final videoConfig = VideoConfig(); */

// final videoConfig = ValueNotifier(false); // 해당 값을 직접 바꾸면 알아서 Notify 됨.

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoPlay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleIsAutoPlay() {
    isAutoPlay = !isAutoPlay;
    notifyListeners();
  }
}
