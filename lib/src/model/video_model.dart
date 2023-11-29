class VideoModel {
  final String name;
  final String uri;
  final String fullPath;
  final bool isCompleted;

  VideoModel(
      {required this.name,
      required this.uri,
      this.fullPath = '',
      this.isCompleted = false});
}
