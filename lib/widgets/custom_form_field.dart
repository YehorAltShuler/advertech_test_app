import 'package:advertech_test_task/constants/app_colors.dart';
import 'package:advertech_test_task/custom_icons.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool isObscured;
  final FormFieldValidator<String> validator;
  final int maxLines;
  final Widget icon;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;

  const CustomFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.isObscured = false,
    required this.validator,
    this.maxLines = 1,
    this.focusNode,
    this.onFieldSubmitted,
    this.icon = const CircleAvatar(
      backgroundColor: AppColors.cream,
      child: Icon(
        CustomIcons.padlockIcon,
        color: AppColors.apricot,
      ),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscured,
      maxLines: maxLines,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        icon: icon,
      ),
      validator: validator,
      onChanged: (value) => validator(value),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
