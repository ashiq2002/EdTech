import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final void Function(bool?) onChanged;
  final Widget? child;

  const CustomCheckBox({super.key, required this.value, required this.onChanged, this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoCheckbox(value: value, onChanged: onChanged),
        child ?? Text("Check Box", style: TextStyle(color: Colors.grey.shade600),)
      ],
    );
  }
}
