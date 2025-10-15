import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:e_commerce_supabase/features/home/ui/main_home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const OurMarket());
}

class OurMarket extends StatelessWidget {
  const OurMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kScaffoldColor,
        useMaterial3: true,
      ),
      home: const MainHomeScreen(),
    );
  }
}
