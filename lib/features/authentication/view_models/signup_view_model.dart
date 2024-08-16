import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/utils.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  // view model도 repository 접근 권한이 필요함.
  Future<void> signUp(BuildContext context) async {
    // "사람들에게 로딩 중인 걸 알려줘야 하니까 (???)"
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);

    // AsyncValue.guard 안에 Future 함수를 넣으면 try, catch를 자동으로 수행함
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signUp(form["email"], form["password"]);

      await users.createProfile(userCredential);
    });
    if (!context.mounted) return;
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestScreen.routeName);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
