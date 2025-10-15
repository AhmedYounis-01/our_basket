import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomRowWithArrowBtn extends StatelessWidget {
  const CustomRowWithArrowBtn({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            foregroundColor: AppColors.kWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: icon,
        ),
      ],
    );
  }
}
