import 'package:e_commerce_supabase/core/services/sensitive_data.dart';
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
    anonKey: anonKey,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OurMarket());
}
