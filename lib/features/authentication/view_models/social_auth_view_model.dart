import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> githubSignIn() async {
    state = const AsyncValue.loading();

    AsyncValue.guard(
      () async => _authRepo.githubSignIn(),
    );
  }
}

final socialAuthProvider =
    AsyncNotifierProvider<SocialAuthViewModel, void>(() => SocialAuthViewModel());
