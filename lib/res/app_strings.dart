import 'package:edtech/src/model/course_tile_model.dart';

const otpBaseUrl = "https://flutter.rohitchouhan.com/email-otp/v3.php?";

//drop down item list
const List<String> dropDownList = <String>['All', 'Bookmark'];

//dummy video uri for video player
const String dummyVideo =
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

//course list
List<CourseTileModel> courses = [
  CourseTileModel("Android development", 'assets/icons/ic_android.png'),
  CourseTileModel("IOS development", 'assets/icons/ic_apple.png'),
  CourseTileModel("Java Programming", 'assets/icons/ic_java.png'),
  CourseTileModel("Zero to Hero JavaScript", 'assets/icons/ic_js.png'),
  CourseTileModel("Learn about linux", 'assets/icons/ic_linux.png'),
  CourseTileModel("MySql RDMS master", 'assets/icons/ic_mysql.png'),
  CourseTileModel("PHP OOP", 'assets/icons/ic_php.png'),
  CourseTileModel("Mastering in python", 'assets/icons/ic_python.png'),
  CourseTileModel("Learn Ruby Programming", 'assets/icons/ic_ruby.png'),
  CourseTileModel("Mastering in Swift", 'assets/icons/ic_swift.png'),
];
