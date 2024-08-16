import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // storage의 많은 부분은 reference라는 것을 통해 작동함.
  // firebase 내의 폴더와의 link 격임.
  // file을 업로드 하면 해당 파일의 reference도 받게 됨.
  late final FirebaseStorage _storage = FirebaseStorage.instance;

  // create profile
  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  // get profile
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  // update profile
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }

  // upload avatar file
  Future<void> uploadAvatar(File file, String fileName) async {
    // 본 클래스는 Notifier를 상속하지 않기 때문에 ref에 직접 접근이 안 됨.
    // 따라서 아래 코드를 지우고 fileName을 인자로 받음
    // final fileName = ref.read(authRepo).user!.uid;

    // firestore과 많은 부분이 유사함.
    // reference를 가져와서 파일을 위한 공간을 만들고, 이후 해당 파일을 만들어 둔 reference에 저장하는 원리.

    // 아래 함수는 아직 "자리만 맡아놓은" 상황임.
    final fileRef = _storage.ref().child("avatars/$fileName");

    // 이후 실제 파일을 해당 reference에 put 함.
    await fileRef.putFile(file);
  }
}

final userRepo = Provider((ref) => UserRepository());
