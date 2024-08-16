/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

admin.initializeApp();

// {} 안에 있는 파라미터는 변수처럼 작동함.
export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  .onCreate(async (snapshot, context) => {
    // snapshot은 방금 생성한 도큐먼트를 나타냄
    const spawn = require("child-process-promise").spawn;
    const video = snapshot.data();
    await spawn("ffmpeg", [
      "-i",
      video.fileURL,
      "-ss",
      "00:00:01.000",
      "-vframes",
      "1",
      "-vf",
      "scale=150:-1",
      // function이 돌아가는 동안 임시 저장소에 접근할 수 있으나, function이 끝난 직후 삭제됨
      `/tmp/${snapshot.id}.jpg`,
    ]);
    // admin으로 firebase 계정의 어느 곳이든 접근할 수 있음
    const storage = admin.storage();
    await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });
  });

// cloud functions의 system package에 기본적으로 포함된 패키지들이 있음
