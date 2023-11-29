import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final String? errorText;
  final TextStyle? labelStyle;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final bool isObscure;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;

  const UserInputField(
      {super.key,
      this.prefixIcon,
      this.suffixIcon,
      this.labelText,
      this.prefixIconColor,
      this.suffixIconColor,
      this.controller,
      this.isObscure = false,
      this.onChanged,
      this.onEditingComplete,
      this.labelStyle,
      this.errorText, this.textInputType, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      onChanged: onChanged,
      validator: validator,
      keyboardType: textInputType,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle ?? TextStyle(color: Colors.grey.shade600),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorText: errorText,
          prefixIconColor: prefixIconColor ?? Colors.grey.shade600,
          suffixIconColor: suffixIconColor ?? Colors.grey.shade600,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade300))),
    );
  }
}
