import 'package:e_commerce_supabase/my_observer.dart';
import 'package:e_commerce_supabase/our_market.dart';
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
