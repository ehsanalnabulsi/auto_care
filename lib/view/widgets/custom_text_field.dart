import 'package:auto_care/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? suffixPressed;
  // final String? Function(String?)? validator;
  final bool isPassword;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final double borderRadius;
  final bool enabled;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    this.onTap,
    this.onFieldSubmitted,
    this.padding = const EdgeInsets.symmetric(vertical: 2.0),
    this.maxLines = 1,
    this.enabled = true,
    this.validator,
    this.borderRadius = 10,
    this.isPassword = false,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixPressed,
    required this.textInputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          cursorColor: AppColors.primaryColor,
          maxLines: maxLines,
          validator: validator,
          controller: controller,
          obscureText: isPassword,
          keyboardType: textInputType,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: const BorderSide(
                      color: AppColors.primaryColor, width: 3)),
              enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide:
                      const BorderSide(color: AppColors.greyColor, width: 1.5)),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.5),
              ),
              labelText: labelText,
              hintText: hintText,
              labelStyle: Theme.of(context).textTheme.labelMedium,
              prefixIconColor: AppColors.primaryColor,
              suffixIconColor: AppColors.primaryColor,
              prefixStyle: const TextStyle(),
              suffixIcon: IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixPressed,
              ),
              enabled: enabled,
              prefixIcon: Icon(
                prefixIcon,
              ))),
    );
  }
}
