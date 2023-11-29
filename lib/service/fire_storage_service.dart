import 'package:edtech/src/model/video_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStorageService{
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<VideoModel>> getVideoUrls() async {
    List<VideoModel> videoUrls = [];

    try {
      // Replace 'videos/' with the path to your videos in Firebase Storage
      var listResult = await _storage.ref('course/').listAll();

      for (var item in listResult.items) {
        var url = await item.getDownloadURL();
        var fullPath = item.fullPath;
        var name = item.name;

        videoUrls.add(VideoModel(name: name, uri: url, fullPath: fullPath));
      }
    } catch (e) {
      debugPrint('Error fetching videos: $e');
    }

    return videoUrls;
  }
}