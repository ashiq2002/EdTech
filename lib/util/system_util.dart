import 'package:flutter/services.dart';

class SystemUtil{
  //hide the system bottom navigation bar
  static void hideBottomNav(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top
    ]);
  }//hide bottom nav

  //change the status bar color
 static void setStatusBarColor(Color color){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color
    ));
 }
}