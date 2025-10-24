import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatelessWidget {
  const CustomCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: const CircularProgressIndicator(
          backgroundColor: AppColors.kPrimaryColor,
        ),
      ),
    );
  }
}
