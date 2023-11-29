import 'package:flutter/material.dart';

class Util{
  static void showSnackBar(BuildContext context, {String? message}){
    if(message != null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ));
    }
  }
}