import 'package:edtech/res/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final ButtonStyle? style;
  final Widget? child;
  final void Function()? onPressed;

  const CustomButton({super.key, this.style, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onPressed,
      style: style ?? ElevatedButton.styleFrom(
        minimumSize: Size(size.width * 0.65, 56),
        backgroundColor: royalBlue,
      ),
      child: child,
    );
  }
}
