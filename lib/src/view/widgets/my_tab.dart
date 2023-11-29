import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  final String tabName;
  const MyTab({Key? key, required this.tabName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 60,
      child: Container(
        padding: const EdgeInsets.all(12),

        child: Text(tabName, style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),),
      ),
    );
  }
}