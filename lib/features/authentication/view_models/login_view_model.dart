import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/utils.dart';

class LoginViewModel extends AsyncNotifier {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> login(String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () => _authRepo.signIn(email, password),
    );

    // TODO: 스낵바의 작동방식 모르겠음
    if (state.hasError) {
      if (!context.mounted) return;
      showFirebaseErrorSnack(context, state.error);
    }
    // else {
    //   context.go("/");
    // }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(() => LoginViewModel());
