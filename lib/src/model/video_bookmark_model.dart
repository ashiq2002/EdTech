import 'package:edtech/src/model/video_model.dart';

class VideoBookmarkModel{
  final VideoModel video;
  final Future<Duration?> duration;

  VideoBookmarkModel(this.video, this.duration);
}