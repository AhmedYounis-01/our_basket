import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:e_commerce_supabase/features/auth/ui/login_screen.dart';
import 'package:e_commerce_supabase/features/home/ui/main_home_screen.dart';
import 'package:e_commerce_supabase/my_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Supabase.initialize(
    //! Data APIs
    url: "https://mxgcypikbuuipodksmqe.supabase.co",
    //! APIs Keys
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im14Z2N5cGlrYnV1aXBvZGtzbXFlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA1OTcxMTQsImV4cCI6MjA3NjE3MzExNH0.gkxgWOEsBd3_obfBMuvTVCFEvvmuDC3PtV3tZlTVSHw",
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OurMarket());
}

class OurMarket extends StatelessWidget {
  const OurMarket({super.key});

  @override
  Widget build(BuildContext context) {
    SupabaseClient client = Supabase.instance.client;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kScaffoldColor,
        useMaterial3: true,
      ),
      // home: client.auth.currentUser != null
      //     ? MainHomeScreen()
      //     : const LoginScreen(),
      home: const LoginScreen(),
    );
  }
}
