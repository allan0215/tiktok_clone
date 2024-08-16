import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repository.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepo;
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<UserProfileModel> build() async {
    /////////////
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    late UserProfileModel resultState;

    if (_authRepo.isLoggedIn) {
      final profile = await _userRepo.findProfile(_authRepo.user!.uid);
      if (profile != null && profile["uid"] != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

    return UserProfileModel.empty();
  }

  void setBio(String dateTime) {
    state = AsyncData(state.value!.copyWith(bio: dateTime));
  }

  void setName(String name) {
    state = AsyncData(
        state.value?.copyWith(name: name) ?? UserProfileModel.empty().copyWith(name: name));
  }

  Future<void> createProfile(UserCredential credentail) async {
    if (credentail.user == null) throw "Account not created";

    state = const AsyncValue.loading();
    // firestore는 json만 입력할 수 있기 때문에, profile을 json으로 변환하는 과정이 필요함.
    final profile = state.value!
      ..email = credentail.user!.email ?? "anon@anona.com"
      ..uid = credentail.user!.uid;

    await _userRepo.createProfile(profile);

    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));

    await _userRepo.updateUser(state.value!.uid, {"hasAvatar": true});
  }
}

final usersProvider =
    AsyncNotifierProvider<UsersViewModel, UserProfileModel>(() => UsersViewModel());
