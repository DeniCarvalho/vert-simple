import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vert_simple/core/core.dart';

class TextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final double radius;
  final Color backgroundColor;
  final bool autofocus;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  const TextFieldComponent({
    Key? key,
    required this.controller,
    this.label = '',
    this.placeholder = '',
    this.radius = 5.0,
    this.backgroundColor = Colors.white,
    this.autofocus = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      cursorColor: AppColors.primary,
      autofocus: autofocus,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      validator: validator,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding,
        fillColor: backgroundColor,
        hoverColor: backgroundColor,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        hintText: placeholder,
        hintStyle: const TextStyle(
          color: AppColors.system,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.system,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.danger,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.danger,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
