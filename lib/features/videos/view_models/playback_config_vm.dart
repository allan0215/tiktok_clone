import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    // state는 immutable하기 때문에 프로퍼티를 직접 바꿀 수 없음. 대신 새로운 스테이트를 생성해줘야 함.
    state = PlaybackConfigModel(autoPlay: state.autoPlay, muted: value);
  }

  void toggleMuted() {
    _repository.setMuted(!state.muted);
    state = PlaybackConfigModel(autoPlay: state.autoPlay, muted: !state.muted);
  }

  void setAutoPlay(bool value) {
    _repository.setAutoPlay(value);
    state = PlaybackConfigModel(autoPlay: value, muted: state.muted);
  }

  void toggleAutoPlay() {
    _repository.setAutoPlay(!state.autoPlay);
    state = PlaybackConfigModel(autoPlay: !state.autoPlay, muted: state.muted);
  }

  @override
  build() {
    return PlaybackConfigModel(autoPlay: _repository.isAutoPlay(), muted: _repository.isMuted());
  }
}

final playbackConfigProvider = NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  // shared preferences가 main 함수에서 초기화 되기 때문에, main에서 override할 예정
  () => throw UnimplementedError(),
);
