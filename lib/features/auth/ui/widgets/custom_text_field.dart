import 'package:e_commerce_supabase/core/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureTxt = false,
    this.suffixIcon,
    this.keyboardType,
  });
  final String labelText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureTxt;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureTxt,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,

        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
