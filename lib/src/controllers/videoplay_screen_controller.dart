import 'package:edtech/service/fire_storage_service.dart';
import 'package:edtech/src/model/video_bookmark_model.dart';
import 'package:edtech/src/model/video_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VideoPlayScreenController extends GetxController {
  final FireStorageService _storageService = FireStorageService();
  //videos
  final RxList<VideoModel> _assetsVideo = RxList([
    VideoModel(
      name: "Overview",
      uri: 'assets/videos/vid1.mp4',
    ),
    VideoModel(
      name: "What is flutter",
      uri: 'assets/videos/vid2.mp4',
    ),
    VideoModel(
      name: "Stateful widget",
      uri: 'assets/videos/vid3.mp4',
    ),
    VideoModel(
      name: "Learn about GetX",
      uri: 'assets/videos/vid4.mp4',
    ),
    VideoModel(
      name: "Learn about Bloc",
      uri: 'assets/videos/vid5.mp4',
    ),
    VideoModel(
      name: "Know about firebase",
      uri: 'assets/videos/vid6.mp4',
    ),
  ]);

  //video model list
  final RxList<VideoModel> _videos = RxList([]);
  List<VideoModel> get videos => _assetsVideo;

  //current index
  RxInt _index = 0.obs;
  int get index => _index.value;

  //is video loaded
  final RxBool _isSuccess = false.obs;
  bool get isSuccess => _isSuccess.value;

  //isCompleted
  final RxBool _isCompleted = false.obs;
  bool get isCompleted => _isCompleted.value;

  bool get isAllCompleted => _isAllCompleted();

  //book marked videos
  final RxList<VideoBookmarkModel> _bookmarkVideo = RxList([]);
  List<VideoBookmarkModel> get bookmarkVideo => _bookmarkVideo;

//--------------------------------------x--------------------------------

  @override
  void onInit() async {
    // TODO: implement onInit
    if (_videos.isEmpty) {
      _videos.value = await _storageService.getVideoUrls();
    }
    super.onInit();
  }

  //---------------------------go to next video
  void gotToNext(int length) {
    if (index < length - 1) {
      _index++;
      _isSuccess.value = false;
    }
    debugPrint("next : $index");
  }

  //--------------------------------go to previous video
  void goToPrevious() {
    if (0 < index) {
      _index--;
      _isSuccess.value = false;

      debugPrint("prev : $index");
    }
  }

  //------------------------update isSuccess value
  void updateIsSuccess(bool isSuccess) {
    _isSuccess.value = isSuccess;
  }

  //get current index
  void updateIndex(int index) {
    _index.value = index;
  }

  //-------------------------------------------------setAsComplete
  void setAsCompleteVideo(int index, VideoModel videoModel) {
    if (videos.contains(videoModel)) {
      videos.remove(videoModel);
      videos.insert(
          index,
          VideoModel(
              name: videoModel.name,
              uri: videoModel.uri,
              isCompleted: !videoModel.isCompleted));
    }
  }

  //--------------------------is all video completed
  bool _isAllCompleted(){
    for(VideoModel video in videos){
      if(!video.isCompleted){
        return false;
      }
    }
    return true;
  }

  //-------------------------------------------------mark all video completed
  void markAsAllCompleted(){
    _isCompleted.value = !_isCompleted.value;
  }

  //------------------------------------------------------------add to bookmark
  void addToBookmark(int index, VideoBookmarkModel video) {
    if (bookmarkVideo.isEmpty) {
      bookmarkVideo.add(video);
      return;
    }

    // Check if the index is valid
    if (index >= 0 && index < bookmarkVideo.length) {
      if (bookmarkVideo[index].video == video.video) {
        // Video already exists, update its information
        debugPrint("Updated");
        bookmarkVideo[index] = VideoBookmarkModel(video.video, video.duration);
      } else {
        // Video doesn't exist at the specified index, add it
        debugPrint("Added");
        bookmarkVideo.insert(index, video);
      }
    } else {
      // Index is out of bounds, just add the video to the end of the list
      debugPrint("Added at the end");
      bookmarkVideo.add(video);
    }
  }

}
