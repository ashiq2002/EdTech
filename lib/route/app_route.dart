import 'package:edtech/route/routes_name.dart';
import 'package:edtech/src/model/user_model.dart';
import 'package:edtech/src/view/screen/bookmark_screen.dart';
import 'package:edtech/src/view/screen/video_play_screen.dart';
import 'package:edtech/src/view/screen/dashboard_screen.dart';
import 'package:edtech/src/view/screen/home_screen.dart';
import 'package:edtech/src/view/screen/otp_verification_screen.dart';
import 'package:flutter/material.dart';

class AppRoute{
  static Route<dynamic> generateRoutes(RouteSettings settings){

    //define all routes
    Map<String, Route<dynamic>> routes = {
      RoutesName.homeScreen : MaterialPageRoute(builder: (_)=> const HomeScreen()),
      RoutesName.dashboardScreen : MaterialPageRoute(builder: (_)=> const DashboardScreen()),
      RoutesName.videoPlayScreen : MaterialPageRoute(builder: (_)=> const VideoPlayScreen()),
      RoutesName.bookmarkScreen : MaterialPageRoute(builder: (_)=> const BookmarkScreen()),
      RoutesName.otpVerificationScreen : MaterialPageRoute(builder: (_)=> OtpVerificationScreen(user: settings.arguments as UserModel)),
    };

    if(routes.isEmpty){
      //if routes are empty then return empty size box
      return MaterialPageRoute(builder: (_) => const SizedBox());
    }

    return routes[settings.name]!;
  }
}