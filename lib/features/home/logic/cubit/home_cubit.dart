import 'package:e_commerce_supabase/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  final List<Widget> pages = [HomeScreen(), Scaffold(), Scaffold(), Scaffold()];
}
