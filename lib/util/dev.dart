import 'package:flutter/foundation.dart';

void devLog({required String tag, required String message}){
  if (kDebugMode) {
    print("[LOG] -- TAG : $tag - Error : $message");
  }
}